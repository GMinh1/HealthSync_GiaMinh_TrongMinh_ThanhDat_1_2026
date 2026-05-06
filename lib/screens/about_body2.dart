import 'package:flutter/material.dart';

class AboutBody2 extends StatelessWidget {
  const AboutBody2({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 50),

          // 🔹 HERO TEXT
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "We help you track, improve, and balance your health every day.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
            ),
          ),

          const SizedBox(height: 30),

          // 🔹 BUTTON
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              DefaultTabController.of(context)?.animateTo(1);
            },
            child: const Text(
              "View Health Stats",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),

          const SizedBox(height: 60),

          // 🔹 IMAGE SECTION
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LEFT IMAGE — tall card
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 420, // tăng chiều cao
                    decoration: BoxDecoration(
                      color: Colors
                          .grey
                          .shade50, // nền nhạt khi ảnh không fill hết
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.withOpacity(0.15),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        "assets/images/about_img2.png",
                        fit: BoxFit.contain, // ← đổi từ cover sang contain
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // RIGHT COLUMN — small image + text card
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top image with frame
                      Container(
                        height: 190,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.teal.withOpacity(0.18),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(19),
                          child: Image.asset(
                            "assets/images/about_img1.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Text card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.teal.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.teal.withOpacity(0.12),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 28,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "HealthSync helps you maintain a balanced lifestyle through smart tracking and insights.",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 13.5,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 60),

          // 🔹 TEXT CONTENT
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              children: [
                Text(
                  "WHAT WE BELIEVE",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "We believe in better health through technology. From tracking daily habits to analyzing long-term health trends, HealthSync empowers users to take control of their well-being.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
