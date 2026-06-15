import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String? get uid => FirebaseAuth.instance.currentUser?.uid;

  // Lưu dữ liệu tổng quát (huyết áp, đường huyết, cân nặng...)
  Future<void> saveHealthRecord(String collectionName, Map<String, dynamic> data) async {
    if (uid == null) return;
    await _db.collection('users').doc(uid).collection(collectionName).add({
      ...data,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Lấy dữ liệu theo thời gian thực
  Stream<QuerySnapshot> getRecordsStream(String collectionName) {
    return _db.collection('users')
        .doc(uid)
        .collection(collectionName)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}