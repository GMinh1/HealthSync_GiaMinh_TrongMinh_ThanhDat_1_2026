import 'dart:async'; // Cần thêm thư viện này cho Timer
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import '../core/app_theme.dart';
import '../services/db_service.dart';

class StepsPage extends StatefulWidget {
  const StepsPage({super.key});

  @override
  // Thêm WidgetsBindingObserver để lắng nghe trạng thái ẩn/hiện của App
  State<StepsPage> createState() => _StepsPageState();
}

class _StepsPageState extends State<StepsPage> with WidgetsBindingObserver {
  late Stream<StepCount> _stepCountStream;
  int _liveSteps = 0;
  int _lastSyncedSteps = 0; // Biến lưu số bước đã đồng bộ lần cuối
  bool _isSensorActive = false;
  final int _goal = 10000;
  
  Timer? _syncTimer;

  @override
  void initState() {
    super.initState();
    // 1. Đăng ký lắng nghe trạng thái App (ẩn/hiện)
    WidgetsBinding.instance.addObserver(this);
    
    _requestPermission();

    // 2. Thiết lập bộ đếm thời gian: Cứ 15 giây tự động đồng bộ 1 lần
    _syncTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      _autoSyncToFirebase();
    });
  }

  @override
  void dispose() {
    // 3. Xoá bộ đếm giờ và lưu chốt lần cuối khi người dùng thoát trang
    _syncTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _autoSyncToFirebase();
    super.dispose();
  }

  // 4. Bắt sự kiện khi người dùng vuốt ẩn App ra màn hình chính
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      _autoSyncToFirebase();
    }
  }

  // ─── HÀM TỰ ĐỘNG ĐỒNG BỘ ────────────────────────────────────────────────
  void _autoSyncToFirebase() {
    // Chỉ gửi lên Firebase NẾU số bước hiện tại lớn hơn số bước đã đồng bộ trước đó
    if (_isSensorActive && _liveSteps > _lastSyncedSteps) {
      DatabaseService().saveHealthRecord('steps', {
        'steps': _liveSteps,
      });
      _lastSyncedSteps = _liveSteps; // Cập nhật lại mốc đã lưu
      debugPrint("Đã tự động đồng bộ: $_liveSteps bước");
    }
  }

  Future<void> _requestPermission() async {
    if (await Permission.activityRecognition.request().isGranted) {
      _initPedometer();
    }
  }

  void _initPedometer() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(
      (StepCount event) {
        if (mounted) {
          setState(() {
            _liveSteps = event.steps;
            _isSensorActive = true;
          });
        }
      },
      onError: (error) {
        debugPrint("Lỗi cảm biến: $error");
      },
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
        title: const Text('Bước chân', style: TextStyle(color: kText, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: DatabaseService().getRecordsStream('steps'),
        builder: (context, snapshot) {
          int savedSteps = 0;

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            final latestData = snapshot.data!.docs.first.data() as Map<String, dynamic>;
            savedSteps = latestData['steps'] ?? 0;
            
            // Cập nhật mốc đồng bộ lần đầu tiên tải về để tránh ghi đè dư thừa
            if (_lastSyncedSteps == 0) {
              _lastSyncedSteps = savedSteps;
            }
          }

          int displaySteps = _isSensorActive ? _liveSteps : savedSteps;

          double progress = (displaySteps / _goal).clamp(0.0, 1.0);
          double distanceKm = (displaySteps * 0.762) / 1000; 
          double calories = displaySteps * 0.04;             
          int activeMinutes = (displaySteps / 100).round();  

          return Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 240, height: 240,
                    child: CircularProgressIndicator(
                      value: progress, 
                      strokeWidth: 18,
                      backgroundColor: Colors.grey[200],
                      color: kGreen, 
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  Column(
                    children: [
                      const Icon(Icons.directions_walk, color: kGreen, size: 40),
                      const SizedBox(height: 8),
                      Text(
                        '$displaySteps', 
                        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: kText)
                      ),
                      Text(
                        '/ 10,000 bước', 
                        style: TextStyle(fontSize: 14, color: kText.withValues(alpha: 0.5))
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 30),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _StatBox(
                      icon: Icons.local_fire_department, 
                      val: calories.toStringAsFixed(0), 
                      unit: 'kcal', 
                      color: Colors.orange
                    ),
                    const SizedBox(width: 12),
                    _StatBox(
                      icon: Icons.location_on, 
                      val: distanceKm.toStringAsFixed(2), 
                      unit: 'km', 
                      color: Colors.blue
                    ),
                    const SizedBox(width: 12),
                    _StatBox(
                      icon: Icons.timer, 
                      val: '$activeMinutes', 
                      unit: 'phút', 
                      color: Colors.purple
                    ),
                  ],
                ),
              ),
              const Spacer(),
              
              // Dòng chữ nhỏ thông báo trạng thái đồng bộ thay cho nút bấm to bản
              if (_isSensorActive)
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 12, height: 12,
                        child: CircularProgressIndicator(strokeWidth: 2, color: kGreen),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Đang tự động đồng bộ dữ liệu...',
                        style: TextStyle(color: kGreen, fontWeight: FontWeight.w600, fontSize: 13),
                      )
                    ],
                  ),
                ),
            ],
          );
        }
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