import 'package:flutter/material.dart';

class WorkoutStore extends ValueNotifier<Set<String>> {
  WorkoutStore._() : super({});

  static final WorkoutStore instance = WorkoutStore._();

  bool isSaved(String workoutName) => value.contains(workoutName);

  void toggle(String workoutName) {
    final next = Set<String>.from(value);
    if (next.contains(workoutName)) {
      next.remove(workoutName);
    } else {
      next.add(workoutName);
    }
    value = next;
  }
}
