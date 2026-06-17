import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Đã thêm import Firestore
import '../core/app_theme.dart';
import '../services/db_service.dart'; // Đã thêm import DatabaseService

class BloodSugarPage extends StatefulWidget {
  const BloodSugarPage({super.key});

  @override
  State<BloodSugarPage> createState() => _BloodSugarPageState();
}

class _BloodSugarPageState extends State<BloodSugarPage> {
  // Hàm hiển thị popup nhập liệu
  void _showAddSugarSheet() {
    int inputVal = 90;
    String selectedStatus = 'Lúc đói';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
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
                const Text('Thêm đường huyết', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kText)),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: inputVal.toString(),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFEF9A3A)),
                  decoration: InputDecoration(
                    suffixText: 'mg/dL',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFEF9A3A), width: 2)),
                  ),
                  onChanged: (val) => inputVal = int.tryParse(val) ?? 0,
                ),
                const SizedBox(height: 16),
                // Dropdown chọn trạng thái
                DropdownButtonFormField<String>(
                  value: selectedStatus,
                  items: ['Lúc đói', 'Sau ăn', 'Trước khi ngủ'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                  onChanged: (val) => setSheetState(() => selectedStatus = val!),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (inputVal > 0) {
                      DatabaseService().saveHealthRecord(
                        'blood_sugar', 
                        {
                          'value': inputVal,
                          'status': selectedStatus,
                        },
                      );
                    }
                    Navigator.pop(ctx);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF9A3A),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Lưu dữ liệu', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        ),
      ),
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
        title: const Text('Đường huyết', style: TextStyle(color: kText, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      // --- DÙNG STREAMBUILDER ĐỂ BỌC NỘI DUNG ---
      body: StreamBuilder<QuerySnapshot>(
        stream: DatabaseService().getRecordsStream('blood_sugar'),
        builder: (context, snapshot) {
          final docs = snapshot.hasData ? snapshot.data!.docs : [];
          
          // Lấy dữ liệu gần nhất (item đầu tiên)
          final latestData = docs.isNotEmpty ? docs.first.data() as Map<String, dynamic> : null;
          final latestValue = latestData?['value'];
          final latestStatus = latestData?['status'];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF5E8),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFFEF9A3A).withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        children: [
                          const Text('Chỉ số gần nhất', style: TextStyle(color: Color(0xFFEF9A3A), fontWeight: FontWeight.w600)),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(latestValue?.toString() ?? '--', style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: kText)),
                              const SizedBox(width: 8),
                              Text('mg/dL', style: TextStyle(fontSize: 16, color: kText.withValues(alpha: 0.6))),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (latestStatus != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                              child: Text(latestStatus, style: const TextStyle(color: kText, fontSize: 12, fontWeight: FontWeight.w600)),
                            )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _showAddSugarSheet,
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text('Thêm chỉ số', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEF9A3A),
                        minimumSize: const Size(double.infinity, 54),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ],
                ),
              ),
              
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(alignment: Alignment.centerLeft, child: Text('Lịch sử', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kText))),
              ),
              const SizedBox(height: 12),

              // --- DANH SÁCH LỊCH SỬ ĐỌC TỪ FIREBASE ---
              Expanded(
                child: docs.isEmpty
                    ? const Center(child: Text('Chưa có dữ liệu', style: TextStyle(color: kSubText)))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: docs.length,
                        itemBuilder: (ctx, i) {
                          final doc = docs[i];
                          final data = doc.data() as Map<String, dynamic>;
                          final value = data['value'];
                          final status = data['status'] ?? 'Không rõ';
                          
                          // Ép kiểu thời gian
                          final timestamp = data['timestamp'] as Timestamp?;
                          final time = timestamp?.toDate() ?? DateTime.now();

                          return Dismissible(
                            key: Key(doc.id), // ID của Firebase
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) {
                              // Xóa khỏi Firebase
                              doc.reference.delete();
                            },
                            background: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.red[100],
                                borderRadius: BorderRadius.circular(16) // Bo góc đồng bộ
                              ),
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              child: const Icon(Icons.delete, color: Colors.red),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                              child: Row(
                                children: [
                                  const Icon(Icons.water_drop, color: Color(0xFFEF9A3A)),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(status, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: kText)),
                                        // Hiển thị giờ phút phút thêm số 0 nếu dưới 10 (vd: 09:05)
                                        Text('${time.day}/${time.month} - ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}', style: const TextStyle(color: kSubText, fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                  Text('$value mg/dL', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: kText)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        }
      ),
    );
  }
}