import 'package:flutter/material.dart';
import '../core/app_theme.dart';

// ─── Data Model ────────────────────────────────────────────────────────
class BmiRecord {
  final double weight; // kg
  final double height; // cm
  final DateTime time;

  BmiRecord({
    required this.weight,
    required this.height,
    required this.time,
  });

  // Công thức BMI = Cân nặng (kg) / (Chiều cao (m) * Chiều cao (m))
  double get bmi => weight / ((height / 100) * (height / 100));

  // Phân loại BMI theo chuẩn Châu Á
  String get status {
    if (bmi < 18.5) return "Thiếu cân";
    if (bmi < 23) return "Bình thường";
    if (bmi < 25) return "Thừa cân";
    return "Béo phì";
  }

  // Màu sắc tương ứng với tình trạng
  Color get statusColor {
    if (bmi < 18.5) return const Color(0xFF29B6F6); // Xanh dương
    if (bmi < 23) return kGreen;                    // Xanh lá
    if (bmi < 25) return const Color(0xFFFFA726);   // Cam
    return const Color(0xFFE53935);                 // Đỏ
  }
}

// ─── Weight & BMI Page ─────────────────────────────────────────────────
class WeightBmiPage extends StatefulWidget {
  const WeightBmiPage({super.key});

  @override
  State<WeightBmiPage> createState() => _WeightBmiPageState();
}

class _WeightBmiPageState extends State<WeightBmiPage> {
  // Dữ liệu mẫu ban đầu
  final List<BmiRecord> _records = [
    BmiRecord(weight: 65.5, height: 170.0, time: DateTime.now()),
  ];

  // ─── Bottom Sheet Nhập liệu ──────────────────────────────────────────
  void _showAddRecordSheet() {
    // Lấy số đo gần nhất làm mặc định để người dùng đỡ phải nhập lại nhiều
    double inputWeight = _records.isNotEmpty ? _records.first.weight : 60.0;
    double inputHeight = _records.isNotEmpty ? _records.first.height : 170.0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Cập nhật chỉ số',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kText),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  // Nhập Cân nặng
                  Expanded(
                    child: TextFormField(
                      initialValue: inputWeight.toString(),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF7C6FEF)),
                      decoration: InputDecoration(
                        labelText: 'Cân nặng',
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        suffixText: 'kg',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Color(0xFF7C6FEF), width: 2),
                        ),
                      ),
                      onChanged: (val) => inputWeight = double.tryParse(val) ?? inputWeight,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Nhập Chiều cao
                  Expanded(
                    child: TextFormField(
                      initialValue: inputHeight.toString(),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF7C6FEF)),
                      decoration: InputDecoration(
                        labelText: 'Chiều cao',
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        suffixText: 'cm',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Color(0xFF7C6FEF), width: 2),
                        ),
                      ),
                      onChanged: (val) => inputHeight = double.tryParse(val) ?? inputHeight,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (inputWeight > 0 && inputHeight > 0) {
                    setState(() {
                      _records.insert(0, BmiRecord(weight: inputWeight, height: inputHeight, time: DateTime.now()));
                    });
                  }
                  Navigator.pop(ctx);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C6FEF),
                  minimumSize: const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Text(
                  'Lưu chỉ số',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ─── Xây dựng giao diện ──────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final latest = _records.isNotEmpty ? _records.first : null;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: kText, size: 32),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Cân nặng & BMI', style: TextStyle(color: kText, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // ─── Cân nặng & Chiều cao ───
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Cân nặng', style: TextStyle(color: kSubText, fontSize: 14)),
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  latest != null ? latest.weight.toString() : '--',
                                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: kText),
                                ),
                                const SizedBox(width: 4),
                                Text('kg', style: TextStyle(fontSize: 14, color: kText.withValues(alpha: 0.5))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Chiều cao', style: TextStyle(color: kSubText, fontSize: 14)),
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  latest != null ? latest.height.toString() : '--',
                                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: kText),
                                ),
                                const SizedBox(width: 4),
                                Text('cm', style: TextStyle(fontSize: 14, color: kText.withValues(alpha: 0.5))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // ─── Thẻ BMI Tổng hợp ───
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0EEFF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Chỉ số BMI của bạn',
                        style: TextStyle(color: Color(0xFF7C6FEF), fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        latest != null ? latest.bmi.toStringAsFixed(1) : '--',
                        style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Color(0xFF7C6FEF)),
                      ),
                      const SizedBox(height: 12),
                      if (latest != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: latest.statusColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            latest.status,
                            style: TextStyle(
                              color: latest.statusColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ─── Nút Cập nhật ───
                ElevatedButton.icon(
                  onPressed: _showAddRecordSheet,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text('Cập nhật chỉ số', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C6FEF),
                    minimumSize: const Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                ),
              ],
            ),
          ),
          
          // ─── Lịch sử ───
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft, 
              child: Text('Lịch sử', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kText))
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _records.isEmpty 
              ? const Center(child: Text('Chưa có dữ liệu', style: TextStyle(color: kSubText)))
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  itemCount: _records.length,
                  itemBuilder: (ctx, i) {
                    final r = _records[i];
                    return Dismissible(
                      key: Key(r.time.millisecondsSinceEpoch.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => setState(() => _records.removeAt(i)),
                      background: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(color: Colors.red[100], borderRadius: BorderRadius.circular(16)),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete, color: Colors.red),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${r.time.day}/${r.time.month}/${r.time.year}', style: const TextStyle(color: kSubText, fontSize: 13)),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text('${r.weight} kg', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: kText)),
                                    const Text(' • ', style: TextStyle(color: kSubText)),
                                    Text('${r.height} cm', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: kText)),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: r.statusColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'BMI: ${r.bmi.toStringAsFixed(1)}',
                                style: TextStyle(color: r.statusColor, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}