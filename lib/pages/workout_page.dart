import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/shared_widgets.dart';

// ─────────────────────────── Data model ─────────────────────────────────
class _Exercise {
  final String name;
  final String sets;
  final IconData icon;
  const _Exercise(this.name, this.sets, this.icon);
}

enum WorkoutCategory { yoga, cardio, muscle }

class _WorkoutData {
  final String name, duration, level;
  final String imageUrl;
  final List<Color> gradient;
  final WorkoutCategory category;
  final List<_Exercise> exercises;
  const _WorkoutData(
    this.name,
    this.duration,
    this.level,
    this.imageUrl,
    this.gradient, {
    required this.category,
    required this.exercises,
  });
}

// ─────────────────────────── All Workouts ────────────────────────────────
const _allWorkouts = [
  // ── 🧘 YOGA ──
  _WorkoutData(
    'Morning Flow Yoga',
    '30 min',
    'Beginner',
    'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400&q=80',
    [Color(0xFF6A1B9A), Color(0xFFAB47BC)],
    category: WorkoutCategory.yoga,
    exercises: [
      _Exercise('Child\'s Pose', '3 × 60s', Icons.self_improvement),
      _Exercise('Downward Dog', '3 × 45s', Icons.fitness_center),
      _Exercise('Warrior I', '3 × 30s each', Icons.sports_martial_arts),
      _Exercise('Warrior II', '3 × 30s each', Icons.sports_martial_arts),
      _Exercise('Tree Pose', '2 × 45s each', Icons.nature),
      _Exercise('Corpse Pose', '1 × 5 min', Icons.bedtime),
    ],
  ),
  _WorkoutData(
    'Deep Stretch & Relax',
    '45 min',
    'Beginner',
    'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=400&q=80',
    [Color(0xFF4527A0), Color(0xFF7E57C2)],
    category: WorkoutCategory.yoga,
    exercises: [
      _Exercise('Cat-Cow Stretch', '3 × 10 reps', Icons.pets),
      _Exercise('Seated Forward Fold', '3 × 60s', Icons.accessibility_new),
      _Exercise('Pigeon Pose', '2 × 90s each', Icons.self_improvement),
      _Exercise('Supine Twist', '2 × 60s each', Icons.rotate_right),
      _Exercise('Legs Up the Wall', '1 × 5 min', Icons.vertical_align_top),
    ],
  ),
  _WorkoutData(
    'Power Yoga Flow',
    '50 min',
    'Intermediate',
    'https://images.unsplash.com/photo-1588286840104-8957b019727f?w=400&q=80',
    [Color(0xFF1A237E), Color(0xFF3949AB)],
    category: WorkoutCategory.yoga,
    exercises: [
      _Exercise('Sun Salutation A', '5 rounds', Icons.wb_sunny),
      _Exercise('Crescent Lunge', '3 × 30s each', Icons.sports_martial_arts),
      _Exercise('Plank to Chaturanga', '3 × 10 reps', Icons.fitness_center),
      _Exercise('Boat Pose', '3 × 30s', Icons.directions_boat),
      _Exercise('Bridge Pose', '3 × 45s', Icons.architecture),
      _Exercise('Wheel Pose', '2 × 20s', Icons.radio_button_unchecked),
    ],
  ),
  _WorkoutData(
    'Yoga for Flexibility',
    '40 min',
    'All levels',
    'https://images.unsplash.com/photo-1518611012118-696072aa579a?w=400&q=80',
    [Color(0xFF880E4F), Color(0xFFC2185B)],
    category: WorkoutCategory.yoga,
    exercises: [
      _Exercise('Standing Side Stretch', '3 × 30s each', Icons.accessibility),
      _Exercise('Low Lunge', '3 × 45s each', Icons.sports_martial_arts),
      _Exercise('Butterfly Pose', '3 × 60s', Icons.flutter_dash),
      _Exercise('Seated Spinal Twist', '2 × 45s each', Icons.rotate_left),
      _Exercise('Happy Baby Pose', '2 × 60s', Icons.child_care),
    ],
  ),

  // ── 🏃 CARDIO ──
  _WorkoutData(
    'HIIT Blast',
    '25 min',
    'Intermediate',
    'https://images.unsplash.com/photo-1601422407692-ec4eeec1d9b3?w=400&q=80',
    [Color(0xFFBF360C), Color(0xFFE64A19)],
    category: WorkoutCategory.cardio,
    exercises: [
      _Exercise('Jumping Jacks', '4 × 40s', Icons.directions_run),
      _Exercise('High Knees', '4 × 40s', Icons.directions_run),
      _Exercise('Burpees', '4 × 10 reps', Icons.fitness_center),
      _Exercise('Mountain Climbers', '4 × 40s', Icons.terrain),
      _Exercise('Jump Squats', '4 × 15 reps', Icons.arrow_upward),
      _Exercise('Sprint in Place', '4 × 30s', Icons.speed),
    ],
  ),
  _WorkoutData(
    'Jump Rope Cardio',
    '20 min',
    'Beginner',
    'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=400&q=80',
    [Color(0xFFE65100), Color(0xFFFF8F00)],
    category: WorkoutCategory.cardio,
    exercises: [
      _Exercise('Basic Jump', '3 × 2 min', Icons.loop),
      _Exercise('Alternate Foot Jump', '3 × 90s', Icons.swap_horiz),
      _Exercise('Double Unders', '3 × 20 reps', Icons.fast_forward),
      _Exercise('Rest Walk', '3 × 30s', Icons.directions_walk),
    ],
  ),
  _WorkoutData(
    'Dance Cardio',
    '35 min',
    'All levels',
    'https://images.unsplash.com/photo-1535743686920-55e4145369b9?w=400&q=80',
    [Color(0xFFAD1457), Color(0xFFE91E63)],
    category: WorkoutCategory.cardio,
    exercises: [
      _Exercise('Warm-up March', '1 × 3 min', Icons.directions_walk),
      _Exercise('Salsa Steps', '3 × 2 min', Icons.music_note),
      _Exercise('Hip Circles', '3 × 60s', Icons.loop),
      _Exercise('Side Steps', '3 × 90s', Icons.swap_horiz),
      _Exercise('Cool-down Sway', '1 × 3 min', Icons.air),
    ],
  ),
  _WorkoutData(
    'Stair Climb Circuit',
    '30 min',
    'Intermediate',
    'https://images.unsplash.com/photo-1470258986370-9c651f0a32ef?w=400&q=80',
    [Color(0xFF004D40), Color(0xFF00897B)],
    category: WorkoutCategory.cardio,
    exercises: [
      _Exercise('Stair Run Up', '5 × 2 floors', Icons.stairs),
      _Exercise('Step-ups', '4 × 20 reps', Icons.vertical_align_top),
      _Exercise('Box Jumps', '3 × 12 reps', Icons.arrow_upward),
      _Exercise('Lateral Step-overs', '3 × 16 reps', Icons.swap_horiz),
      _Exercise('Stair Sprints', '5 × 30s', Icons.speed),
    ],
  ),

  // ── 💪 BUILD MUSCLE ──
  _WorkoutData(
    'Upper Body Power',
    '45 min',
    'Intermediate',
    'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=400&q=80',
    [Color(0xFF1B2A4A), Color(0xFF37474F)],
    category: WorkoutCategory.muscle,
    exercises: [
      _Exercise('Push-ups', '4 × 15 reps', Icons.fitness_center),
      _Exercise('Pull-ups', '4 × 8 reps', Icons.arrow_upward),
      _Exercise('Dumbbell Shoulder Press', '3 × 12 reps', Icons.fitness_center),
      _Exercise('Tricep Dips', '3 × 15 reps', Icons.fitness_center),
      _Exercise('Bicep Curls', '3 × 12 reps', Icons.fitness_center),
      _Exercise('Lat Raises', '3 × 12 reps', Icons.open_with),
    ],
  ),
  _WorkoutData(
    'Leg Day Builder',
    '50 min',
    'Intermediate',
    'https://images.unsplash.com/photo-1434682881908-b43d0467b798?w=400&q=80',
    [Color(0xFF212121), Color(0xFF455A64)],
    category: WorkoutCategory.muscle,
    exercises: [
      _Exercise('Back Squats', '4 × 10 reps', Icons.fitness_center),
      _Exercise('Romanian Deadlift', '4 × 10 reps', Icons.fitness_center),
      _Exercise('Leg Press', '3 × 12 reps', Icons.fitness_center),
      _Exercise('Walking Lunges', '3 × 16 reps', Icons.directions_walk),
      _Exercise('Calf Raises', '4 × 20 reps', Icons.arrow_upward),
      _Exercise('Glute Bridges', '3 × 15 reps', Icons.fitness_center),
    ],
  ),
  _WorkoutData(
    'Core & Abs Shred',
    '30 min',
    'All levels',
    'https://images.unsplash.com/photo-1549060279-7e168fcee0c2?w=400&q=80',
    [Color(0xFF263238), Color(0xFF546E7A)],
    category: WorkoutCategory.muscle,
    exercises: [
      _Exercise('Plank', '4 × 45s', Icons.fitness_center),
      _Exercise('Crunches', '4 × 20 reps', Icons.fitness_center),
      _Exercise('Leg Raises', '3 × 15 reps', Icons.arrow_upward),
      _Exercise('Russian Twists', '3 × 20 reps', Icons.rotate_right),
      _Exercise('Bicycle Crunches', '3 × 30 reps', Icons.directions_bike),
      _Exercise('Dead Bug', '3 × 10 reps each', Icons.pest_control),
    ],
  ),
  _WorkoutData(
    'Full Body Strength',
    '60 min',
    'Advanced',
    'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?w=400&q=80',
    [Color(0xFF1A237E), Color(0xFF283593)],
    category: WorkoutCategory.muscle,
    exercises: [
      _Exercise('Deadlift', '4 × 6 reps', Icons.fitness_center),
      _Exercise('Bench Press', '4 × 8 reps', Icons.fitness_center),
      _Exercise('Barbell Row', '4 × 8 reps', Icons.fitness_center),
      _Exercise('Overhead Press', '3 × 10 reps', Icons.arrow_upward),
      _Exercise('Front Squat', '3 × 8 reps', Icons.fitness_center),
      _Exercise('Weighted Pull-ups', '3 × 6 reps', Icons.fitness_center),
    ],
  ),
];

// ─────────────────────────── Workout Page ────────────────────────────────
class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  int _cat = 0;

  static const _cats = [
    ('🧘 Yoga', WorkoutCategory.yoga),
    ('🏃 Cardio', WorkoutCategory.cardio),
    ('💪 Build Muscle', WorkoutCategory.muscle),
  ];

  List<_WorkoutData> get _filtered =>
      _allWorkouts.where((w) => w.category == _cats[_cat].$2).toList();

  void _showWorkoutDetail(BuildContext context, _WorkoutData workout) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _WorkoutDetailSheet(workout: workout),
    );
  }

  @override
  Widget build(BuildContext context) {
    final workouts = _filtered;

    return PageGradient(
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Workout',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: kText,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Stay active, feel great!",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const Text(
                    "Choose your workout today.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kText,
                    ),
                  ),
                ],
              ),
            ),

            // Featured card
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: _FeaturedCard(),
            ),

            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Text(
                'Workouts',
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

            // Workout grid
            Expanded(
              child: GridView.builder(
                key: ValueKey(_cat),
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.78,
                ),
                itemCount: workouts.length,
                itemBuilder: (_, i) => _WorkoutCard(
                  data: workouts[i],
                  onTap: () => _showWorkoutDetail(context, workouts[i]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────── Featured Card ──────────────────────────────
class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard();

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
              color: const Color(0xFFD6F0E0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.local_fire_department,
              color: kGreen,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Streak',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kText,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Keep going — 3 days in a row!',
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

// ─────────────────────────── Workout Card ────────────────────────────────
class _WorkoutCard extends StatefulWidget {
  final _WorkoutData data;
  final VoidCallback onTap;
  const _WorkoutCard({required this.data, required this.onTap});

  @override
  State<_WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<_WorkoutCard> {
  bool _saved = false;

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
            // Image với gradient overlay + level badge
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _NetworkImage(
                    url: widget.data.imageUrl,
                    fallbackGradient: widget.data.gradient,
                  ),
                  // Level badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.55),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        widget.data.level,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
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
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 12,
                            color: kSubText,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            widget.data.duration,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF555555),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _saved = !_saved),
                        child: Row(
                          children: [
                            Icon(
                              _saved ? Icons.bookmark : Icons.bookmark_border,
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

// ─────────────────────────── Workout Detail Bottom Sheet ─────────────────
class _WorkoutDetailSheet extends StatelessWidget {
  final _WorkoutData workout;
  const _WorkoutDetailSheet({required this.workout});

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
              // Drag handle
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
              // Header info
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
                          url: workout.imageUrl,
                          fallbackGradient: workout.gradient,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workout.name,
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
                                icon: Icons.access_time,
                                label: workout.duration,
                                color: kGreen,
                              ),
                              _InfoChip(
                                icon: Icons.bar_chart,
                                label: workout.level,
                                color: const Color(0xFF5C6BC0),
                              ),
                              _InfoChip(
                                icon: Icons.fitness_center,
                                label: '${workout.exercises.length} exercises',
                                color: const Color(0xFFFF6B35),
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
              // Section title
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
                      'Exercises (${workout.exercises.length})',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: kText,
                      ),
                    ),
                  ],
                ),
              ),
              // Exercise list
              Expanded(
                child: ListView.separated(
                  controller: controller,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                  itemCount: workout.exercises.length,
                  separatorBuilder: (_, __) =>
                      const Divider(height: 1, color: Color(0xFFF5F5F5)),
                  itemBuilder: (_, i) {
                    final ex = workout.exercises[i];
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
                            child: Icon(ex.icon, color: kGreen, size: 22),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              ex.name,
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
                              ex.sets,
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
