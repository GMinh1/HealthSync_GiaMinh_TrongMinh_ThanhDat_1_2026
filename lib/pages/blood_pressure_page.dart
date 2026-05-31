import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/app_theme.dart';
import 'add_record_page.dart';

// ═══════════════════════════════════════════════════════════════════════
//  Data Model
// ═══════════════════════════════════════════════════════════════════════
class BpRecord {
  final int systolic, diastolic, pulse;
  final DateTime dateTime;

  BpRecord({
    required this.systolic,
    required this.diastolic,
    required this.pulse,
    required this.dateTime,
  });

  BpCategoryInfo get category => getBpCategory(systolic, diastolic);

  String get dateLabel =>
      '${dateTime.month.toString().padLeft(2, '0')}.${dateTime.day.toString().padLeft(2, '0')}';

  BpRecord copyWith({
    int? systolic,
    int? diastolic,
    int? pulse,
    DateTime? dateTime,
  }) => BpRecord(
    systolic: systolic ?? this.systolic,
    diastolic: diastolic ?? this.diastolic,
    pulse: pulse ?? this.pulse,
    dateTime: dateTime ?? this.dateTime,
  );
}

// ═══════════════════════════════════════════════════════════════════════
//  Blood Pressure Page
// ═══════════════════════════════════════════════════════════════════════
class BloodPressurePage extends StatefulWidget {
  const BloodPressurePage({super.key});

  @override
  State<BloodPressurePage> createState() => _BloodPressurePageState();
}

class _BloodPressurePageState extends State<BloodPressurePage> {
  final List<BpRecord> _records = [
    BpRecord(
      systolic: 110,
      diastolic: 70,
      pulse: 70,
      dateTime: DateTime(2025, 5, 18, 9, 32),
    ),
    BpRecord(
      systolic: 118,
      diastolic: 75,
      pulse: 72,
      dateTime: DateTime(2025, 6, 10, 8, 15),
    ),
    BpRecord(
      systolic: 125,
      diastolic: 82,
      pulse: 80,
      dateTime: DateTime(2025, 9, 5, 7, 44),
    ),
    BpRecord(
      systolic: 105,
      diastolic: 65,
      pulse: 68,
      dateTime: DateTime(2025, 11, 20, 10, 0),
    ),
    BpRecord(
      systolic: 135,
      diastolic: 88,
      pulse: 85,
      dateTime: DateTime(2026, 1, 14, 9, 0),
    ),
  ];

  // sort by date ascending for chart, descending for list
  List<BpRecord> get _chartRecords =>
      [..._records]..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  List<BpRecord> get _listRecords =>
      [..._records]..sort((a, b) => b.dateTime.compareTo(a.dateTime));

  BpRecord? get _latest => _records.isEmpty ? null : _chartRecords.last;

  // ─── Navigate → Add ────────────────────────────────────────────────
  Future<void> _openAddRecord() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const AddRecordPage()),
    );
    if (result == null) return;
    setState(() => _records.add(_fromMap(result)));
  }

  // ─── Navigate → Edit ───────────────────────────────────────────────
  Future<void> _openEditRecord(BpRecord original) async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => AddRecordPage(
          initialSystolic: original.systolic,
          initialDiastolic: original.diastolic,
          initialPulse: original.pulse,
          initialDateTime: original.dateTime,
        ),
      ),
    );
    if (result == null) return;
    setState(() {
      final idx = _records.indexOf(original);
      if (idx != -1) _records[idx] = _fromMap(result);
    });
  }

  // ─── Delete with confirm dialog ────────────────────────────────────
  Future<void> _confirmDelete(BpRecord record) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Delete record',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Delete record ${record.systolic}/${record.diastolic} mmHg on ${_formatDateTime(record.dateTime)}?',
          style: const TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel', style: TextStyle(color: kSubText)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Color(0xFFE53935),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
    if (ok == true) setState(() => _records.remove(record));
  }

  BpRecord _fromMap(Map<String, dynamic> m) => BpRecord(
    systolic: m['systolic'] as int,
    diastolic: m['diastolic'] as int,
    pulse: m['pulse'] as int,
    dateTime: DateTime(
      m['year'] as int,
      m['month'] as int,
      m['day'] as int,
      m['hour'] as int,
      m['minute'] as int,
    ),
  );

  // ═══════════════════════════════════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6F9),
      body: Stack(
        children: [
          Container(
            height: 140,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2DCB73), Color(0xFF00BCD4)],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(context),
                _buildDateFilter(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    child: Column(
                      children: [
                        _buildLatestCard(),
                        const SizedBox(height: 16),
                        _buildChartCard(),
                        const SizedBox(height: 16),
                        _buildRecordList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── AppBar ──────────────────────────────────────────────────────────
  Widget _buildAppBar(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
    child: Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.chevron_left, color: Colors.white, size: 30),
        ),
        const SizedBox(width: 4),
        const Text(
          'Blood Pressure',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );

  Widget _buildDateFilter() => Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
    child: Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '27 Th5, 2025 - 27 Th5, 2026',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.filter_list, color: Colors.white, size: 16),
          ],
        ),
      ),
    ),
  );

  // ─── Latest Card ─────────────────────────────────────────────────────
  Widget _buildLatestCard() {
    final r = _latest;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Latest Blood Pressure',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kText,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatItem(
                label: 'Systolic',
                value: r != null ? '${r.systolic}' : '--',
                unit: 'mmHg',
              ),
              _HDivider(),
              _StatItem(
                label: 'Diastolic',
                value: r != null ? '${r.diastolic}' : '--',
                unit: 'mmHg',
              ),
              _HDivider(),
              _StatItem(
                label: 'Pulse',
                value: r != null ? '${r.pulse}' : '--',
                unit: 'BPM',
              ),
            ],
          ),
          if (r != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: r.category.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                r.category.label,
                style: TextStyle(
                  color: r.category.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ─── Chart Card ──────────────────────────────────────────────────────
  Widget _buildChartCard() => Container(
    padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      children: [
        SizedBox(
          height: 220,
          child: _records.isEmpty
              ? const Center(
                  child: Text(
                    'No records yet',
                    style: TextStyle(color: kSubText),
                  ),
                )
              : _BpChart(records: _chartRecords),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _openAddRecord,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: kGreen, width: 1.5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: kGreen, size: 20),
                SizedBox(width: 6),
                Text(
                  'Add Record',
                  style: TextStyle(
                    color: kGreen,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  // ─── Record List (swipe to delete, tap to edit) ───────────────────────
  Widget _buildRecordList() {
    final sorted = _listRecords;
    if (sorted.isEmpty) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Text(
              'History',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kText,
              ),
            ),
          ),
          ...List.generate(sorted.length, (i) {
            final r = sorted[i];
            return Column(
              children: [
                // Swipe left → delete, tap → edit
                Dismissible(
                  key: ValueKey(r.dateTime.millisecondsSinceEpoch),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (_) async {
                    // show confirm inside Dismissible
                    final ok = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: const Text(
                          'Delete record',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: Text(
                          'Delete ${r.systolic}/${r.diastolic} mmHg?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: kSubText),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: const Text(
                              'Delete',
                              style: TextStyle(
                                color: Color(0xFFE53935),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    return ok == true;
                  },
                  onDismissed: (_) => setState(() => _records.remove(r)),
                  // Red delete background revealed on swipe
                  background: Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    padding: const EdgeInsets.only(right: 24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.only(
                        topRight: i == 0
                            ? const Radius.circular(24)
                            : Radius.zero,
                        bottomRight: i == sorted.length - 1
                            ? const Radius.circular(24)
                            : Radius.zero,
                      ),
                    ),
                    alignment: Alignment.centerRight,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete_outline,
                          color: Color(0xFFE53935),
                          size: 26,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Delete',
                          style: TextStyle(
                            color: Color(0xFFE53935),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () => _openEditRecord(r),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          // Category dot
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: r.category.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Values + date
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${r.systolic}/${r.diastolic} mmHg  •  ${r.pulse} BPM',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: kText,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  _formatDateTime(r.dateTime),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: kSubText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Category badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: r.category.color.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              r.category.label,
                              style: TextStyle(
                                color: r.category.color,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Edit icon hint
                          const Icon(
                            Icons.edit_outlined,
                            size: 16,
                            color: kSubText,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (i < sorted.length - 1)
                  const Divider(height: 0, indent: 42, color: kDivider),
              ],
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return '${days[dt.weekday - 1]}, ${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}  ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

// ═══════════════════════════════════════════════════════════════════════
//  BP Bar Chart (CustomPainter)
// ═══════════════════════════════════════════════════════════════════════
class _BpChart extends StatelessWidget {
  final List<BpRecord> records;
  const _BpChart({required this.records});

  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: _BpChartPainter(records: records),
    child: const SizedBox.expand(),
  );
}

class _BpChartPainter extends CustomPainter {
  final List<BpRecord> records;
  static const _minY = 60.0, _maxY = 160.0;
  _BpChartPainter({required this.records});

  @override
  void paint(Canvas canvas, Size size) {
    const lP = 38.0, rP = 16.0, tP = 20.0, bP = 28.0;
    final cH = size.height - tP - bP;
    final cW = size.width - lP - rP;

    final gridPaint = Paint()
      ..color = const Color(0xFFDDDDDD)
      ..strokeWidth = 1;

    for (final y in [60, 80, 100, 120, 140, 160]) {
      final dy = tP + cH * (1 - (y - _minY) / (_maxY - _minY));
      _dashed(canvas, Offset(lP, dy), Offset(size.width - rP, dy), gridPaint);
      _text(canvas, '$y', Offset(0, dy - 7), const Color(0xFFAAAAAA), 11);
    }
    if (records.isEmpty) return;

    final bW = math.min(cW / records.length * 0.4, 18.0);
    final sp = cW / records.length;

    for (int i = 0; i < records.length; i++) {
      final r = records[i];
      final cx = lP + sp * i + sp / 2;
      final sY = tP + cH * (1 - (r.systolic - _minY) / (_maxY - _minY));
      final dY = tP + cH * (1 - (r.diastolic - _minY) / (_maxY - _minY));

      // bar coloured by category
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTRB(cx - bW / 2, sY, cx + bW / 2, dY),
          const Radius.circular(8),
        ),
        Paint()..color = r.category.color,
      );
      _text(canvas, '${r.systolic}', Offset(cx - 10, sY - 16), kText, 11);
      _text(canvas, '${r.diastolic}', Offset(cx - 10, dY + 2), kText, 11);
      _text(
        canvas,
        r.dateLabel,
        Offset(cx - 14, size.height - bP + 6),
        kSubText,
        11,
      );
    }
  }

  void _dashed(Canvas c, Offset s, Offset e, Paint p) {
    double x = s.dx;
    while (x < e.dx) {
      c.drawLine(Offset(x, s.dy), Offset(math.min(x + 5, e.dx), s.dy), p);
      x += 9;
    }
  }

  void _text(Canvas c, String t, Offset o, Color col, double sz) {
    (TextPainter(
      text: TextSpan(
        text: t,
        style: TextStyle(color: col, fontSize: sz),
      ),
      textDirection: TextDirection.ltr,
    )..layout()).paint(c, o);
  }

  @override
  bool shouldRepaint(_BpChartPainter old) => old.records != records;
}

// ═══════════════════════════════════════════════════════════════════════
//  Shared small widgets
// ═══════════════════════════════════════════════════════════════════════
class _StatItem extends StatelessWidget {
  final String label, value, unit;
  const _StatItem({
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(label, style: const TextStyle(fontSize: 13, color: kSubText)),
      const SizedBox(height: 4),
      Text(
        value,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: kText,
        ),
      ),
      Text(unit, style: const TextStyle(fontSize: 12, color: kSubText)),
    ],
  );
}

class _HDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(height: 50, width: 1, color: const Color(0xFFEEEEEE));
}
