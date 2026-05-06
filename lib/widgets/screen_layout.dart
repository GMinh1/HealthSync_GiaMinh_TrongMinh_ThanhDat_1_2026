import 'package:flutter/material.dart';

class ScreenLayout extends StatelessWidget {
  final Widget bodyContent;

  const ScreenLayout({super.key, required this.bodyContent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Body: Chứa nội dung theo dõi sức khỏe
        Expanded(
          child: Container(
            color: Colors.grey[50], 
            child: bodyContent,
          ),
        ),
        
        // Footer: Đổi thành dự án y tế/sức khỏe
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          color: Colors.teal[900], // Màu đồng bộ với App Theme
          child: const Column(
            children: [
              Text(
                'Phenikaa University',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Gia Minh - Trong Minh - Thanh Dat', 
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}