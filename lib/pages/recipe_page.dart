import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/shared_widgets.dart';

// ─────────────────────────── Data model ─────────────────────────────────
class _Ingredient {
  final String name;
  final String amount;
  final IconData icon;
  const _Ingredient(this.name, this.amount, this.icon);
}

enum RecipeCategory { hot, lowCal, kids, soup, curry }

class _RecipeData {
  final String name, kcal;
  final String imageUrl;
  final List<Color> gradient;
  final String prepTime;
  final String servings;
  final RecipeCategory category;
  final List<_Ingredient> ingredients;
  const _RecipeData(
    this.name,
    this.kcal,
    this.imageUrl,
    this.gradient, {
    required this.category,
    required this.prepTime,
    required this.servings,
    required this.ingredients,
  });
}

// ─────────────────────────── All Recipes ────────────────────────────────
const _allRecipes = [
  // ── 🔥 HOT ──
  _RecipeData(
    'Cast-Iron Steak',
    '760 kcal',
    'https://images.unsplash.com/photo-1546964124-0cce460f38ef?w=400&q=80',
    [Color(0xFF5D4037), Color(0xFF8D6E63)],
    category: RecipeCategory.hot,
    prepTime: '25 min',
    servings: '2',
    ingredients: [
      _Ingredient('Ribeye steak', '300g', Icons.set_meal),
      _Ingredient('Butter', '2 tbsp', Icons.opacity),
      _Ingredient('Garlic cloves', '3 cloves', Icons.grass),
      _Ingredient('Fresh rosemary', '2 sprigs', Icons.eco),
      _Ingredient('Sea salt', '1 tsp', Icons.grain),
      _Ingredient('Black pepper', '½ tsp', Icons.grain),
      _Ingredient('Olive oil', '1 tbsp', Icons.water_drop),
    ],
  ),
  _RecipeData(
    'Spicy Buffalo Wings',
    '620 kcal',
    'https://images.unsplash.com/photo-1567620832903-9fc6debc209f?w=400&q=80',
    [Color(0xFFBF360C), Color(0xFFE64A19)],
    category: RecipeCategory.hot,
    prepTime: '40 min',
    servings: '3',
    ingredients: [
      _Ingredient('Chicken wings', '500g', Icons.set_meal),
      _Ingredient('Hot sauce', '4 tbsp', Icons.local_fire_department),
      _Ingredient('Butter', '2 tbsp', Icons.opacity),
      _Ingredient('Garlic powder', '1 tsp', Icons.grain),
      _Ingredient('Paprika', '1 tsp', Icons.grain),
      _Ingredient('Salt', '½ tsp', Icons.grain),
      _Ingredient('Vegetable oil', '2 tbsp', Icons.water_drop),
    ],
  ),
  _RecipeData(
    'Spicy Korean Fried Rice',
    '580 kcal',
    'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=400&q=80',
    [Color(0xFFC62828), Color(0xFFEF5350)],
    category: RecipeCategory.hot,
    prepTime: '20 min',
    servings: '2',
    ingredients: [
      _Ingredient('Cooked rice', '300g', Icons.grain),
      _Ingredient('Gochujang paste', '2 tbsp', Icons.local_fire_department),
      _Ingredient('Kimchi', '100g', Icons.eco),
      _Ingredient('Egg', '2 pcs', Icons.egg),
      _Ingredient('Sesame oil', '1 tbsp', Icons.water_drop),
      _Ingredient('Green onion', '2 stalks', Icons.grass),
      _Ingredient('Soy sauce', '1 tbsp', Icons.water_drop),
    ],
  ),
  _RecipeData(
    'Chili Con Carne',
    '690 kcal',
    'https://images.unsplash.com/photo-1623428187969-5da2dcea5ebf?w=400&q=80',
    [Color(0xFF6D1A0E), Color(0xFFB71C1C)],
    category: RecipeCategory.hot,
    prepTime: '50 min',
    servings: '4',
    ingredients: [
      _Ingredient('Ground beef', '400g', Icons.set_meal),
      _Ingredient('Kidney beans', '200g', Icons.grain),
      _Ingredient('Canned tomatoes', '400g', Icons.circle),
      _Ingredient('Chili powder', '2 tsp', Icons.local_fire_department),
      _Ingredient('Cumin', '1 tsp', Icons.grain),
      _Ingredient('Onion', '1 large', Icons.circle),
      _Ingredient('Garlic', '3 cloves', Icons.grass),
    ],
  ),

  // ── 🌿 LOW-CAL ──
  _RecipeData(
    'Crisp Cucumber Protein Bowl',
    '320 kcal',
    'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&q=80',
    [Color(0xFF2E7D32), Color(0xFF66BB6A)],
    category: RecipeCategory.lowCal,
    prepTime: '10 min',
    servings: '1',
    ingredients: [
      _Ingredient('Greek yogurt', '150g', Icons.water_drop),
      _Ingredient('Cucumber', '1 medium', Icons.grass),
      _Ingredient('Chickpeas', '80g', Icons.grain),
      _Ingredient('Cherry tomatoes', '8 pcs', Icons.circle),
      _Ingredient('Fresh dill', '1 tbsp', Icons.eco),
      _Ingredient('Lemon juice', '1 tbsp', Icons.wb_sunny),
      _Ingredient('Olive oil', '1 tsp', Icons.water_drop),
    ],
  ),
  _RecipeData(
    'Fresh Green & Protein Plate',
    '280 kcal',
    'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400&q=80',
    [Color(0xFF1B5E20), Color(0xFF43A047)],
    category: RecipeCategory.lowCal,
    prepTime: '15 min',
    servings: '1',
    ingredients: [
      _Ingredient('Grilled tofu', '100g', Icons.square),
      _Ingredient('Edamame', '60g', Icons.grass),
      _Ingredient('Spinach', '50g', Icons.eco),
      _Ingredient('Avocado', '½ piece', Icons.circle),
      _Ingredient('Quinoa', '80g', Icons.grain),
      _Ingredient('Sesame seeds', '1 tsp', Icons.grain),
      _Ingredient('Soy sauce', '1 tbsp', Icons.water_drop),
    ],
  ),
  _RecipeData(
    'Grilled Chicken Salad',
    '450 kcal',
    'https://images.unsplash.com/photo-1607532941433-304659e8198a?w=400&q=80',
    [Color(0xFF558B2F), Color(0xFF8BC34A)],
    category: RecipeCategory.lowCal,
    prepTime: '30 min',
    servings: '2',
    ingredients: [
      _Ingredient('Chicken breast', '200g', Icons.set_meal),
      _Ingredient('Romaine lettuce', '100g', Icons.eco),
      _Ingredient('Cherry tomatoes', '10 pcs', Icons.circle),
      _Ingredient('Parmesan', '20g', Icons.grain),
      _Ingredient('Caesar dressing', '2 tbsp', Icons.water_drop),
      _Ingredient('Lemon', '½ piece', Icons.wb_sunny),
      _Ingredient('Black pepper', '¼ tsp', Icons.grain),
    ],
  ),
  _RecipeData(
    'Tuna Zucchini Rolls',
    '210 kcal',
    'https://images.unsplash.com/photo-1562802378-063ec186a863?w=400&q=80',
    [Color(0xFF00695C), Color(0xFF26A69A)],
    category: RecipeCategory.lowCal,
    prepTime: '15 min',
    servings: '2',
    ingredients: [
      _Ingredient('Zucchini', '2 medium', Icons.grass),
      _Ingredient('Canned tuna', '120g', Icons.set_meal),
      _Ingredient('Cream cheese', '2 tbsp', Icons.opacity),
      _Ingredient('Lemon juice', '1 tsp', Icons.wb_sunny),
      _Ingredient('Dill', '1 tsp', Icons.eco),
      _Ingredient('Salt & pepper', 'to taste', Icons.grain),
    ],
  ),

  // ── 👶 KIDS ──
  _RecipeData(
    'Avocado Toast',
    '380 kcal',
    'https://images.unsplash.com/photo-1603046891726-36bfd957e0bf?w=400&q=80',
    [Color(0xFF33691E), Color(0xFF8BC34A)],
    category: RecipeCategory.kids,
    prepTime: '10 min',
    servings: '1',
    ingredients: [
      _Ingredient('Sourdough bread', '2 slices', Icons.breakfast_dining),
      _Ingredient('Ripe avocado', '1 piece', Icons.circle),
      _Ingredient('Eggs', '2 eggs', Icons.egg),
      _Ingredient('Lemon juice', '1 tsp', Icons.wb_sunny),
      _Ingredient('Sea salt', '½ tsp', Icons.grain),
    ],
  ),
  _RecipeData(
    'Mini Pancakes',
    '310 kcal',
    'https://images.unsplash.com/photo-1528207776546-365bb710ee93?w=400&q=80',
    [Color(0xFFF57F17), Color(0xFFFFCC02)],
    category: RecipeCategory.kids,
    prepTime: '20 min',
    servings: '2',
    ingredients: [
      _Ingredient('All-purpose flour', '150g', Icons.grain),
      _Ingredient('Milk', '200ml', Icons.water_drop),
      _Ingredient('Egg', '1 pc', Icons.egg),
      _Ingredient('Butter', '1 tbsp', Icons.opacity),
      _Ingredient('Sugar', '1 tbsp', Icons.grain),
      _Ingredient('Baking powder', '1 tsp', Icons.grain),
      _Ingredient('Maple syrup', '2 tbsp', Icons.water_drop),
    ],
  ),
  _RecipeData(
    'Cheesy Veggie Omelette',
    '340 kcal',
    'https://images.unsplash.com/photo-1510693206972-df098062cb71?w=400&q=80',
    [Color(0xFFF9A825), Color(0xFFFFD54F)],
    category: RecipeCategory.kids,
    prepTime: '15 min',
    servings: '1',
    ingredients: [
      _Ingredient('Eggs', '3 pcs', Icons.egg),
      _Ingredient('Cheddar cheese', '30g', Icons.grain),
      _Ingredient('Bell pepper', '¼ piece', Icons.circle),
      _Ingredient('Spinach', '20g', Icons.eco),
      _Ingredient('Milk', '2 tbsp', Icons.water_drop),
      _Ingredient('Butter', '1 tsp', Icons.opacity),
      _Ingredient('Salt', 'a pinch', Icons.grain),
    ],
  ),
  _RecipeData(
    'Banana Oat Cookies',
    '220 kcal',
    'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=400&q=80',
    [Color(0xFFE65100), Color(0xFFFF8A65)],
    category: RecipeCategory.kids,
    prepTime: '25 min',
    servings: '12',
    ingredients: [
      _Ingredient('Ripe banana', '2 pcs', Icons.circle),
      _Ingredient('Rolled oats', '200g', Icons.grain),
      _Ingredient('Honey', '2 tbsp', Icons.water_drop),
      _Ingredient('Chocolate chips', '50g', Icons.circle),
      _Ingredient('Cinnamon', '½ tsp', Icons.grain),
    ],
  ),

  // ── 🥄 SOUP ──
  _RecipeData(
    'Creamy Tomato Soup',
    '290 kcal',
    'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=400&q=80',
    [Color(0xFFB71C1C), Color(0xFFE57373)],
    category: RecipeCategory.soup,
    prepTime: '30 min',
    servings: '3',
    ingredients: [
      _Ingredient('Canned tomatoes', '800g', Icons.circle),
      _Ingredient('Heavy cream', '100ml', Icons.water_drop),
      _Ingredient('Onion', '1 large', Icons.circle),
      _Ingredient('Garlic', '2 cloves', Icons.grass),
      _Ingredient('Basil', '5 leaves', Icons.eco),
      _Ingredient('Olive oil', '2 tbsp', Icons.water_drop),
      _Ingredient('Salt & pepper', 'to taste', Icons.grain),
    ],
  ),
  _RecipeData(
    'Chicken Noodle Soup',
    '380 kcal',
    'https://images.unsplash.com/photo-1603105037880-880cd4edfb0d?w=400&q=80',
    [Color(0xFFE65100), Color(0xFFFFB74D)],
    category: RecipeCategory.soup,
    prepTime: '45 min',
    servings: '4',
    ingredients: [
      _Ingredient('Chicken thighs', '300g', Icons.set_meal),
      _Ingredient('Egg noodles', '150g', Icons.grain),
      _Ingredient('Carrot', '2 pcs', Icons.circle),
      _Ingredient('Celery', '2 stalks', Icons.grass),
      _Ingredient('Onion', '1 medium', Icons.circle),
      _Ingredient('Chicken broth', '1.5L', Icons.water_drop),
      _Ingredient('Thyme', '1 tsp', Icons.eco),
    ],
  ),
  _RecipeData(
    'Miso Tofu Soup',
    '180 kcal',
    'https://images.unsplash.com/photo-1569050467447-ce54b3bbc37d?w=400&q=80',
    [Color(0xFF4E342E), Color(0xFF8D6E63)],
    category: RecipeCategory.soup,
    prepTime: '15 min',
    servings: '2',
    ingredients: [
      _Ingredient('White miso paste', '3 tbsp', Icons.opacity),
      _Ingredient('Silken tofu', '200g', Icons.square),
      _Ingredient('Wakame seaweed', '10g', Icons.eco),
      _Ingredient('Green onion', '2 stalks', Icons.grass),
      _Ingredient('Dashi stock', '600ml', Icons.water_drop),
    ],
  ),
  _RecipeData(
    'Pumpkin Coconut Soup',
    '260 kcal',
    'https://images.unsplash.com/photo-1476718406336-bb5a9690ee2a?w=400&q=80',
    [Color(0xFFE65100), Color(0xFFFF7043)],
    category: RecipeCategory.soup,
    prepTime: '35 min',
    servings: '4',
    ingredients: [
      _Ingredient('Pumpkin', '600g', Icons.circle),
      _Ingredient('Coconut milk', '200ml', Icons.water_drop),
      _Ingredient('Vegetable broth', '500ml', Icons.water_drop),
      _Ingredient('Ginger', '1 tsp', Icons.grass),
      _Ingredient('Garlic', '2 cloves', Icons.grass),
      _Ingredient('Curry powder', '1 tsp', Icons.grain),
      _Ingredient('Salt & pepper', 'to taste', Icons.grain),
    ],
  ),

  // ── 🍛 CURRY ──
  _RecipeData(
    'Butter Chicken Curry',
    '620 kcal',
    'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=400&q=80',
    [Color(0xFFE65100), Color(0xFFFF8F00)],
    category: RecipeCategory.curry,
    prepTime: '40 min',
    servings: '3',
    ingredients: [
      _Ingredient('Chicken breast', '400g', Icons.set_meal),
      _Ingredient('Butter', '3 tbsp', Icons.opacity),
      _Ingredient('Heavy cream', '150ml', Icons.water_drop),
      _Ingredient('Tomato puree', '200g', Icons.circle),
      _Ingredient('Garam masala', '2 tsp', Icons.grain),
      _Ingredient('Ginger paste', '1 tsp', Icons.grass),
      _Ingredient('Garlic paste', '1 tsp', Icons.grass),
    ],
  ),
  _RecipeData(
    'Thai Green Curry',
    '540 kcal',
    'https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?w=400&q=80',
    [Color(0xFF2E7D32), Color(0xFF66BB6A)],
    category: RecipeCategory.curry,
    prepTime: '30 min',
    servings: '2',
    ingredients: [
      _Ingredient('Coconut milk', '400ml', Icons.water_drop),
      _Ingredient('Green curry paste', '3 tbsp', Icons.eco),
      _Ingredient('Chicken or tofu', '300g', Icons.set_meal),
      _Ingredient('Thai basil', '10 leaves', Icons.eco),
      _Ingredient('Fish sauce', '2 tbsp', Icons.water_drop),
      _Ingredient('Lime juice', '1 tbsp', Icons.wb_sunny),
      _Ingredient('Jasmine rice', '200g', Icons.grain),
    ],
  ),
  _RecipeData(
    'Japanese Katsu Curry',
    '710 kcal',
    'https://images.unsplash.com/photo-1574484284002-952d92456975?w=400&q=80',
    [Color(0xFF6D4C41), Color(0xFFA1887F)],
    category: RecipeCategory.curry,
    prepTime: '45 min',
    servings: '2',
    ingredients: [
      _Ingredient('Pork cutlet', '300g', Icons.set_meal),
      _Ingredient('Japanese curry roux', '100g', Icons.grain),
      _Ingredient('Potato', '2 medium', Icons.circle),
      _Ingredient('Carrot', '1 pc', Icons.circle),
      _Ingredient('Onion', '1 large', Icons.circle),
      _Ingredient('Panko breadcrumbs', '50g', Icons.grain),
      _Ingredient('Steamed rice', '300g', Icons.grain),
    ],
  ),
  _RecipeData(
    'Chickpea Coconut Curry',
    '470 kcal',
    'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=400&q=80',
    [Color(0xFFFF6F00), Color(0xFFFFA000)],
    category: RecipeCategory.curry,
    prepTime: '25 min',
    servings: '3',
    ingredients: [
      _Ingredient('Chickpeas', '400g', Icons.grain),
      _Ingredient('Coconut milk', '300ml', Icons.water_drop),
      _Ingredient('Diced tomatoes', '200g', Icons.circle),
      _Ingredient('Spinach', '80g', Icons.eco),
      _Ingredient('Curry powder', '2 tsp', Icons.grain),
      _Ingredient('Turmeric', '½ tsp', Icons.grain),
      _Ingredient('Onion', '1 medium', Icons.circle),
    ],
  ),
];

// ─────────────────────────── Recipe Page ────────────────────────────────
class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  int _cat = 0;

  static const _cats = [
    ('🔥 Hot', RecipeCategory.hot),
    ('🌿 Low-cal', RecipeCategory.lowCal),
    ('🎂 Cake', RecipeCategory.kids),
    ('🥄 Soup', RecipeCategory.soup),
    ('🍛 Curry', RecipeCategory.curry),
  ];

  List<_RecipeData> get _filtered =>
      _allRecipes.where((r) => r.category == _cats[_cat].$2).toList();

  void _showRecipeDetail(BuildContext context, _RecipeData recipe) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _RecipeDetailSheet(recipe: recipe),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recipes = _filtered;

    return PageGradient(
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    "Ăn uống điều độ, tốt cho sức khỏe!",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const Text(
                    "Không biết nên ăn gì?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kText,
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: _FavoriteCard(),
            ),

            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Text(
                'Các công thức nấu ăn',
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
                        _cats[i].$1,
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
                key: ValueKey(_cat), // reset scroll khi đổi category
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.78,
                ),
                itemCount: recipes.length,
                itemBuilder: (_, i) => _RecipeCard(
                  data: recipes[i],
                  onTap: () => _showRecipeDetail(context, recipes[i]),
                ),
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
                  'Yêu thích',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kText,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Lưu công thức của bạn',
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
  final VoidCallback onTap;
  const _RecipeCard({required this.data, required this.onTap});

  @override
  State<_RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<_RecipeCard> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
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
              child: _NetworkImage(
                url: widget.data.imageUrl,
                fallbackGradient: widget.data.gradient,
              ),
            ),
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
      ),
    );
  }
}

// ─────────────────────────── Network Image Widget ───────────────────────
class _NetworkImage extends StatelessWidget {
  final String url;
  final List<Color> fallbackGradient;
  const _NetworkImage({required this.url, required this.fallbackGradient});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (_, child, progress) {
        if (progress == null) return child;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: fallbackGradient,
            ),
          ),
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.white54,
              strokeWidth: 2,
            ),
          ),
        );
      },
      errorBuilder: (_, __, ___) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: fallbackGradient,
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.image_not_supported,
            color: Colors.white54,
            size: 40,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────── Recipe Detail Bottom Sheet ─────────────────
class _RecipeDetailSheet extends StatelessWidget {
  final _RecipeData recipe;
  const _RecipeDetailSheet({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDDDDDD),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        width: 64,
                        height: 64,
                        child: _NetworkImage(
                          url: recipe.imageUrl,
                          fallbackGradient: recipe.gradient,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipe.name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: kText,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              _InfoChip(
                                icon: Icons.local_fire_department,
                                label: recipe.kcal,
                                color: const Color(0xFFFF6B35),
                              ),
                              _InfoChip(
                                icon: Icons.access_time,
                                label: recipe.prepTime,
                                color: kGreen,
                              ),
                              _InfoChip(
                                icon: Icons.people_outline,
                                label: '${recipe.servings} servings',
                                color: const Color(0xFF5C6BC0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: Color(0xFFF0F0F0)),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 20,
                      decoration: BoxDecoration(
                        color: kGreen,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Ingredients (${recipe.ingredients.length})',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: kText,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  controller: controller,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                  itemCount: recipe.ingredients.length,
                  separatorBuilder: (_, __) =>
                      const Divider(height: 1, color: Color(0xFFF5F5F5)),
                  itemBuilder: (_, i) {
                    final ing = recipe.ingredients[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: kGreenLight,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(ing.icon, color: kGreen, size: 22),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              ing.name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: kText,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              ing.amount,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF444444),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────── Info Chip ──────────────────────────────────
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
