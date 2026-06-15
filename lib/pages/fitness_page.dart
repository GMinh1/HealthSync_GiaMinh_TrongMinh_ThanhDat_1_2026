import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class Workout {
  final String title;
  final String duration;
  final int kcal;
  final IconData icon;
  final Color color;
  final String level;

  Workout({
    required this.title,
    required this.duration,
    required this.kcal,
    required this.icon,
    required this.color,
    required this.level,
  });
}

class FitnessPage extends StatefulWidget {
  const FitnessPage({super.key});

  @override
  State<FitnessPage> createState() => _FitnessPageState();
}

class _FitnessPageState extends State<FitnessPage> {
  int _caloriesBurned = 0;
  final int _dailyGoal = 500;

  final List<Workout> _workouts = [
    Workout(
      title: 'Chạy bộ nhẹ nhàng',
      duration: '30 phút',
      kcal: 250,
      icon: Icons.directions_run,
      color: const Color(0xFF29B6F6),
      level: 'Cơ bản',
    ),
    Workout(
      title: 'Đạp xe trong nhà',
      duration: '45 phút',
      kcal: 320,
      icon: Icons.directions_bike,
      color: const Color(0xFFFFA726),
      level: 'Trung bình',
    ),
    Workout(
      title: 'Yoga buổi sáng',
      duration: '20 phút',
      kcal: 100,
      icon: Icons.self_improvement,
      color: const Color(0xFFAB47BC),
      level: 'Cơ bản',
    ),
    Workout(
      title: 'Tập HIIT (Cardio)',
      duration: '15 phút',
      kcal: 200,
      icon: Icons.local_fire_department,
      color: const Color(0xFFE53935),
      level: 'Nâng cao',
    ),
    Workout(
      title: 'Nhảy dây',
      duration: '10 phút',
      kcal: 150,
      icon: Icons.sports_gymnastics,
      color: kGreen,
      level: 'Trung bình',
    ),
  ];

  void _completeWorkout(Workout workout) {
    setState(() {
      _caloriesBurned += workout.kcal;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🎉 Tuyệt vời! Bạn vừa đốt cháy ${workout.kcal} kcal.'),
        backgroundColor: kGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_caloriesBurned / _dailyGoal).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: kText, size: 32),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Tập luyện', style: TextStyle(color: kText, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 8,
                          backgroundColor: Colors.grey[200],
                          color: kGreen,
                          strokeCap: StrokeCap.round,
                        ),
                        Center(
                          child: Icon(Icons.local_fire_department, color: kGreen, size: 32),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Calo đã đốt cháy',
                          style: TextStyle(color: kSubText, fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '$_caloriesBurned',
                              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: kText),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '/ $_dailyGoal kcal',
                              style: TextStyle(fontSize: 14, color: kText.withValues(alpha: 0.5)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Gợi ý bài tập', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kText)),
            ),
          ),
          const SizedBox(height: 12),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              itemCount: _workouts.length,
              itemBuilder: (ctx, i) {
                final w = _workouts[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: w.color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(w.icon, color: w.color, size: 30),
                      ),
                      const SizedBox(width: 16),
                      // Thông tin
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              w.title,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: kText),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.timer_outlined, size: 14, color: kSubText),
                                const SizedBox(width: 4),
                                Text(w.duration, style: const TextStyle(color: kSubText, fontSize: 13)),
                                const SizedBox(width: 12),
                                Icon(Icons.local_fire_department_outlined, size: 14, color: kSubText),
                                const SizedBox(width: 4),
                                Text('${w.kcal} kcal', style: const TextStyle(color: kSubText, fontSize: 13)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                w.level,
                                style: const TextStyle(fontSize: 11, color: Color(0xFF666666), fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Nút Start/Done
                      GestureDetector(
                        onTap: () => _completeWorkout(w),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: kGreen,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: kGreen.withValues(alpha: 0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.check, color: Colors.white, size: 20),
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
  }
}