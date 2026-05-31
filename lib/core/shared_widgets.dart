import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Gradient nền xanh mint dùng chung cho Care, Sound, Recipe
class PageGradient extends StatelessWidget {
  final Widget child;
  const PageGradient({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment(0, 0.4),
          colors: [kBgTop, kBgBottom],
        ),
      ),
      child: child,
    );
  }
}

/// Tiêu đề lớn đầu mỗi trang
class PageTitle extends StatelessWidget {
  final String title;
  const PageTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: kText,
        ),
      ),
    );
  }
}
