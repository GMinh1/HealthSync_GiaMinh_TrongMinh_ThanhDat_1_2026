import 'package:flutter/material.dart';
import '../core/app_theme.dart';

import 'blood_pressure_page.dart';
import 'water_intake_page.dart';
import 'heart_rate_page.dart';
import 'steps_page.dart';
import 'weight_bmi_page.dart';
import 'blood_sugar_page.dart';
class AddMenuPage extends StatelessWidget {
  const AddMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: kText, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Thêm dữ liệu mới', style: TextStyle(color: kText, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.05,
        children: [
          _MenuCard(
            title: 'Huyết áp',
            icon: Icons.monitor_heart,
            color: const Color(0xFF5B8DEF),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BloodPressurePage())),
          ),
          _MenuCard(
            title: 'Nhịp tim',
            icon: Icons.favorite,
            color: const Color(0xFFE53935),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HeartRatePage())),
          ),
          _MenuCard(
            title: 'Đường huyết',
            icon: Icons.water_drop,
            color: const Color(0xFFEF9A3A),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BloodSugarPage())),
          ),
          _MenuCard(
            title: 'Cân nặng & BMI',
            icon: Icons.scale,
            color: const Color(0xFF7C6FEF),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const WeightBmiPage())),
          ),
          _MenuCard(
            title: 'Uống nước',
            icon: Icons.local_drink,
            color: const Color(0xFF29B6F6),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const WaterIntakePage())),
          ),
          _MenuCard(
            title: 'Bước chân',
            icon: Icons.directions_walk,
            color: const Color.fromARGB(255, 55, 64, 239),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const StepsPage())),
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({required this.title, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 36),
            ),
            const SizedBox(height: 14),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: kText)),
          ],
        ),
      ),
    );
  }
}