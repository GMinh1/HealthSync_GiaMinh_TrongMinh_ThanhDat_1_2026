import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/app_theme.dart';
import 'pages/care_page.dart';
import 'pages/sound_page.dart';
import 'pages/recipe_page.dart';
import 'pages/user_page.dart';
import 'pages/add_menu_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  runApp(const HealthSyncApp());
}

class HealthSyncApp extends StatelessWidget {
  const HealthSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: kGreen), useMaterial3: true),
      home: const MainScreen(), // Trỏ thẳng vào app chính
    );
  }
}

// MainScreen giữ nguyên như code trước bạn đã có...

// ─────────────────────────── Main Screen ────────────────────────────────
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;

  final List<Widget> _pages = const [
    CarePage(key: ValueKey('care')),
    SoundPage(key: ValueKey('sound')),
    RecipePage(key: ValueKey('recipe')),
    UserPage(key: ValueKey('user')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgBottom,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child: _pages[_index],
      ),
      bottomNavigationBar: _BottomNav(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        onFabTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddMenuPage(),
              fullscreenDialog: true,
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────── Bottom Nav ─────────────────────────────────
class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onFabTap;

  const _BottomNav({
    required this.currentIndex,
    required this.onTap,
    required this.onFabTap,
  });

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return Container(
      margin: EdgeInsets.fromLTRB(14, 0, 14, bottom + 12),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavBtn(index: 0, current: currentIndex, onTap: onTap, icon: Icons.monitor_heart_outlined, activeIcon: Icons.monitor_heart, label: 'Care'),
          _NavBtn(index: 1, current: currentIndex, onTap: onTap, icon: Icons.headphones_outlined, activeIcon: Icons.headphones, label: 'Sound'),
          
          GestureDetector(
            onTap: onFabTap,
            child: Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: kGreen,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2DCB73).withValues(alpha: 0.33),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 30),
            ),
          ),
          
          _NavBtn(index: 2, current: currentIndex, onTap: onTap, icon: Icons.restaurant_menu_outlined, activeIcon: Icons.restaurant_menu, label: 'Recipe'),
          _NavBtn(index: 3, current: currentIndex, onTap: onTap, icon: Icons.person_outline, activeIcon: Icons.person, label: 'Mine'),
        ],
      ),
    );
  }
}

class _NavBtn extends StatelessWidget {
  final int index, current;
  final ValueChanged<int> onTap;
  final IconData icon, activeIcon;
  final String label;

  const _NavBtn({
    required this.index, required this.current, required this.onTap,
    required this.icon, required this.activeIcon, required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final sel = index == current;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(sel ? activeIcon : icon, color: sel ? kGreen : const Color(0xFFB5BEC6), size: 24),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(fontSize: 11, color: sel ? kGreen : const Color(0xFFB5BEC6), fontWeight: sel ? FontWeight.w700 : FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}