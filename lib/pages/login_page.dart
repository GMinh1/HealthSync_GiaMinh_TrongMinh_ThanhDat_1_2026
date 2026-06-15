import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../core/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.monitor_heart, size: 80, color: kGreen),
              const SizedBox(height: 20),
              const Text("HealthSync", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              
              ElevatedButton.icon(
                onPressed: _loading ? null : () async {
                  setState(() => _loading = true);
                  final user = await AuthService().signInWithGoogle();
                  setState(() => _loading = false);
                  
                  if (user != null && mounted) {
                    Navigator.pop(context); 
                  }
                },
                icon: _loading 
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.g_mobiledata),
                label: const Text("Đăng nhập với Google"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}