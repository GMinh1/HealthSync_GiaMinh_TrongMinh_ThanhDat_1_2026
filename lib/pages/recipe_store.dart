import 'package:flutter/material.dart';

// ─────────────────────────── Recipe Store (Global) ───────────────────────
// ValueNotifier dùng chung giữa RecipePage và FavoriteRecipesPage.
// Khởi tạo một lần ở main.dart hoặc dùng singleton bên dưới.

class RecipeStore extends ValueNotifier<Set<String>> {
  RecipeStore._() : super({});

  static final RecipeStore instance = RecipeStore._();

  bool isLiked(String recipeName) => value.contains(recipeName);

  void toggle(String recipeName) {
    final next = Set<String>.from(value);
    if (next.contains(recipeName)) {
      next.remove(recipeName);
    } else {
      next.add(recipeName);
    }
    value = next;
  }
}
