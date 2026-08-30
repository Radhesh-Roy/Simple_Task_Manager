import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> tasks = [];

  void addTask(String title) {
    if (title.trim().isEmpty) {
      return;
    }

    tasks.add({
      "title": title.trim(),
      "isCompleted": false,
    });

    notifyListeners();
  }

  void deleteTask(int index) {
    tasks.removeAt(index);

    notifyListeners();
  }

  void toggleTask(int index) {
    tasks[index]["isCompleted"] =
    !tasks[index]["isCompleted"];

    notifyListeners();
  }
}