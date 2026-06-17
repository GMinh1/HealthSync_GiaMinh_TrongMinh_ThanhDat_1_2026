import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../services/db_service.dart';
import 'login_page.dart';
import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import 'favorite_recipes_page.dart';
import 'favorite_workouts_page.dart';

// ═══════════════════════════════════════════════════════════════════════
//  User Page — có login / profile
// ═══════════════════════════════════════════════════════════════════════
class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  _UserProfile? _profile;

  bool _waterReminder = true;
  bool _workoutReminder = false;
  bool _healthReminder = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile(); 
  }

  Future<void> _loadUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      if (mounted) {
        setState(() {
          _profile = _UserProfile(
            name: user.displayName ?? 'Người dùng',
            email: user.email ?? '',
          );
        });
      }

      final doc = await DatabaseService().getUserProfile();
      if (doc != null && doc.exists && mounted) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          _profile = _UserProfile(
            name: data['name'] ?? user.displayName ?? 'Người dùng',
            email: data['email'] ?? user.email ?? '',
          );
          
          _waterReminder = data['water_reminder'] ?? true;
          _workoutReminder = data['workout_reminder'] ?? false;
          _healthReminder = data['health_reminder'] ?? true;
        });
      }
    }
  }

  void _openLogin() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
    _loadUserProfile();
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
            onPressed: () async {
              // Bắt Navigator của hộp thoại TRƯỚC KHI await
              final navigator = Navigator.of(ctx);
              navigator.pop();
              
              await AuthService().signOut();
              
              if (mounted) {
                setState(() {
                  _profile = null;
                });
              }
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

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Row(
          children: [
            Icon(Icons.monitor_heart, color: kGreen, size: 28),
            SizedBox(width: 10),
            Text('HealthSync', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text(
          'Phiên bản 1.0.0\n\nHealthSync là ứng dụng theo dõi sức khỏe và thể chất toàn diện, giúp bạn quản lý chỉ số cơ thể, dinh dưỡng và tập luyện mỗi ngày.\n\nPhát triển bởi:\n- Gia Minh\n- Trọng Minh\n- Thành Đạt',
          style: TextStyle(height: 1.5, fontSize: 14, color: kText),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Đóng', style: TextStyle(color: kGreen, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
    );
  }

  void _showRemindersSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => StatefulBuilder(
        builder: (BuildContext ctx, StateSetter setSheetState) => Container(
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Cài đặt nhắc nhở', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kText)),
              const SizedBox(height: 16),
              SwitchListTile(
                secondary: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.blue.withValues(alpha: 0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.water_drop, color: Colors.blue),
                ),
                title: const Text('Nhắc uống nước', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('Mỗi 2 tiếng'),
                value: _waterReminder,
                activeColor: Colors.blue,
                onChanged: (val) {
                  setSheetState(() => _waterReminder = val);
                  setState(() => _waterReminder = val);
                },
              ),
              SwitchListTile(
                secondary: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.orange.withValues(alpha: 0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.fitness_center, color: Colors.orange),
                ),
                title: const Text('Nhắc tập thể dục', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('17:00 hàng ngày'),
                value: _workoutReminder,
                activeColor: Colors.orange,
                onChanged: (val) {
                  setSheetState(() => _workoutReminder = val);
                  setState(() => _workoutReminder = val);
                },
              ),
              SwitchListTile(
                secondary: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.monitor_heart, color: Colors.red),
                ),
                title: const Text('Nhắc đo huyết áp', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('08:00 sáng hàng ngày'),
                value: _healthReminder,
                activeColor: Colors.red,
                onChanged: (val) {
                  setSheetState(() => _healthReminder = val);
                  setState(() => _healthReminder = val);
                },
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      // BẮT SỐNG NAVIGATOR & MESSENGER TRƯỚC KHI AWAIT
                      final messenger = ScaffoldMessenger.of(context);
                      final navigator = Navigator.of(sheetContext);
                      
                      navigator.pop();
                      
                      await DatabaseService().saveUserProfile({
                        'water_reminder': _waterReminder,
                        'workout_reminder': _workoutReminder,
                        'health_reminder': _healthReminder,
                      });
                      
                      if (mounted) {
                        messenger.showSnackBar(
                          const SnackBar(
                            content: Text('Đã lưu cài đặt nhắc nhở!'),
                            backgroundColor: kGreen,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kGreen,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Lưu cài đặt', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
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
              _profile == null
                  ? _GuestCard(onLogin: _openLogin)
                  : _ProfileCard(profile: _profile!, onLogout: _logout),

              const SizedBox(height: 28),

              const _SectionHeader('Thông báo'),
              const SizedBox(height: 10),
              _SettingsCard(
                items: [
                  _SettingItem(
                    icon: Icons.alarm_outlined, 
                    label: 'Cài đặt nhắc nhở',
                    onTap: () => _showRemindersSheet(context),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              const _SectionHeader('Về dịch vụ của chúng tôi'),
              const SizedBox(height: 10),
              _SettingsCard(
                items: [
                  _SettingItem(
                    icon: Icons.info_outline, 
                    label: 'Về HealthSync',
                    versionTag: 'v1.0.0', 
                    onTap: () => _showAboutDialog(context),
                  )
                ],
              ),

              const SizedBox(height: 22),

              const _SectionHeader('Bộ sưu tập'),
              const SizedBox(height: 10),
              _SettingsCard(
                items: [
                  _SettingItem(
                    icon: Icons.menu_book_outlined,
                    label: 'Túi công thức',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FavoriteRecipesPage(),
                      ),
                    ),
                  ),
                  _SettingItem(
                    icon: Icons.fitness_center,
                    label: 'Bài tập yêu thích',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FavoriteWorkoutsPage(),
                      ),
                    ),
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
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
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
                    color: kGreen.withValues(alpha: 0.35),
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
            color: kGreen.withValues(alpha: 0.35),
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
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.6),
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
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.2)),
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
                color: Colors.white.withValues(alpha: 0.2),
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

class _UserProfile {
  final String name, email;
  const _UserProfile({required this.name, required this.email});
}

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
  final VoidCallback? onTap;

  const _SettingItem({
    required this.icon,
    required this.label,
    this.versionTag,
    this.onTap,
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
            color: Colors.black.withValues(alpha: 0.04),
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
                onTap: item.onTap,
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