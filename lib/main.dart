import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_task/task_provider/task_provider.dart';
import 'package:simple_task/view-page/task_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskProvider(),
        ),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Task Manager',

      home: TaskView(),
    );
  }
}