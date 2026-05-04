import 'package:flutter/material.dart';

class ContentBody extends StatelessWidget {
  const ContentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'Chi tiết chỉ số hôm nay',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildDetailTile('Huyết áp', '120/80', 'mmHg', 'Bình thường', Icons.monitor_heart, Colors.redAccent),
        _buildDetailTile('Đường huyết', '5.5', 'mmol/L', 'Ổn định', Icons.water_drop, Colors.purple),
        _buildDetailTile('Calo tiêu thụ', '450', 'kcal', 'Đang vận động', Icons.local_fire_department, Colors.orange),
        _buildDetailTile('Giấc ngủ', '7.5', 'giờ', 'Ngủ sâu', Icons.bedtime, Colors.indigo),
        _buildDetailTile('Lượng nước', '1.5', 'lít', 'Cần uống thêm', Icons.local_drink, Colors.lightBlue),
      ],
    );
  }

  // Widget tạo danh sách các chỉ số chi tiết
  Widget _buildDetailTile(String title, String value, String unit, String status, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(status, style: TextStyle(color: Colors.grey[600])),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(unit, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}