import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class FeaturePlaceholderPage extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const FeaturePlaceholderPage({
    super.key, 
    required this.title, 
    required this.icon, 
    required this.color
  });

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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 80, color: color),
            ),
            const SizedBox(height: 24),
            Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: kText)),
            const SizedBox(height: 12),
            const Text(
              'Tính năng này đang được phát triển.\nVui lòng quay lại sau nhé!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: kSubText, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}