import 'package:flutter/material.dart';

class HomeBody2 extends StatelessWidget {
  const HomeBody2({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // APP ICON
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.green,
            child: Icon(Icons.health_and_safety,
                size: 50, color: Colors.white),
          ),

          const SizedBox(height: 16),

          // APP NAME
          const Text(
            "Sync Health",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          // SHORT DESCRIPTION
          const Text(
            "Track your health. Improve your life.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),

          // FEATURE LIST (EXPANDABLE)
          _buildItem(
            Icons.favorite,
            "Heart Rate Monitoring",
            "Track your heart rate in real-time to understand your cardiovascular health. "
                "Receive alerts when your heart rate is too high or too low.",
          ),

          _buildItem(
            Icons.directions_walk,
            "Daily Step Tracking",
            "Monitor your daily steps to stay active. Set goals and track your progress "
                "towards a healthier lifestyle.",
          ),

          _buildItem(
            Icons.bed,
            "Sleep Analysis",
            "Analyze your sleep patterns including deep sleep, light sleep, and awake time "
                "to improve your sleep quality.",
          ),

          _buildItem(
            Icons.local_fire_department,
            "Calories Tracking",
            "Track calories burned throughout the day based on your activities and "
                "exercise routines.",
          ),

          _buildItem(
            Icons.water_drop,
            "Blood Oxygen Monitoring",
            "Measure your blood oxygen (SpO2) levels to ensure your body is getting enough oxygen.",
          ),

          const SizedBox(height: 24),

          // ABOUT TEXT
          const Text(
            "Sync Health is a smart health tracking application designed to help you "
            "monitor your daily activities and vital health metrics. By syncing data "
            "from your devices, the app provides insights to improve your lifestyle "
            "and overall well-being.",
            style: TextStyle(fontSize: 14, height: 1.6),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // EXPANDABLE ITEM
  Widget _buildItem(
    IconData icon,
    String title,
    String description,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.green[700]),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              description,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}