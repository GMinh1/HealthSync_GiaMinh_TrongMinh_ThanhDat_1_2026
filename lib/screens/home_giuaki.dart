import 'package:flutter/material.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng ký thành công! Chào mừng bạn đến với HealthSync.'),
          backgroundColor: Colors.teal,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── FORM SECTION ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'HealthSync',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Theo dõi sức khỏe của bạn mọi lúc, mọi nơi',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 32),

                // Form Card
                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _fieldLabel('Họ'),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _nameController,
                          decoration: _inputDecoration('Nhập họ của bạn'),
                          validator: (v) =>
                              (v == null || v.isEmpty) ? 'Vui lòng nhập họ' : null,
                        ),
                        const SizedBox(height: 16),

                        _fieldLabel('Tên'),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _surnameController,
                          decoration: _inputDecoration('Nhập tên của bạn'),
                          validator: (v) =>
                              (v == null || v.isEmpty) ? 'Vui lòng nhập tên' : null,
                        ),
                        const SizedBox(height: 16),

                        _fieldLabel('Email'),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: _inputDecoration('Nhập địa chỉ email'),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Vui lòng nhập email';
                            if (!v.contains('@')) return 'Email không hợp lệ';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        _fieldLabel('Ghi chú sức khỏe'),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _messageController,
                          maxLines: 4,
                          decoration: _inputDecoration(
                              'Ví dụ: tiền sử bệnh, mục tiêu sức khỏe...'),
                        ),
                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Đăng ký ngay',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Thông tin của bạn được bảo mật hoàn toàn.',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ),

          // ── DIVIDER ──
          Divider(color: Colors.grey.shade200, thickness: 1, height: 1),

          // ── FOOTER SECTION ──
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo + social + 3 link columns
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo & social icons
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // App logo
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.favorite,
                              color: Colors.white, size: 24),
                        ),
                        const SizedBox(height: 16),
                        // Social icons
                        Row(
                          children: [
                            _socialIcon(Icons.close),           // X
                            const SizedBox(width: 10),
                            _socialIcon(Icons.camera_alt_outlined), // Instagram
                            const SizedBox(width: 10),
                            _socialIcon(Icons.play_circle_outline), // YouTube
                            const SizedBox(width: 10),
                            _socialIcon(Icons.work_outline),    // LinkedIn
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(width: 32),

                    // 3 link columns
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _footerColumn('Tính năng', [
                              'Theo dõi nhịp tim',
                              'Đo SpO2',
                              'Nhật ký giấc ngủ',
                              'Đếm bước chân',
                              'Theo dõi calo',
                              'Nhắc uống nước',
                              'Hồ sơ bệnh nhân',
                            ]),
                          ),
                          Expanded(
                            child: _footerColumn('Khám phá', [
                              'Bảng điều khiển',
                              'Biểu đồ sức khỏe',
                              'Lịch sử chỉ số',
                              'Mục tiêu cá nhân',
                              'Tư vấn AI',
                              'FitJam',
                            ]),
                          ),
                          Expanded(
                            child: _footerColumn('Tài nguyên', [
                              'Blog sức khỏe',
                              'Thực hành tốt nhất',
                              'Bảng chỉ số chuẩn',
                              'Hỗ trợ',
                              'Nhà phát triển',
                              'Thư viện tài liệu',
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),
                Divider(color: Colors.grey.shade200),
                const SizedBox(height: 14),

                // Copyright
                Text(
                  '© 2026 HealthSync – Phenikaa University  ·  Gia Minh · Trong Minh · Thanh Dat',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldLabel(String label) {
    return Text(label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500));
  }

  Widget _socialIcon(IconData icon) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 17, color: Colors.black87),
    );
  }

  Widget _footerColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
        const SizedBox(height: 12),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(item,
                style: TextStyle(fontSize: 13, color: Colors.grey[600])),
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      filled: true,
      fillColor: Colors.grey[50],
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.teal, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
    );
  }
}
