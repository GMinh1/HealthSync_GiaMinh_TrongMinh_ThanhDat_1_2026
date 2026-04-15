import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthSync',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // FIX lỗi ở đây
      ),
      home: const MyHomePage(title: 'HealthSync APP (app quan ly suc khoe)'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //  1. Biến (HealthSync)
  int age = 20;
  String name = "Tran Trong Minh";
  bool isMale = true;

  int heartRate = 72;
  double weight = 65.5;

  //  2. Collections
  final List<String> activities = ["Running", "Walking", "Sleeping"];
  final List<int> stepsList = [5000, 3000, 800];

  final Map<String, dynamic> healthData = {
    "Heart Rate": 72,
    "Weight": 65.5,
    "Steps": 5000,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
      Column(
        children: [
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.home),
            label: Text("Home"),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.favorite),
            label: Text("Health"),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.person),
            label: Text("Profile"),
          ),
        ],
      ),

      const SizedBox(height: 20),

            // Counter
          
            const SizedBox(height: 20),

            //  Hiển thị biến
            Text("Name: $name"),
            Text("Age: $age"),
            Text("Heart Rate: $heartRate"),

            const SizedBox(height: 20),

            //  Hiển thị List (Row + for)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Activities: "),
                for (var item in activities) Text("$item "),
              ],
            ),

            //  Hiển thị List (map)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Steps: "),
                ...stepsList.map((s) => Text("$s ")),
              ],
            ),

            const SizedBox(height: 20),

            //  Hiển thị Map
            Column(
              children: healthData.entries
                  .map((e) => Text("${e.key}: ${e.value}"))
                  .toList(),
            ),

            const SizedBox(height: 20),

            // Tên nhóm
          ],
        ),
      ),
    );
  }
}