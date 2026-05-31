import 'package:flutter/material.dart';
import '../core/app_theme.dart';

// ═══════════════════════════════════════════════════════════════════════
//  BP Category Logic
// ═══════════════════════════════════════════════════════════════════════
class BpCategoryInfo {
  final String label;
  final String range;
  final Color color;
  final int index;
  const BpCategoryInfo({
    required this.label,
    required this.range,
    required this.color,
    required this.index,
  });
}

BpCategoryInfo getBpCategory(int sys, int dia) {
  if (sys >= 180 || dia >= 120) {
    return const BpCategoryInfo(
      label: 'Crisis',
      range: 'SYS ≥180 or DIA ≥120',
      color: Color(0xFFE53935),
      index: 5,
    );
  }
  if (sys >= 140 || dia >= 90) {
    return const BpCategoryInfo(
      label: 'High Stage 2',
      range: 'SYS 140-179 or DIA 90-119',
      color: Color(0xFFEF6C00),
      index: 4,
    );
  }
  if (sys >= 130 || dia >= 80) {
    return const BpCategoryInfo(
      label: 'High Stage 1',
      range: 'SYS 130-139 or DIA 80-89',
      color: Color(0xFFFF9800),
      index: 3,
    );
  }
  if (sys >= 120 && dia < 80) {
    return const BpCategoryInfo(
      label: 'Elevated',
      range: 'SYS 120-129 and DIA <80',
      color: Color(0xFFFFCC02),
      index: 2,
    );
  }
  if (sys >= 90 && dia >= 60) {
    return const BpCategoryInfo(
      label: 'Normal',
      range: 'SYS 90-119 and DIA 60-79',
      color: Color(0xFF2DCB73),
      index: 1,
    );
  }
  return const BpCategoryInfo(
    label: 'Low',
    range: 'SYS <90 or DIA <60',
    color: Color(0xFF1E88E5),
    index: 0,
  );
}

// ═══════════════════════════════════════════════════════════════════════
//  Add / Edit Record Page
// ═══════════════════════════════════════════════════════════════════════
class AddRecordPage extends StatefulWidget {
  final int? initialSystolic;
  final int? initialDiastolic;
  final int? initialPulse;
  final DateTime? initialDateTime;

  const AddRecordPage({
    super.key,
    this.initialSystolic,
    this.initialDiastolic,
    this.initialPulse,
    this.initialDateTime,
  });

  bool get isEditing => initialSystolic != null;

  @override
  State<AddRecordPage> createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  late int _sys, _dia, _pul;
  late int _year, _month, _day, _hour, _minute;

  static const _catColors = [
    Color(0xFF1E88E5),
    Color(0xFF2DCB73),
    Color(0xFFFFCC02),
    Color(0xFFFF9800),
    Color(0xFFEF6C00),
    Color(0xFFE53935),
  ];

  @override
  void initState() {
    super.initState();
    final dt = widget.initialDateTime ?? DateTime.now();
    _sys = widget.initialSystolic ?? 110;
    _dia = widget.initialDiastolic ?? 70;
    _pul = widget.initialPulse ?? 70;
    _year = dt.year;
    _month = dt.month;
    _day = dt.day;
    _hour = dt.hour;
    _minute = dt.minute;
  }

  BpCategoryInfo get _cat => getBpCategory(_sys, _dia);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6F9),
      body: SafeArea(
        child: Column(
          children: [
            _appBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _pickerCard(),
                    const SizedBox(height: 16),
                    _dateTimeCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── AppBar ──────────────────────────────────────────────────────────────
  Widget _appBar(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
    child: Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              const Icon(Icons.chevron_left, size: 28, color: kText),
              Text(
                widget.isEditing ? 'Sửa chỉ số' : 'Thêm chỉ số',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kText,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // Nút chấm than giải thích 3 chỉ số
        GestureDetector(
          onTap: () => _showInfoSheet(context),
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFFFF9800),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF9800).withOpacity(0.4),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                '!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => Navigator.pop(context, {
            'systolic': _sys,
            'diastolic': _dia,
            'pulse': _pul,
            'year': _year,
            'month': _month,
            'day': _day,
            'hour': _hour,
            'minute': _minute,
          }),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
              color: kGreen,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Lưu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // ── Hiện bottom sheet giải thích 3 chỉ số ──────────────────────────────
  void _showInfoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _InfoBottomSheet(),
    );
  }

  // ── Picker Card ─────────────────────────────────────────────────────────
  Widget _pickerCard() => Container(
    padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
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
      children: [
        Row(
          children: [
            Expanded(
              child: _ValuePicker(
                key: ValueKey('sys'),
                label: 'Systolic',
                unit: 'mmHg',
                min: 60,
                max: 200,
                value: _sys,
                onChanged: (v) => setState(() => _sys = v),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _ValuePicker(
                key: ValueKey('dia'),
                label: 'Diastolic',
                unit: 'mmHg',
                min: 40,
                max: 130,
                value: _dia,
                onChanged: (v) => setState(() => _dia = v),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _ValuePicker(
                key: ValueKey('pul'),
                label: 'Pulse',
                unit: 'BPM',
                min: 30,
                max: 200,
                value: _pul,
                onChanged: (v) => setState(() => _pul = v),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Text(
            _cat.label,
            key: ValueKey(_cat.label),
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: _cat.color,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(_cat.range, style: const TextStyle(fontSize: 13, color: kSubText)),
        const SizedBox(height: 16),
        _CategoryBar(activeIndex: _cat.index, colors: _catColors),
      ],
    ),
  );

  // ── DateTime Card ───────────────────────────────────────────────────────
  Widget _dateTimeCard() => Container(
    padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
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
        const Text(
          'Date & Time',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: kText,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 150,
          child: Row(
            children: [
              Expanded(
                child: _WheelPicker(
                  items: List.generate(
                    10,
                    (i) => '${DateTime.now().year - 4 + i}',
                  ),
                  initialIndex: (_year - (DateTime.now().year - 4)).clamp(0, 9),
                  onChanged: (i) =>
                      setState(() => _year = DateTime.now().year - 4 + i),
                ),
              ),
              Expanded(
                child: _WheelPicker(
                  items: const ['Th2', 'Th3', 'Th4', 'Th5', 'Th6', 'Th7', 'CN'],
                  initialIndex: (DateTime(_year, _month, _day).weekday - 1) % 7,
                  onChanged: (_) {},
                ),
              ),
              Expanded(
                child: _WheelPicker(
                  items: List.generate(31, (i) => '${i + 1}'.padLeft(2, '0')),
                  initialIndex: _day - 1,
                  onChanged: (i) => setState(() => _day = i + 1),
                ),
              ),
              Expanded(
                child: _WheelPicker(
                  items: List.generate(24, (i) => '$i'.padLeft(2, '0')),
                  initialIndex: _hour,
                  onChanged: (i) => setState(() => _hour = i),
                ),
              ),
              const Text(
                ':',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kText,
                ),
              ),
              Expanded(
                child: _WheelPicker(
                  items: List.generate(60, (i) => '$i'.padLeft(2, '0')),
                  initialIndex: _minute,
                  onChanged: (i) => setState(() => _minute = i),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════
//  Value Picker (drum scroll)
// ═══════════════════════════════════════════════════════════════════════
class _ValuePicker extends StatefulWidget {
  final String label, unit;
  final int min, max, value;
  final ValueChanged<int> onChanged;
  const _ValuePicker({
    super.key,
    required this.label,
    required this.unit,
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
  });

  @override
  State<_ValuePicker> createState() => _ValuePickerState();
}

class _ValuePickerState extends State<_ValuePicker> {
  late final FixedExtentScrollController _ctrl;
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.value;
    _ctrl = FixedExtentScrollController(
      initialItem: (widget.value - widget.min).clamp(
        0,
        widget.max - widget.min,
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 180,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF2DCB73), Color(0xFF00C853)],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 1, color: Colors.white.withOpacity(0.5)),
                    const SizedBox(height: 46),
                    Container(height: 1, color: Colors.white.withOpacity(0.5)),
                  ],
                ),
              ),
              ListWheelScrollView.useDelegate(
                controller: _ctrl,
                itemExtent: 48,
                perspective: 0.003,
                diameterRatio: 1.8,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: (i) {
                  setState(() => _current = widget.min + i);
                  widget.onChanged(widget.min + i);
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: widget.max - widget.min + 1,
                  builder: (ctx, i) {
                    final val = widget.min + i;
                    final sel = val == _current;
                    return Center(
                      child: Text(
                        '$val',
                        style: TextStyle(
                          color: sel
                              ? Colors.white
                              : Colors.white.withOpacity(0.45),
                          fontSize: sel ? 32 : 20,
                          fontWeight: sel ? FontWeight.bold : FontWeight.w400,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: kText,
          ),
        ),
        Text(
          widget.unit,
          style: const TextStyle(fontSize: 11, color: kSubText),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
//  Category Bar
// ═══════════════════════════════════════════════════════════════════════
class _CategoryBar extends StatelessWidget {
  final int activeIndex;
  final List<Color> colors;
  const _CategoryBar({required this.activeIndex, required this.colors});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: List.generate(
          colors.length,
          (i) => Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 10,
              margin: EdgeInsets.only(right: i < colors.length - 1 ? 4 : 0),
              decoration: BoxDecoration(
                color: colors[i],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 4),
      Row(
        children: List.generate(
          colors.length,
          (i) => Expanded(
            child: Center(
              child: i == activeIndex
                  ? Icon(Icons.arrow_drop_up, color: colors[i], size: 22)
                  : const SizedBox.shrink(),
            ),
          ),
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════
//  Wheel Picker (date/time)
// ═══════════════════════════════════════════════════════════════════════
class _WheelPicker extends StatefulWidget {
  final List<String> items;
  final int initialIndex;
  final ValueChanged<int> onChanged;
  const _WheelPicker({
    required this.items,
    required this.initialIndex,
    required this.onChanged,
  });

  @override
  State<_WheelPicker> createState() => _WheelPickerState();
}

class _WheelPickerState extends State<_WheelPicker> {
  late final FixedExtentScrollController _ctrl;
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex.clamp(0, widget.items.length - 1);
    _ctrl = FixedExtentScrollController(initialItem: _current);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListWheelScrollView.useDelegate(
    controller: _ctrl,
    itemExtent: 44,
    perspective: 0.003,
    diameterRatio: 1.5,
    physics: const FixedExtentScrollPhysics(),
    onSelectedItemChanged: (i) {
      setState(() => _current = i);
      widget.onChanged(i);
    },
    childDelegate: ListWheelChildBuilderDelegate(
      childCount: widget.items.length,
      builder: (ctx, i) {
        final sel = i == _current;
        return Container(
          alignment: Alignment.center,
          decoration: sel
              ? BoxDecoration(
                  color: const Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(10),
                )
              : null,
          child: Text(
            widget.items[i],
            style: TextStyle(
              fontSize: sel ? 18 : 15,
              fontWeight: sel ? FontWeight.bold : FontWeight.w400,
              color: sel ? kText : kSubText,
            ),
          ),
        );
      },
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════
//  Info Bottom Sheet — giải thích 3 chỉ số huyết áp (tiếng Việt)
// ═══════════════════════════════════════════════════════════════════════
class _InfoBottomSheet extends StatelessWidget {
  const _InfoBottomSheet();

  static const _metrics = [
    _MetricInfo(
      icon: Icons.arrow_upward_rounded,
      iconColor: Color(0xFFE53935),
      iconBg: Color(0xFFFFEBEE),
      title: 'Huyết áp tâm thu (Systolic)',
      unit: 'mmHg',
      description:
          'Là áp lực máu tác động lên thành động mạch khi tim co bóp và bơm máu đi '
          'khắp cơ thể. Đây là chỉ số trên (số lớn hơn) trong phép đo huyết áp.\n\n'
          '• Bình thường: 90 – 119 mmHg\n'
          '• Cao: từ 130 mmHg trở lên\n'
          '• Rất cao (nguy hiểm): từ 180 mmHg trở lên',
    ),
    _MetricInfo(
      icon: Icons.arrow_downward_rounded,
      iconColor: Color(0xFF1E88E5),
      iconBg: Color(0xFFE3F2FD),
      title: 'Huyết áp tâm trương (Diastolic)',
      unit: 'mmHg',
      description:
          'Là áp lực máu trong động mạch khi tim nghỉ giữa các nhịp đập, tức là '
          'lúc tim đang giãn ra và nạp đầy máu. Đây là chỉ số dưới (số nhỏ hơn).\n\n'
          '• Bình thường: 60 – 79 mmHg\n'
          '• Cao: từ 80 mmHg trở lên\n'
          '• Rất cao (nguy hiểm): từ 120 mmHg trở lên',
    ),
    _MetricInfo(
      icon: Icons.favorite_rounded,
      iconColor: Color(0xFF2DCB73),
      iconBg: Color(0xFFE8F5E9),
      title: 'Nhịp tim (Pulse)',
      unit: 'BPM',
      description:
          'Là số lần tim đập trong một phút (Beats Per Minute). Nhịp tim phản ánh '
          'sức khỏe tim mạch và mức độ hoạt động thể chất của bạn.\n\n'
          '• Bình thường lúc nghỉ: 60 – 100 BPM\n'
          '• Vận động viên có thể thấp hơn: 40 – 60 BPM\n'
          '• Trên 100 BPM lúc nghỉ: cần theo dõi',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          children: [
            // drag handle
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 4),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFDDDDDD),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // title row
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        '!',
                        style: TextStyle(
                          color: Color(0xFFFF9800),
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Giải thích các chỉ số',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      color: Color(0xFF888888),
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 0, color: Color(0xFFF0F0F0)),
            // scrollable content
            Expanded(
              child: ListView.separated(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                itemCount: _metrics.length,
                separatorBuilder: (_, _) => const SizedBox(height: 16),
                itemBuilder: (_, i) => _MetricCard(info: _metrics[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Data model cho mỗi chỉ số ──────────────────────────────────────────
class _MetricInfo {
  final IconData icon;
  final Color iconColor, iconBg;
  final String title, unit, description;
  const _MetricInfo({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.unit,
    required this.description,
  });
}

// ── Card hiển thị từng chỉ số ───────────────────────────────────────────
class _MetricCard extends StatefulWidget {
  final _MetricInfo info;
  const _MetricCard({required this.info});

  @override
  State<_MetricCard> createState() => _MetricCardState();
}

class _MetricCardState extends State<_MetricCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final info = widget.info;
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _expanded
              ? info.iconBg.withOpacity(0.6)
              : const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _expanded
                ? info.iconColor.withOpacity(0.3)
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: info.iconBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(info.icon, color: info.iconColor, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        info.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Đơn vị: ${info.unit}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF888888),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedRotation(
                  turns: _expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: info.iconColor,
                    size: 26,
                  ),
                ),
              ],
            ),
            // expanded description
            if (_expanded) ...[
              const SizedBox(height: 14),
              Container(height: 1, color: info.iconColor.withOpacity(0.15)),
              const SizedBox(height: 12),
              Text(
                info.description,
                style: const TextStyle(
                  fontSize: 13.5,
                  color: Color(0xFF444444),
                  height: 1.6,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
