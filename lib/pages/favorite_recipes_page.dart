import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import 'recipe_data.dart';
import 'recipe_store.dart';
import 'recipe_page.dart';

// ─────────────────────────── Favorite Recipes Page ───────────────────────
class FavoriteRecipesPage extends StatelessWidget {
  const FavoriteRecipesPage({super.key});

  List<RecipeData> _likedRecipes(Set<String> liked) =>
      allRecipes.where((r) => liked.contains(r.name)).toList();

  void _showDetail(BuildContext context, RecipeData recipe) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => RecipeDetailSheet(recipe: recipe),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: kText,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Túi công thức',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kText,
          ),
        ),
        centerTitle: false,
      ),
      body: ValueListenableBuilder<Set<String>>(
        valueListenable: RecipeStore.instance,
        builder: (context, liked, __) {
          final recipes = _likedRecipes(liked);

          if (recipes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: const BoxDecoration(
                      color: kGreenLight,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      color: kGreen,
                      size: 44,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Chưa có công thức nào',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Nhấn ❤️ trên công thức bạn thích\nđể lưu vào đây nhé!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: kSubText,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.78,
            ),
            itemCount: recipes.length,
            itemBuilder: (_, i) => _FavCard(
              data: recipes[i],
              onTap: () => _showDetail(context, recipes[i]),
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────── Fav Recipe Card ─────────────────────────────
class _FavCard extends StatelessWidget {
  final RecipeData data;
  final VoidCallback onTap;
  const _FavCard({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  RecipeNetworkImage(
                    url: data.imageUrl,
                    fallbackGradient: data.gradient,
                  ),
                  // Nút bỏ yêu thích
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => RecipeStore.instance.toggle(data.name),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: kGreen,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: kText,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.local_fire_department,
                        size: 13,
                        color: Color(0xFFFF6B35),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        data.kcal,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF555555),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.access_time, size: 13, color: kSubText),
                      const SizedBox(width: 3),
                      Text(
                        data.prepTime,
                        style: const TextStyle(
                          fontSize: 12,
                          color: kSubText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
