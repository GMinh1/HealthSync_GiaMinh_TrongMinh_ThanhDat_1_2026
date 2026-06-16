import 'package:flutter/material.dart';

// ─────────────────────────── Data model ─────────────────────────────────
class WorkoutExercise {
  final String name;
  final String sets;
  final IconData icon;
  const WorkoutExercise(this.name, this.sets, this.icon);
}

enum WorkoutCategory { yoga, cardio, muscle }

class WorkoutData {
  final String name, duration, level;
  final String imageUrl;
  final List<Color> gradient;
  final WorkoutCategory category;
  final List<WorkoutExercise> exercises;
  const WorkoutData(
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
const allWorkouts = <WorkoutData>[
  // ── 🧘 YOGA ──
  WorkoutData(
    'Morning Flow Yoga',
    '30 min',
    'Beginner',
    'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400&q=80',
    [Color(0xFF6A1B9A), Color(0xFFAB47BC)],
    category: WorkoutCategory.yoga,
    exercises: [
      WorkoutExercise('Child\'s Pose', '3 × 60s', Icons.self_improvement),
      WorkoutExercise('Downward Dog', '3 × 45s', Icons.fitness_center),
      WorkoutExercise('Warrior I', '3 × 30s each', Icons.sports_martial_arts),
      WorkoutExercise('Warrior II', '3 × 30s each', Icons.sports_martial_arts),
      WorkoutExercise('Tree Pose', '2 × 45s each', Icons.nature),
      WorkoutExercise('Corpse Pose', '1 × 5 min', Icons.bedtime),
    ],
  ),
  WorkoutData(
    'Deep Stretch & Relax',
    '45 min',
    'Beginner',
    'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=400&q=80',
    [Color(0xFF4527A0), Color(0xFF7E57C2)],
    category: WorkoutCategory.yoga,
    exercises: [
      WorkoutExercise('Cat-Cow Stretch', '3 × 10 reps', Icons.pets),
      WorkoutExercise(
        'Seated Forward Fold',
        '3 × 60s',
        Icons.accessibility_new,
      ),
      WorkoutExercise('Pigeon Pose', '2 × 90s each', Icons.self_improvement),
      WorkoutExercise('Supine Twist', '2 × 60s each', Icons.rotate_right),
      WorkoutExercise(
        'Legs Up the Wall',
        '1 × 5 min',
        Icons.vertical_align_top,
      ),
    ],
  ),
  WorkoutData(
    'Power Yoga Flow',
    '50 min',
    'Intermediate',
    'https://images.unsplash.com/photo-1588286840104-8957b019727f?w=400&q=80',
    [Color(0xFF1A237E), Color(0xFF3949AB)],
    category: WorkoutCategory.yoga,
    exercises: [
      WorkoutExercise('Sun Salutation A', '5 rounds', Icons.wb_sunny),
      WorkoutExercise(
        'Crescent Lunge',
        '3 × 30s each',
        Icons.sports_martial_arts,
      ),
      WorkoutExercise(
        'Plank to Chaturanga',
        '3 × 10 reps',
        Icons.fitness_center,
      ),
      WorkoutExercise('Boat Pose', '3 × 30s', Icons.directions_boat),
      WorkoutExercise('Bridge Pose', '3 × 45s', Icons.architecture),
      WorkoutExercise('Wheel Pose', '2 × 20s', Icons.radio_button_unchecked),
    ],
  ),
  WorkoutData(
    'Yoga for Flexibility',
    '40 min',
    'All levels',
    'https://images.unsplash.com/photo-1518611012118-696072aa579a?w=400&q=80',
    [Color(0xFF880E4F), Color(0xFFC2185B)],
    category: WorkoutCategory.yoga,
    exercises: [
      WorkoutExercise(
        'Standing Side Stretch',
        '3 × 30s each',
        Icons.accessibility,
      ),
      WorkoutExercise('Low Lunge', '3 × 45s each', Icons.sports_martial_arts),
      WorkoutExercise('Butterfly Pose', '3 × 60s', Icons.flutter_dash),
      WorkoutExercise('Seated Spinal Twist', '2 × 45s each', Icons.rotate_left),
      WorkoutExercise('Happy Baby Pose', '2 × 60s', Icons.child_care),
    ],
  ),

  // ── 🏃 CARDIO ──
  WorkoutData(
    'HIIT Blast',
    '25 min',
    'Intermediate',
    'https://images.unsplash.com/photo-1601422407692-ec4eeec1d9b3?w=400&q=80',
    [Color(0xFFBF360C), Color(0xFFE64A19)],
    category: WorkoutCategory.cardio,
    exercises: [
      WorkoutExercise('Jumping Jacks', '4 × 40s', Icons.directions_run),
      WorkoutExercise('High Knees', '4 × 40s', Icons.directions_run),
      WorkoutExercise('Burpees', '4 × 10 reps', Icons.fitness_center),
      WorkoutExercise('Mountain Climbers', '4 × 40s', Icons.terrain),
      WorkoutExercise('Jump Squats', '4 × 15 reps', Icons.arrow_upward),
      WorkoutExercise('Sprint in Place', '4 × 30s', Icons.speed),
    ],
  ),
  WorkoutData(
    'Jump Rope Cardio',
    '20 min',
    'Beginner',
    'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=400&q=80',
    [Color(0xFFE65100), Color(0xFFFF8F00)],
    category: WorkoutCategory.cardio,
    exercises: [
      WorkoutExercise('Basic Jump', '3 × 2 min', Icons.loop),
      WorkoutExercise('Alternate Foot Jump', '3 × 90s', Icons.swap_horiz),
      WorkoutExercise('Double Unders', '3 × 20 reps', Icons.fast_forward),
      WorkoutExercise('Rest Walk', '3 × 30s', Icons.directions_walk),
    ],
  ),
  WorkoutData(
    'Dance Cardio',
    '35 min',
    'All levels',
    'https://images.unsplash.com/photo-1535743686920-55e4145369b9?w=400&q=80',
    [Color(0xFFAD1457), Color(0xFFE91E63)],
    category: WorkoutCategory.cardio,
    exercises: [
      WorkoutExercise('Warm-up March', '1 × 3 min', Icons.directions_walk),
      WorkoutExercise('Salsa Steps', '3 × 2 min', Icons.music_note),
      WorkoutExercise('Hip Circles', '3 × 60s', Icons.loop),
      WorkoutExercise('Side Steps', '3 × 90s', Icons.swap_horiz),
      WorkoutExercise('Cool-down Sway', '1 × 3 min', Icons.air),
    ],
  ),
  WorkoutData(
    'Stair Climb Circuit',
    '30 min',
    'Intermediate',
    'https://images.unsplash.com/photo-1470258986370-9c651f0a32ef?w=400&q=80',
    [Color(0xFF004D40), Color(0xFF00897B)],
    category: WorkoutCategory.cardio,
    exercises: [
      WorkoutExercise('Stair Run Up', '5 × 2 floors', Icons.stairs),
      WorkoutExercise('Step-ups', '4 × 20 reps', Icons.vertical_align_top),
      WorkoutExercise('Box Jumps', '3 × 12 reps', Icons.arrow_upward),
      WorkoutExercise('Lateral Step-overs', '3 × 16 reps', Icons.swap_horiz),
      WorkoutExercise('Stair Sprints', '5 × 30s', Icons.speed),
    ],
  ),

  // ── 💪 BUILD MUSCLE ──
  WorkoutData(
    'Upper Body Power',
    '45 min',
    'Intermediate',
    'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=400&q=80',
    [Color(0xFF1B2A4A), Color(0xFF37474F)],
    category: WorkoutCategory.muscle,
    exercises: [
      WorkoutExercise('Push-ups', '4 × 15 reps', Icons.fitness_center),
      WorkoutExercise('Pull-ups', '4 × 8 reps', Icons.arrow_upward),
      WorkoutExercise(
        'Dumbbell Shoulder Press',
        '3 × 12 reps',
        Icons.fitness_center,
      ),
      WorkoutExercise('Tricep Dips', '3 × 15 reps', Icons.fitness_center),
      WorkoutExercise('Bicep Curls', '3 × 12 reps', Icons.fitness_center),
      WorkoutExercise('Lat Raises', '3 × 12 reps', Icons.open_with),
    ],
  ),
  WorkoutData(
    'Leg Day Builder',
    '50 min',
    'Intermediate',
    'https://images.unsplash.com/photo-1434682881908-b43d0467b798?w=400&q=80',
    [Color(0xFF212121), Color(0xFF455A64)],
    category: WorkoutCategory.muscle,
    exercises: [
      WorkoutExercise('Back Squats', '4 × 10 reps', Icons.fitness_center),
      WorkoutExercise('Romanian Deadlift', '4 × 10 reps', Icons.fitness_center),
      WorkoutExercise('Leg Press', '3 × 12 reps', Icons.fitness_center),
      WorkoutExercise('Walking Lunges', '3 × 16 reps', Icons.directions_walk),
      WorkoutExercise('Calf Raises', '4 × 20 reps', Icons.arrow_upward),
      WorkoutExercise('Glute Bridges', '3 × 15 reps', Icons.fitness_center),
    ],
  ),
  WorkoutData(
    'Core & Abs Shred',
    '30 min',
    'All levels',
    'https://images.unsplash.com/photo-1549060279-7e168fcee0c2?w=400&q=80',
    [Color(0xFF263238), Color(0xFF546E7A)],
    category: WorkoutCategory.muscle,
    exercises: [
      WorkoutExercise('Plank', '4 × 45s', Icons.fitness_center),
      WorkoutExercise('Crunches', '4 × 20 reps', Icons.fitness_center),
      WorkoutExercise('Leg Raises', '3 × 15 reps', Icons.arrow_upward),
      WorkoutExercise('Russian Twists', '3 × 20 reps', Icons.rotate_right),
      WorkoutExercise('Bicycle Crunches', '3 × 30 reps', Icons.directions_bike),
      WorkoutExercise('Dead Bug', '3 × 10 reps each', Icons.pest_control),
    ],
  ),
  WorkoutData(
    'Full Body Strength',
    '60 min',
    'Advanced',
    'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?w=400&q=80',
    [Color(0xFF1A237E), Color(0xFF283593)],
    category: WorkoutCategory.muscle,
    exercises: [
      WorkoutExercise('Deadlift', '4 × 6 reps', Icons.fitness_center),
      WorkoutExercise('Bench Press', '4 × 8 reps', Icons.fitness_center),
      WorkoutExercise('Barbell Row', '4 × 8 reps', Icons.fitness_center),
      WorkoutExercise('Overhead Press', '3 × 10 reps', Icons.arrow_upward),
      WorkoutExercise('Front Squat', '3 × 8 reps', Icons.fitness_center),
      WorkoutExercise('Weighted Pull-ups', '3 × 6 reps', Icons.fitness_center),
    ],
  ),
];
