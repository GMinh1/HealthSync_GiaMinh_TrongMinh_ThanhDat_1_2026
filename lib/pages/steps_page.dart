import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class StepsPage extends StatelessWidget {
  const StepsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: kText, size: 32),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Bước chân', style: TextStyle(color: kText, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 240, height: 240,
                child: CircularProgressIndicator(
                  value: 0.65, strokeWidth: 18,
                  backgroundColor: Colors.grey[200],
                  color: kGreen, strokeCap: StrokeCap.round,
                ),
              ),
              Column(
                children: [
                  const Icon(Icons.directions_walk, color: kGreen, size: 40),
                  const SizedBox(height: 8),
                  const Text('6,540', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: kText)),
                  Text('/ 10,000 bước', style: TextStyle(fontSize: 14, color: kText.withValues(alpha: 0.5))),
                ],
              )
            ],
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _StatBox(icon: Icons.local_fire_department, val: '320', unit: 'kcal', color: Colors.orange),
                const SizedBox(width: 12),
                _StatBox(icon: Icons.location_on, val: '4.2', unit: 'km', color: Colors.blue),
                const SizedBox(width: 12),
                _StatBox(icon: Icons.timer, val: '45', unit: 'phút', color: Colors.purple),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final IconData icon;
  final String val, unit;
  final Color color;

  const _StatBox({required this.icon, required this.val, required this.unit, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(val, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kText)),
            Text(unit, style: const TextStyle(fontSize: 12, color: kSubText)),
          ],
        ),
      ),
    );
  }
}