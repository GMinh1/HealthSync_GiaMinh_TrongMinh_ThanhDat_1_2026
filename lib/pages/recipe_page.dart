import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/shared_widgets.dart';

// ─────────────────────────── Data model ─────────────────────────────────
class _RecipeData {
  final String name, kcal;
  final List<Color> gradient;
  final IconData icon;
  const _RecipeData(this.name, this.kcal, this.gradient, this.icon);
}

// ─────────────────────────── Recipe Page ────────────────────────────────
class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  int _cat = 0;

  final _cats = ['🔥 Hot', '🌿 Low-cal', '👶 Kids', '🥄 Soup', '🍛 Curry'];

  static const _recipes = [
    _RecipeData('Cast-Iron Steak', '760 kcal', [
      Color(0xFF5D4037),
      Color(0xFF8D6E63),
    ], Icons.outdoor_grill),
    _RecipeData('Pan-Seared Steak', '712 kcal', [
      Color(0xFF4E342E),
      Color(0xFF795548),
    ], Icons.local_fire_department),
    _RecipeData('Crisp & Creamy Cucumber Protein Bowl', '320 kcal', [
      Color(0xFF2E7D32),
      Color(0xFF66BB6A),
    ], Icons.eco),
    _RecipeData('Fresh Green & Protein Plate', '280 kcal', [
      Color(0xFF1B5E20),
      Color(0xFF43A047),
    ], Icons.grass),
    _RecipeData('Grilled Chicken Salad', '450 kcal', [
      Color(0xFFE65100),
      Color(0xFFFF9800),
    ], Icons.set_meal),
    _RecipeData('Avocado Toast', '380 kcal', [
      Color(0xFF33691E),
      Color(0xFF8BC34A),
    ], Icons.breakfast_dining),
  ];

  @override
  Widget build(BuildContext context) {
    return PageGradient(
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header — không có VIP / coin
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recipe',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: kText,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "It's Tuesday, May 26th.",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const Text(
                    "Can't decide what to eat?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kText,
                    ),
                  ),
                ],
              ),
            ),

            // Chỉ card Favorite (bỏ Scan & Bite Box)
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: _FavoriteCard(),
            ),

            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Text(
                'Recipes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kText,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Category chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Row(
                children: List.generate(_cats.length, (i) {
                  final sel = i == _cat;
                  return GestureDetector(
                    onTap: () => setState(() => _cat = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: sel ? kGreen : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: sel
                            ? [
                                const BoxShadow(
                                  color: Color(0x402DCB73),
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                ),
                              ]
                            : [],
                      ),
                      child: Text(
                        _cats[i],
                        style: TextStyle(
                          color: sel ? Colors.white : kSubText,
                          fontSize: 13,
                          fontWeight: sel ? FontWeight.w700 : FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Recipe grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.78,
                ),
                itemCount: _recipes.length,
                itemBuilder: (_, i) => _RecipeCard(data: _recipes[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────── Favorite Card ──────────────────────────────
class _FavoriteCard extends StatelessWidget {
  const _FavoriteCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFFFD6E8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.favorite,
              color: Color(0xFFE91E8C),
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'favorite',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kText,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Your saved recipes',
                  style: TextStyle(fontSize: 12, color: kSubText),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFFCCCCCC)),
        ],
      ),
    );
  }
}

// ─────────────────────────── Recipe Card ────────────────────────────────
class _RecipeCard extends StatefulWidget {
  final _RecipeData data;
  const _RecipeCard({required this.data});

  @override
  State<_RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<_RecipeCard> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Ảnh / gradient placeholder
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.data.gradient,
                ),
              ),
              child: Center(
                child: Icon(
                  widget.data.icon,
                  size: 60,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ),
          ),
          // Thông tin
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data.name,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.data.kcal,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF555555),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _liked = !_liked),
                      child: Row(
                        children: [
                          Icon(
                            _liked ? Icons.favorite : Icons.favorite_border,
                            color: kGreen,
                            size: 18,
                          ),
                          const SizedBox(width: 2),
                          const Icon(Icons.add, color: kGreen, size: 14),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
