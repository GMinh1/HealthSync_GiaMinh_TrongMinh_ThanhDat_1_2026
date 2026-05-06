import 'package:flutter/material.dart';

class ScreenLayout extends StatelessWidget {
  final Widget bodyContent;

  const ScreenLayout({super.key, required this.bodyContent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header: Chuyển sang hình ảnh liên quan đến chạy bộ/thể thao
        Container(
          height: 180,
          width: double.infinity,
          color: Colors.grey[200],
          child: Image.network(
            'https://images.unsplash.com/photo-1476480862126-209bfaa8edc8?q=80&w=2070&auto=format&fit=crop', // Ảnh thể dục thể thao
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => 
              const Center(child: Icon(Icons.fitness_center, size: 50, color: Colors.grey)),
          ),
        ),
        
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