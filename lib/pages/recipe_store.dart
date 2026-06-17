import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ─────────────────────────── Recipe Store (Firebase Sync) ───────────────────────
class RecipeStore extends ValueNotifier<Set<String>> {
  StreamSubscription? _firestoreSub;

  RecipeStore._() : super({}) {
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

  static final RecipeStore instance = RecipeStore._();

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
        final List<dynamic>? favorites = data['favorite_recipes'];
        
        if (favorites != null) {
          // Cập nhật lại UI dựa theo dữ liệu từ Firebase
          value = Set<String>.from(favorites.map((e) => e.toString()));
        }
      }
    });
  }

  bool isLiked(String recipeName) => value.contains(recipeName);

  Future<void> toggle(String recipeName) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return; // Bắt buộc phải đăng nhập mới được lưu

    final ref = FirebaseFirestore.instance.collection('users').doc(uid);
    final next = Set<String>.from(value);

    if (next.contains(recipeName)) {
      // 1. Cập nhật UI ngay lập tức để người dùng không thấy độ trễ
      next.remove(recipeName);
      value = next;
      
      // 2. Xoá tên công thức khỏi mảng trên Firebase
      await ref.set({
        'favorite_recipes': FieldValue.arrayRemove([recipeName])
      }, SetOptions(merge: true));
    } else {
      // 1. Cập nhật UI ngay lập tức
      next.add(recipeName);
      value = next;
      
      // 2. Thêm tên công thức vào mảng trên Firebase
      await ref.set({
        'favorite_recipes': FieldValue.arrayUnion([recipeName])
      }, SetOptions(merge: true));
    }
  }
}