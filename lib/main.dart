import 'package:flutter/material.dart';

import 'widgets/screen_layout.dart';
import 'screens/home_body.dart';
import 'screens/content_body.dart';
import 'screens/about_body.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Tracker',
      theme: ThemeData(
        primarySwatch: Colors.teal, // Đổi sang màu xanh ngọc (phổ biến trong app y tế)
        useMaterial3: true,
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ScreenLayout(bodyContent: HomeBody()),
    const ScreenLayout(bodyContent: ContentBody()),
    const ScreenLayout(bodyContent: AboutBody()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HealthSync', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.teal,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite), // Icon trái tim
            label: 'Tổng quan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart), // Icon nhịp tim
            label: 'Chỉ số',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety), // Icon hồ sơ y tế
            label: 'Hồ sơ',
          ),
        ],
      ),
    );
  }
}