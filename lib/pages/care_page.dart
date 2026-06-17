import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:pedometer/pedometer.dart'; // Thêm thư viện đếm bước
import 'package:permission_handler/permission_handler.dart'; // Thêm thư viện xin quyền
import '../core/app_theme.dart';
import '../core/shared_widgets.dart';
import '../services/db_service.dart'; 

import 'blood_pressure_page.dart';
import 'water_intake_page.dart';
import 'heart_rate_page.dart';
import 'steps_page.dart';
import 'weight_bmi_page.dart';
import 'blood_sugar_page.dart';

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
            const PageTitle('Theo dõi sức khỏe'), // Đã việt hóa lại tiêu đề cho đồng bộ
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                child: Column(
                  children: [
                    // ─── Heart Rate + Steps (Card lớn) ─────────────────
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HeartRatePage(),
                              ),
                            ),
                            // Lắng nghe dữ liệu Nhịp tim
                            child: StreamBuilder<QuerySnapshot>(
                              stream: DatabaseService().getRecordsStream('heart_rate'),
                              builder: (context, snapshot) {
                                String bpmValue = '--';
                                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                                  final data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                                  bpmValue = data['bpm']?.toString() ?? '--';
                                }
                                return _LargeMetricCard(
                                  title: 'Nhịp tim',
                                  value: bpmValue,
                                  unit: 'BPM',
                                  bgGradient: const [Color(0xFFFFD6D6), Color(0xFFFFBEBE)],
                                  accentColor: const Color(0xFFE53935),
                                  icon: Icons.favorite,
                                );
                              }
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        
                        // Sử dụng Widget đếm bước chân thời gian thực mới tạo
                        const Expanded(
                          child: _LiveStepsCard(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // ─── Blood Pressure + Weight & BMI ─────────────────
                    _row(
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BloodPressurePage(),
                          ),
                        ),
                        // Lắng nghe dữ liệu Huyết áp
                        child: StreamBuilder<QuerySnapshot>(
                          stream: DatabaseService().getRecordsStream('blood_pressure'),
                          builder: (context, snapshot) {
                            String bpValue = '--/--';
                            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                              final data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                              bpValue = '${data['systolic'] ?? '--'}/${data['diastolic'] ?? '--'}';
                            }
                            return _SmallMetricCard(
                              title: 'Huyết áp',
                              value: bpValue,
                              unit: 'mmHg',
                              bgColor: const Color(0xFFECF3FF),
                              icon: Icons.monitor_heart_outlined,
                              iconColor: const Color(0xFF5B8DEF),
                            );
                          }
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const WeightBmiPage(),
                          ),
                        ),
                        // Lắng nghe dữ liệu Cân nặng
                        child: StreamBuilder<QuerySnapshot>(
                          stream: DatabaseService().getRecordsStream('weight_bmi'),
                          builder: (context, snapshot) {
                            String weightValue = '--';
                            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                              final data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                              weightValue = data['weight']?.toString() ?? '--';
                            }
                            return _SmallMetricCard(
                              title: 'Cân nặng',
                              value: weightValue,
                              unit: 'kg',
                              bgColor: const Color(0xFFF0EEFF),
                              icon: Icons.scale_outlined,
                              iconColor: const Color(0xFF7C6FEF),
                            );
                          }
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // ─── Blood Sugar + Water Intake ────────────────────
                    _row(
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BloodSugarPage(),
                          ),
                        ),
                        // Lắng nghe dữ liệu Đường huyết
                        child: StreamBuilder<QuerySnapshot>(
                          stream: DatabaseService().getRecordsStream('blood_sugar'),
                          builder: (context, snapshot) {
                            String sugarValue = '--';
                            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                              final data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                              sugarValue = data['value']?.toString() ?? '--';
                            }
                            return _SmallMetricCard(
                              title: 'Đường huyết',
                              value: sugarValue,
                              unit: 'mg/dL',
                              bgColor: const Color(0xFFFFF5E8),
                              icon: Icons.water_drop_outlined,
                              iconColor: const Color(0xFFEF9A3A),
                            );
                          }
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const WaterIntakePage(),
                          ),
                        ),
                        // Lắng nghe tổng lượng nước uống trong ngày
                        child: StreamBuilder<QuerySnapshot>(
                          stream: DatabaseService().getRecordsStream('water_intake'),
                          builder: (context, snapshot) {
                            int todayWater = 0;
                            final now = DateTime.now();
                            if (snapshot.hasData) {
                              for (var doc in snapshot.data!.docs) {
                                final data = doc.data() as Map<String, dynamic>;
                                final ts = data['timestamp'] as Timestamp?;
                                if (ts != null) {
                                  final date = ts.toDate();
                                  if (date.year == now.year && date.month == now.month && date.day == now.day) {
                                    todayWater += (data['amount'] as num?)?.toInt() ?? 0;
                                  }
                                }
                              }
                            }
                            return _SmallMetricCard(
                              title: 'Nước đã uống',
                              value: todayWater.toString(),
                              unit: '/2000ml',
                              bgColor: const Color(0xFFE8F5FF),
                              icon: Icons.local_drink_outlined,
                              iconColor: const Color(0xFF29B6F6),
                            );
                          }
                        ),
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

// ═══════════════════════════════════════════════════════════════════════
//  Widget Live Steps Card (Đếm bước chân thời gian thực)
// ═══════════════════════════════════════════════════════════════════════
class _LiveStepsCard extends StatefulWidget {
  const _LiveStepsCard();

  @override
  State<_LiveStepsCard> createState() => _LiveStepsCardState();
}

class _LiveStepsCardState extends State<_LiveStepsCard> {
  late Stream<StepCount> _stepCountStream;
  String _steps = '--';

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    if (await Permission.activityRecognition.request().isGranted) {
      _initPedometer();
    } else {
      if (mounted) setState(() => _steps = 'Cấp quyền');
    }
  }

  void _initPedometer() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(
      (StepCount event) {
        if (mounted) {
          setState(() {
            _steps = event.steps.toString();
          });
        }
      },
      onError: (error) {
        if (mounted) setState(() => _steps = 'Lỗi');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const StepsPage()),
      ),
      child: _LargeMetricCard(
        title: 'Bước chân',
        value: _steps,
        unit: 'bước',
        bgGradient: const [Color(0xFFD0F8E8), Color(0xFFB8F0D8)],
        accentColor: kGreen,
        icon: Icons.directions_walk,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
//  Shared UI Components
// ═══════════════════════════════════════════════════════════════════════
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
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
                    '• Xem chi tiết >',
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
            child: Icon(
              icon,
              size: 38,
              color: accentColor.withValues(alpha: 0.85),
            ),
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
                  'Chi tiết >',
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
            color: Colors.black.withValues(alpha: 0.04),
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
                  'Xem >',
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