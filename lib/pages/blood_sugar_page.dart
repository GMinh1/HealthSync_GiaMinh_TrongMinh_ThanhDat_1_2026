import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class SugarRecord {
  final int value;
  final String status;
  final DateTime time;
  SugarRecord({required this.value, required this.status, required this.time});
}

class BloodSugarPage extends StatefulWidget {
  const BloodSugarPage({super.key});

  @override
  State<BloodSugarPage> createState() => _BloodSugarPageState();
}

class _BloodSugarPageState extends State<BloodSugarPage> {
  final List<SugarRecord> _records = [
    SugarRecord(value: 95, status: 'Lúc đói', time: DateTime.now()),
  ];

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
                      setState(() => _records.insert(0, SugarRecord(value: inputVal, status: selectedStatus, time: DateTime.now())));
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
        title: const Text('Đường huyết', style: TextStyle(color: kText, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
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
                          Text(latest?.value.toString() ?? '--', style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: kText)),
                          const SizedBox(width: 8),
                          Text('mg/dL', style: TextStyle(fontSize: 16, color: kText.withValues(alpha: 0.6))),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (latest != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                          child: Text(latest.status, style: const TextStyle(color: kText, fontSize: 12, fontWeight: FontWeight.w600)),
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
          // Danh sách lịch sử
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _records.length,
              itemBuilder: (ctx, i) {
                final r = _records[i];
                return Dismissible(
                  key: Key(r.time.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) => setState(() => _records.removeAt(i)),
                  background: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    color: Colors.red[100],
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
                              Text(r.status, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: kText)),
                              Text('${r.time.day}/${r.time.month} - ${r.time.hour}:${r.time.minute}', style: const TextStyle(color: kSubText, fontSize: 12)),
                            ],
                          ),
                        ),
                        Text('${r.value} mg/dL', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: kText)),
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