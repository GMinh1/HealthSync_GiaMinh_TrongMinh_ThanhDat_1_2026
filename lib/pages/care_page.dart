import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/shared_widgets.dart';
import 'blood_pressure_page.dart';

class CarePage extends StatelessWidget {
  const CarePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageGradient(
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageTitle('Care'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                child: Column(
                  children: [
                    // Heart Rate + Steps — card lớn
                    Row(
                      children: [
                        Expanded(
                          child: _LargeMetricCard(
                            title: 'Heart Rate',
                            value: '--',
                            unit: 'BPM',
                            bgGradient: const [
                              Color(0xFFFFD6D6),
                              Color(0xFFFFBEBE),
                            ],
                            accentColor: const Color(0xFFE53935),
                            icon: Icons.favorite,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _LargeMetricCard(
                            title: 'Steps',
                            value: '--',
                            unit: '',
                            bgGradient: const [
                              Color(0xFFD0F8E8),
                              Color(0xFFB8F0D8),
                            ],
                            accentColor: kGreen,
                            icon: Icons.directions_walk,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _row(
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BloodPressurePage(),
                          ),
                        ),
                        child: _SmallMetricCard(
                          title: 'Blood Pressure',
                          value: '110/70',
                          unit: 'mmHg',
                          bgColor: const Color(0xFFECF3FF),
                          icon: Icons.monitor_heart_outlined,
                          iconColor: const Color(0xFF5B8DEF),
                        ),
                      ),
                      _SmallMetricCard(
                        title: 'Weight & BMI',
                        value: '--',
                        unit: '',
                        bgColor: const Color(0xFFF0EEFF),
                        icon: Icons.scale_outlined,
                        iconColor: const Color(0xFF7C6FEF),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _row(
                      _SmallMetricCard(
                        title: 'Blood Sugar',
                        value: '--',
                        unit: 'mg/dL',
                        bgColor: const Color(0xFFFFF5E8),
                        icon: Icons.water_drop_outlined,
                        iconColor: const Color(0xFFEF9A3A),
                      ),
                      _SmallMetricCard(
                        title: 'Water Intake',
                        value: '0',
                        unit: '/2000ml',
                        bgColor: const Color(0xFFE8F5FF),
                        icon: Icons.local_drink_outlined,
                        iconColor: const Color(0xFF29B6F6),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _row(
                      _SmallMetricCard(
                        title: 'Fitness',
                        value: '',
                        unit: '',
                        bgColor: const Color(0xFFEEF8EC),
                        icon: Icons.fitness_center_outlined,
                        iconColor: kGreen,
                      ),
                      _SmallMetricCard(
                        title: 'AI Doctor',
                        value: '',
                        unit: '',
                        bgColor: const Color(0xFFFFF0F5),
                        icon: Icons.medical_services_outlined,
                        iconColor: const Color(0xFFE91E8C),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _row(
                      _SmallMetricCard(
                        title: 'Reminder',
                        value: '',
                        unit: '',
                        bgColor: const Color(0xFFFFFBE8),
                        icon: Icons.alarm_outlined,
                        iconColor: const Color(0xFFFFC107),
                      ),
                      _SmallMetricCard(
                        title: 'Log Period',
                        value: '--',
                        unit: '',
                        bgColor: const Color(0xFFFFEEF5),
                        icon: Icons.calendar_month_outlined,
                        iconColor: const Color(0xFFEC407A),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(Widget a, Widget b) => Row(
    children: [
      Expanded(child: a),
      const SizedBox(width: 12),
      Expanded(child: b),
    ],
  );
}

// ─────────────────────────── Card lớn ───────────────────────────────────
class _LargeMetricCard extends StatelessWidget {
  final String title, value, unit;
  final List<Color> bgGradient;
  final Color accentColor;
  final IconData icon;

  const _LargeMetricCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.bgGradient,
    required this.accentColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: bgGradient,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 14, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: kText,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                if (unit.isNotEmpty)
                  Text(
                    unit,
                    style: const TextStyle(fontSize: 12, color: kSubText),
                  ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 52),
                  child: Text(
                    '• History >',
                    style: TextStyle(
                      fontSize: 12,
                      color: accentColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Icon(icon, size: 38, color: accentColor.withOpacity(0.85)),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 44,
              color: Colors.white,
              child: Center(
                child: Text(
                  'Get >',
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── Card nhỏ ───────────────────────────────────
class _SmallMetricCard extends StatelessWidget {
  final String title, value, unit;
  final Color bgColor, iconColor;
  final IconData icon;

  const _SmallMetricCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.bgColor,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: kText,
            ),
          ),
          const SizedBox(height: 4),
          if (value.isNotEmpty)
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: kText,
                  ),
                ),
                if (unit.isNotEmpty) ...[
                  const SizedBox(width: 3),
                  Text(
                    unit,
                    style: const TextStyle(fontSize: 11, color: kSubText),
                  ),
                ],
              ],
            )
          else
            const SizedBox(height: 8),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: iconColor),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: kGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Get >',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
