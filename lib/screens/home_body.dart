import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tổng quan sức khỏe',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Sử dụng GridView để tạo giao diện Dashboard 2 cột
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn của GridView để dùng cuộn của SingleChildScrollView
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1, // Tỉ lệ chiều rộng/chiều cao của thẻ
            children: [
              _buildMetricCard('Nhịp tim', '78', 'bpm', Icons.favorite, Colors.red),
              _buildMetricCard('SpO2', '98', '%', Icons.bloodtype, Colors.blue),
              _buildMetricCard('Nhiệt độ', '36.5', '°C', Icons.thermostat, Colors.orange),
              _buildMetricCard('Bước chân', '5,432', 'bước', Icons.directions_walk, Colors.green),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Đánh giá chung',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Card(
            color: Colors.teal[50],
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.teal.shade200, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.teal, size: 36),
              title: Text('Trạng thái ổn định', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Các chỉ số sinh tồn của bạn đều nằm trong mức an toàn.'),
            ),
          )
        ],
      ),
    );
  }

  // Widget tạo thẻ chỉ số cho Dashboard
  Widget _buildMetricCard(String title, String value, String unit, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 36),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(value, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                const SizedBox(width: 4),
                Text(unit, style: const TextStyle(fontSize: 14, color: Colors.black54)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}