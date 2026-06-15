import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class HeartRecord {
  final int bpm;
  final DateTime time;
  HeartRecord({required this.bpm, required this.time});
}

class HeartRatePage extends StatefulWidget {
  const HeartRatePage({super.key});

  @override
  State<HeartRatePage> createState() => _HeartRatePageState();
}

class _HeartRatePageState extends State<HeartRatePage> {
  final List<HeartRecord> _records = [
    HeartRecord(bpm: 78, time: DateTime.now().subtract(const Duration(hours: 1))),
    HeartRecord(bpm: 82, time: DateTime.now().subtract(const Duration(days: 1))),
  ];

  void _showAddRecordSheet() {
    int inputBpm = 75; 
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
              const Text('Nhập nhịp tim', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kText)),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: inputBpm.toString(),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFD32F2F)),
                decoration: InputDecoration(
                  suffixText: 'BPM',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 2)),
                ),
                onChanged: (val) => inputBpm = int.tryParse(val) ?? 0,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (inputBpm > 0) {
                    setState(() => _records.insert(0, HeartRecord(bpm: inputBpm, time: DateTime.now())));
                  }
                  Navigator.pop(ctx);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE53935),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Lưu kết quả', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) => '${dt.day}/${dt.month} - ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

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
        title: const Text('Nhịp tim', style: TextStyle(color: kText, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFFFFD6D6), Color(0xFFFFBEBE)]),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Gần đây nhất', style: TextStyle(color: Color(0xFFD32F2F), fontWeight: FontWeight.bold)),
                          Icon(Icons.favorite, color: Color(0xFFD32F2F)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(latest?.bpm.toString() ?? '--', style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: kText)),
                          const SizedBox(width: 8),
                          Text('BPM', style: TextStyle(fontSize: 16, color: kText.withValues(alpha: 0.7))),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _showAddRecordSheet,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text('Thêm dữ liệu', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),
                    minimumSize: const Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(height: 32),
                const Align(alignment: Alignment.centerLeft, child: Text('Lịch sử', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kText))),
              ],
            ),
          ),
          
          Expanded(
            child: _records.isEmpty 
              ? const Center(child: Text('Chưa có dữ liệu', style: TextStyle(color: kSubText)))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _records.length,
                  itemBuilder: (ctx, i) {
                    final record = _records[i];
                    return Dismissible(
                      key: Key(record.time.millisecondsSinceEpoch.toString()),
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
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(color: Color(0xFFFFEBEE), shape: BoxShape.circle),
                              child: const Icon(Icons.favorite, color: Color(0xFFE53935), size: 20),
                            ),
                            const SizedBox(width: 16),
                            Expanded(child: Text(_formatTime(record.time), style: const TextStyle(color: kSubText, fontSize: 14))),
                            Text('${record.bpm} BPM', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: kText)),
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