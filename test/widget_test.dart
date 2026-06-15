import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Đảm bảo trỏ đúng tới file main.dart của bạn
import '../lib/main.dart';

void main() {
  testWidgets('App loads and renders main screen', (WidgetTester tester) async {
    // SỬA LỖI Ở ĐÂY: Đổi MyApp() thành HealthSyncApp() để khớp với class gốc trong main.dart
    await tester.pumpWidget(const MyApp());

    // Xác minh rằng app render thành công mà không bị crash
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}