import 'package:flutter/material.dart';

class HomeBody2 extends StatelessWidget {
  const HomeBody2({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40),

          // HERO TEXT (giống web)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  height: 1.4,
                ),
                children: [
                  TextSpan(text: "We "),
                  TextSpan(
                    text: "track, analyze,",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  TextSpan(
                    text:
                        " and improve your health\nthrough smart monitoring.",
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // BUTTON
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () {},
            child: const Text("Start Tracking"),
          ),

          const SizedBox(height: 40),

          // IMAGE SECTION (2 ảnh ngang)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: _buildImage(
                    "https://images.unsplash.com/photo-1576091160550-2173dba999ef",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildImage(
                    "https://images.unsplash.com/photo-1510017803434-a899398421b3",
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // TEXT CONTENT (giống WHAT WE BELIEVE)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "WHAT WE TRACK",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "We believe in better health through data. We track metrics like:\n\n"
                  "Heart Rate. Steps. Sleep. Calories. Blood Oxygen. "
                  "Activity Levels. Hydration.\n\n"
                  "Why does it matter?\n\n"
                  "Tracking your health helps you understand your body better. "
                  "With real-time insights, you can improve your habits, stay active, "
                  "and maintain a healthier lifestyle.",
                  style: TextStyle(fontSize: 14, height: 1.6),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}