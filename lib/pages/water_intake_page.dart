import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import '../core/app_theme.dart';
import '../services/db_service.dart'; // Import DatabaseService

class WaterIntakePage extends StatefulWidget {
  const WaterIntakePage({super.key});

  @override
  State<WaterIntakePage> createState() => _WaterIntakePageState();
}

class _WaterIntakePageState extends State<WaterIntakePage> {
  final int _goal = 2000;

  // Đẩy lượng nước vừa uống lên Firebase
  Future<void> _addWater(int amount) async {
    await DatabaseService().saveHealthRecord(
      'water_intake', 
      {'amount': amount},
    );
  }

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
        title: const Text(
          'Theo dõi lượng nước', 
          style: TextStyle(color: kText, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      // BỌC GIAO DIỆN BẰNG STREAMBUILDER
      body: StreamBuilder<QuerySnapshot>(
        stream: DatabaseService().getRecordsStream('water_intake'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF29B6F6)));
          }

          int todayWater = 0;
          final now = DateTime.now();

          // TÍNH TỔNG LƯỢNG NƯỚC TRONG NGÀY HÔM NAY
          if (snapshot.hasData) {
            for (var doc in snapshot.data!.docs) {
              final data = doc.data() as Map<String, dynamic>;
              final timestamp = data['timestamp'] as Timestamp?;
              
              if (timestamp != null) {
                final date = timestamp.toDate();
                // Chỉ cộng dồn nếu record đó thuộc về ngày hôm nay
                if (date.year == now.year && date.month == now.month && date.day == now.day) {
                  todayWater += (data['amount'] as num?)?.toInt() ?? 0;
                }
              }
            }
          }

          // Tính phần trăm hiển thị (giới hạn max để giao diện không bị vỡ nếu uống lố mục tiêu)
          final displayWater = todayWater.clamp(0, _goal + 1000);
          final progress = (displayWater / _goal).clamp(0.0, 1.0);

          return Column(
            children: [
              const SizedBox(height: 40),
              // Hình tròn hiển thị % nước
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 220,
                    height: 220,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 20,
                      backgroundColor: Colors.white,
                      color: const Color(0xFF29B6F6),
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  Column(
                    children: [
                      const Icon(Icons.water_drop, color: Color(0xFF29B6F6), size: 40),
                      const SizedBox(height: 8),
                      Text(
                        '$todayWater', 
                        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: kText),
                      ),
                      Text(
                        '/ ${_goal}ml', 
                        style: const TextStyle(fontSize: 16, color: kSubText),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 50),
              const Text(
                'Chọn lượng nước đã uống', 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: kText),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _WaterBtn(amount: 150, icon: Icons.local_cafe, onTap: () => _addWater(150)),
                  _WaterBtn(amount: 250, icon: Icons.local_drink, onTap: () => _addWater(250)),
                  _WaterBtn(amount: 500, icon: Icons.sports_bar, onTap: () => _addWater(500)),
                ],
              ),
            ],
          );
        }
      ),
    );
  }
}

class _WaterBtn extends StatelessWidget {
  final int amount;
  final IconData icon;
  final VoidCallback onTap;

  const _WaterBtn({
    required this.amount, 
    required this.icon, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withValues(alpha: 0.1), 
                  blurRadius: 10, 
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Icon(icon, color: const Color(0xFF29B6F6), size: 30),
          ),
          const SizedBox(height: 10),
          Text(
            '+${amount}ml', 
            style: const TextStyle(fontWeight: FontWeight.bold, color: kText),
          ),
        ],
      ),
    );
  }
}