import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ─────────────────────────── Workout Store (Firebase Sync) ───────────────────────
class WorkoutStore extends ValueNotifier<Set<String>> {
  StreamSubscription? _firestoreSub;

  WorkoutStore._() : super({}) {
    // Tự động lắng nghe trạng thái đăng nhập của Firebase Auth
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        _syncWithFirebase(user.uid);
      } else {
        // Xoá dữ liệu trên UI và huỷ lắng nghe khi đăng xuất
        _firestoreSub?.cancel();
        value = {}; 
      }
    });
  }

  static final WorkoutStore instance = WorkoutStore._();

  // Hàm đồng bộ hai chiều với Firebase
  void _syncWithFirebase(String uid) {
    _firestoreSub?.cancel();
    _firestoreSub = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .listen((doc) {
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        final List<dynamic>? favorites = data['favorite_workouts'];
        
        if (favorites != null) {
          // Cập nhật lại UI dựa theo dữ liệu từ Firebase
          value = Set<String>.from(favorites.map((e) => e.toString()));
        }
      }
    });
  }

  bool isSaved(String workoutName) => value.contains(workoutName);

  Future<void> toggle(String workoutName) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return; // Bắt buộc phải đăng nhập mới được lưu

    final ref = FirebaseFirestore.instance.collection('users').doc(uid);
    final next = Set<String>.from(value);

    if (next.contains(workoutName)) {
      // 1. Cập nhật UI ngay lập tức để người dùng không thấy độ trễ
      next.remove(workoutName);
      value = next;
      
      // 2. Xoá tên bài tập khỏi mảng trên Firebase
      await ref.set({
        'favorite_workouts': FieldValue.arrayRemove([workoutName])
      }, SetOptions(merge: true));
    } else {
      // 1. Cập nhật UI ngay lập tức
      next.add(workoutName);
      value = next;
      
      // 2. Thêm tên bài tập vào mảng trên Firebase
      await ref.set({
        'favorite_workouts': FieldValue.arrayUnion([workoutName])
      }, SetOptions(merge: true));
    }
  }
}