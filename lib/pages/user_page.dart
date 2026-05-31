import 'package:flutter/material.dart';
import '../core/app_theme.dart';

// ═══════════════════════════════════════════════════════════════════════
//  User Page — có login / profile
// ═══════════════════════════════════════════════════════════════════════
class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // null = chưa đăng nhập
  _UserProfile? _profile;

  void _openLogin() async {
    final result = await Navigator.push<_UserProfile>(
      context,
      MaterialPageRoute(builder: (_) => const _LoginPage()),
    );
    if (result != null) setState(() => _profile = result);
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Đăng xuất',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text('Bạn có chắc muốn đăng xuất không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Huỷ', style: TextStyle(color: kSubText)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() => _profile = null);
            },
            child: const Text(
              'Đăng xuất',
              style: TextStyle(
                color: Color(0xFFE53935),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F0E8),
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Profile / Login card ──────────────────────────────────
              _profile == null
                  ? _GuestCard(onLogin: _openLogin)
                  : _ProfileCard(profile: _profile!, onLogout: _logout),

              const SizedBox(height: 28),

              // ── General ──────────────────────────────────────────────
              const _SectionHeader('General'),
              const SizedBox(height: 10),
              const _SettingsCard(
                items: [
                  _SettingItem(icon: Icons.alarm_outlined, label: 'Nhắc nhở'),
                  _SettingItem(
                    icon: Icons.language_outlined,
                    label: 'Ngôn ngữ',
                  ),
                  _SettingItem(
                    icon: Icons.notifications_outlined,
                    label: 'Thông báo',
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // ── Service & Policy ─────────────────────────────────────
              const _SectionHeader('Dịch vụ & Chính sách'),
              const SizedBox(height: 10),
              const _SettingsCard(
                items: [
                  _SettingItem(
                    icon: Icons.thumb_up_outlined,
                    label: 'Đánh giá ứng dụng',
                  ),
                  _SettingItem(
                    icon: Icons.description_outlined,
                    label: 'Chính sách bảo mật',
                  ),
                  _SettingItem(
                    icon: Icons.info_outline,
                    label: 'Phiên bản',
                    versionTag: 'v1.0.63',
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // ── Collection ───────────────────────────────────────────
              const _SectionHeader('Bộ sưu tập'),
              const SizedBox(height: 10),
              const _SettingsCard(
                items: [
                  _SettingItem(
                    icon: Icons.menu_book_outlined,
                    label: 'Túi công thức',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
//  Guest Card — chưa đăng nhập
// ═══════════════════════════════════════════════════════════════════════
class _GuestCard extends StatelessWidget {
  final VoidCallback onLogin;
  const _GuestCard({required this.onLogin});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar placeholder
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFDDDDDD), width: 2),
            ),
            child: const Icon(
              Icons.person_outline,
              size: 40,
              color: Color(0xFFBBBBBB),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Chưa đăng nhập',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: kText,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Đăng nhập để lưu dữ liệu sức khoẻ\nvà đồng bộ trên mọi thiết bị',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: kSubText, height: 1.5),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: onLogin,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2DCB73), Color(0xFF00BCD4)],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: kGreen.withOpacity(0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.login_rounded, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Đăng nhập / Đăng ký',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
//  Profile Card — đã đăng nhập
// ═══════════════════════════════════════════════════════════════════════
class _ProfileCard extends StatelessWidget {
  final _UserProfile profile;
  final VoidCallback onLogout;
  const _ProfileCard({required this.profile, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2DCB73), Color(0xFF00BCD4)],
        ),
        boxShadow: [
          BoxShadow(
            color: kGreen.withOpacity(0.35),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.6),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      profile.name.isNotEmpty
                          ? profile.name[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        profile.email,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.85),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Divider
          Container(height: 1, color: Colors.white.withOpacity(0.2)),
          // Actions row
          Row(
            children: [
              Expanded(
                child: _ProfileAction(
                  icon: Icons.edit_outlined,
                  label: 'Sửa hồ sơ',
                  onTap: () {},
                ),
              ),
              Container(
                width: 1,
                height: 44,
                color: Colors.white.withOpacity(0.2),
              ),
              Expanded(
                child: _ProfileAction(
                  icon: Icons.logout_rounded,
                  label: 'Đăng xuất',
                  onTap: onLogout,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ProfileAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
//  Login Page
// ═══════════════════════════════════════════════════════════════════════
class _LoginPage extends StatefulWidget {
  const _LoginPage();

  @override
  State<_LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<_LoginPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  final _loginForm = GlobalKey<FormState>();
  final _signupForm = GlobalKey<FormState>();

  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _emailCtrl2 = TextEditingController();
  final _passCtrl2 = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _hidePass = true;
  bool _hidePass2 = true;
  bool _hideConf = true;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    for (final c in [
      _emailCtrl,
      _passCtrl,
      _nameCtrl,
      _emailCtrl2,
      _passCtrl2,
      _confirmCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    final isLogin = _tab.index == 0;
    final form = isLogin ? _loginForm : _signupForm;
    if (!(form.currentState?.validate() ?? false)) return;

    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 900)); // giả lập network

    final profile = _UserProfile(
      name: isLogin ? _emailCtrl.text.split('@')[0] : _nameCtrl.text.trim(),
      email: isLogin ? _emailCtrl.text.trim() : _emailCtrl2.text.trim(),
    );
    if (mounted) Navigator.pop(context, profile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6F9),
      body: Stack(
        children: [
          // gradient header
          Container(
            height: 220,
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
                // AppBar
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Tài khoản',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // Logo area
                const SizedBox(height: 16),
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.monitor_heart,
                    color: kGreen,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'HealthSync',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                // Card
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Tab bar
                        Container(
                          margin: const EdgeInsets.all(12),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F4F8),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: TabBar(
                            controller: _tab,
                            indicator: BoxDecoration(
                              color: kGreen,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: kGreen.withOpacity(0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: Colors.white,
                            unselectedLabelColor: kSubText,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                            unselectedLabelStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            dividerColor: Colors.transparent,
                            tabs: const [
                              Tab(text: 'Đăng nhập'),
                              Tab(text: 'Đăng ký'),
                            ],
                          ),
                        ),

                        // Forms
                        Expanded(
                          child: TabBarView(
                            controller: _tab,
                            children: [
                              _LoginForm(
                                formKey: _loginForm,
                                emailCtrl: _emailCtrl,
                                passCtrl: _passCtrl,
                                hidePass: _hidePass,
                                onTogglePass: () =>
                                    setState(() => _hidePass = !_hidePass),
                                loading: _loading,
                                onSubmit: _submit,
                              ),
                              _SignupForm(
                                formKey: _signupForm,
                                nameCtrl: _nameCtrl,
                                emailCtrl: _emailCtrl2,
                                passCtrl: _passCtrl2,
                                confirmCtrl: _confirmCtrl,
                                hidePass: _hidePass2,
                                hideConfirm: _hideConf,
                                onTogglePass: () =>
                                    setState(() => _hidePass2 = !_hidePass2),
                                onToggleConfirm: () =>
                                    setState(() => _hideConf = !_hideConf),
                                loading: _loading,
                                onSubmit: _submit,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Login form ──────────────────────────────────────────────────────────
class _LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtrl, passCtrl;
  final bool hidePass, loading;
  final VoidCallback onTogglePass, onSubmit;

  const _LoginForm({
    required this.formKey,
    required this.emailCtrl,
    required this.passCtrl,
    required this.hidePass,
    required this.loading,
    required this.onTogglePass,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            _Field(
              ctrl: emailCtrl,
              label: 'Email',
              hint: 'example@email.com',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
            ),
            const SizedBox(height: 14),
            _Field(
              ctrl: passCtrl,
              label: 'Mật khẩu',
              hint: '••••••••',
              icon: Icons.lock_outline,
              obscure: hidePass,
              suffixIcon: GestureDetector(
                onTap: onTogglePass,
                child: Icon(
                  hidePass
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: kSubText,
                  size: 20,
                ),
              ),
              validator: _validatePass,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Quên mật khẩu?',
                style: TextStyle(
                  color: kGreen,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 22),
            _SubmitButton(
              label: 'Đăng nhập',
              loading: loading,
              onTap: onSubmit,
            ),
            const SizedBox(height: 20),
            _OrDivider(),
            const SizedBox(height: 16),
            _SocialButton(
              icon: Icons.g_mobiledata_rounded,
              label: 'Tiếp tục với Google',
              color: const Color(0xFFDB4437),
            ),
            const SizedBox(height: 10),
            _SocialButton(
              icon: Icons.apple,
              label: 'Tiếp tục với Apple',
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Signup form ─────────────────────────────────────────────────────────
class _SignupForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameCtrl, emailCtrl, passCtrl, confirmCtrl;
  final bool hidePass, hideConfirm, loading;
  final VoidCallback onTogglePass, onToggleConfirm, onSubmit;

  const _SignupForm({
    required this.formKey,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.passCtrl,
    required this.confirmCtrl,
    required this.hidePass,
    required this.hideConfirm,
    required this.loading,
    required this.onTogglePass,
    required this.onToggleConfirm,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            _Field(
              ctrl: nameCtrl,
              label: 'Họ và tên',
              hint: 'Nguyễn Văn A',
              icon: Icons.person_outline,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Vui lòng nhập họ tên'
                  : null,
            ),
            const SizedBox(height: 14),
            _Field(
              ctrl: emailCtrl,
              label: 'Email',
              hint: 'example@email.com',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
            ),
            const SizedBox(height: 14),
            _Field(
              ctrl: passCtrl,
              label: 'Mật khẩu',
              hint: 'Tối thiểu 6 ký tự',
              icon: Icons.lock_outline,
              obscure: hidePass,
              suffixIcon: GestureDetector(
                onTap: onTogglePass,
                child: Icon(
                  hidePass
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: kSubText,
                  size: 20,
                ),
              ),
              validator: _validatePass,
            ),
            const SizedBox(height: 14),
            _Field(
              ctrl: confirmCtrl,
              label: 'Xác nhận mật khẩu',
              hint: '••••••••',
              icon: Icons.lock_outline,
              obscure: hideConfirm,
              suffixIcon: GestureDetector(
                onTap: onToggleConfirm,
                child: Icon(
                  hideConfirm
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: kSubText,
                  size: 20,
                ),
              ),
              validator: (v) =>
                  v != passCtrl.text ? 'Mật khẩu không khớp' : null,
            ),
            const SizedBox(height: 22),
            _SubmitButton(
              label: 'Tạo tài khoản',
              loading: loading,
              onTap: onSubmit,
            ),
            const SizedBox(height: 12),
            Text(
              'Bằng cách đăng ký, bạn đồng ý với\nĐiều khoản dịch vụ và Chính sách bảo mật',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: kSubText.withOpacity(0.8),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Shared form widgets ─────────────────────────────────────────────────
class _Field extends StatelessWidget {
  final TextEditingController ctrl;
  final String label, hint;
  final IconData icon;
  final bool obscure;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _Field({
    required this.ctrl,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: ctrl,
      obscureText: obscure,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(fontSize: 15, color: kText),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFCCCCCC), fontSize: 14),
        labelStyle: const TextStyle(color: kSubText, fontSize: 13),
        prefixIcon: Icon(icon, color: kGreen, size: 20),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFFF8FAFB),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE8E8E8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE8E8E8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: kGreen, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE53935)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE53935), width: 1.5),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final String label;
  final bool loading;
  final VoidCallback onTap;
  const _SubmitButton({
    required this.label,
    required this.loading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2DCB73), Color(0xFF00BCD4)],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: kGreen.withOpacity(0.35),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: loading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFEEEEEE))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'hoặc',
            style: TextStyle(color: kSubText.withOpacity(0.7), fontSize: 13),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFEEEEEE))),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE8E8E8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: kText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
//  User profile model
// ═══════════════════════════════════════════════════════════════════════
class _UserProfile {
  final String name, email;
  const _UserProfile({required this.name, required this.email});
}

// ═══════════════════════════════════════════════════════════════════════
//  Validators
// ═══════════════════════════════════════════════════════════════════════
String? _validateEmail(String? v) {
  if (v == null || v.trim().isEmpty) return 'Vui lòng nhập email';
  final re = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
  if (!re.hasMatch(v.trim())) return 'Email không hợp lệ';
  return null;
}

String? _validatePass(String? v) {
  if (v == null || v.isEmpty) return 'Vui lòng nhập mật khẩu';
  if (v.length < 6) return 'Mật khẩu tối thiểu 6 ký tự';
  return null;
}

// ═══════════════════════════════════════════════════════════════════════
//  Shared small widgets (Settings)
// ═══════════════════════════════════════════════════════════════════════
class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 4,
        height: 22,
        decoration: BoxDecoration(
          color: kGreen,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      const SizedBox(width: 10),
      Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: kText,
        ),
      ),
    ],
  );
}

class _SettingItem {
  final IconData icon;
  final String label;
  final String? versionTag;
  const _SettingItem({
    required this.icon,
    required this.label,
    this.versionTag,
  });
}

class _SettingsCard extends StatelessWidget {
  final List<_SettingItem> items;
  const _SettingsCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: List.generate(items.length, (i) {
          final item = items[i];
          return Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      Icon(item.icon, color: const Color(0xFF888888), size: 22),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          item.label,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      if (item.versionTag != null) ...[
                        Text(
                          item.versionTag!,
                          style: const TextStyle(fontSize: 14, color: kSubText),
                        ),
                        const SizedBox(width: 4),
                      ],
                      if (item.versionTag == null)
                        const Icon(
                          Icons.chevron_right,
                          color: Color(0xFFCCCCCC),
                          size: 20,
                        ),
                    ],
                  ),
                ),
              ),
              if (i < items.length - 1)
                const Divider(height: 0, indent: 52, color: kDivider),
            ],
          );
        }),
      ),
    );
  }
}
