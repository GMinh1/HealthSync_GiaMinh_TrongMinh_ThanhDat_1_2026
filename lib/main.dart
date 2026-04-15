import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class User {
  String name;
  int age;
  double height;
  double weight;

  User({
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
  });
}

class HealthData {
  String date;
  double weight;
  int steps;
  double calories;

  HealthData({
    required this.date,
    required this.weight,
    required this.steps,
    required this.calories,
  });
}

class Goal {
  double targetWeight;
  int targetSteps;

  Goal({required this.targetWeight, required this.targetSteps});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HealthSync',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User user = User(name: 'Minh', age: 21, height: 1.7, weight: 65);

  final Goal goal = Goal(targetWeight: 60, targetSteps: 8000);

  final List<HealthData> healthList = [
    HealthData(date: '10/4', weight: 65, steps: 5000, calories: 200),
    HealthData(date: '11/4', weight: 64.5, steps: 7000, calories: 250),
    HealthData(date: '12/4', weight: 64, steps: 8000, calories: 300),
  ];

  final Map<String, double> bmiData = {
    '10/4': 22.5,
    '11/4': 22.3,
    '12/4': 22.0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HealthSync')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User Info', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('User: ${user.name}'),
            Text('Age: ${user.age}'),
            Text('Height: ${user.height} m'),
            Text('Weight: ${user.weight} kg'),
            const SizedBox(height: 20),
            Text('Goals', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Target Weight: ${goal.targetWeight} kg'),
            Text('Target Steps: ${goal.targetSteps}'),
            const SizedBox(height: 20),
            Text('Health Data', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            ...healthList.map(
              (data) => Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date: ${data.date}'),
                      Text('Weight: ${data.weight} kg'),
                      Text('Steps: ${data.steps} steps'),
                      Text('Calories: ${data.calories} kcal'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('BMI Data', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            ...bmiData.entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text('${entry.key}: ${entry.value}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
