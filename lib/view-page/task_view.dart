import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../task_provider/task_provider.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final TextEditingController taskController = TextEditingController();

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(title: Text("Task Manager")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      hintText: "Enter task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                SizedBox(width: 10),

                ElevatedButton(
                  onPressed: () {
                    context.read<TaskProvider>().addTask(taskController.text);
                    taskController.clear();
                  },

                  child: Text("Add Task"),
                ),
              ],
            ),

            SizedBox(height: 20),
            Expanded(
              child: taskProvider.tasks.isEmpty ? Center(
                      child: Text(
                        "No Tasks Available",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: taskProvider.tasks.length,
                      itemBuilder: (context, index) {
                        final task = taskProvider.tasks[index];
                        return Card(
                          child: ListTile(
                            leading: Checkbox(
                              value: task["isCompleted"],
                              onChanged: (value) {
                                context.read<TaskProvider>().toggleTask(index);
                              },
                            ),
                            title: Text(
                              task["title"],
                              style: TextStyle(
                                fontSize: 16,
                                decoration: task["isCompleted"]
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                context.read<TaskProvider>().deleteTask(index);
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
