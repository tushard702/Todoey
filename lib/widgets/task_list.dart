import 'package:flutter/material.dart';
import 'task_tile.dart';
import 'package:todoeyflutter/model/task.dart';
import 'package:provider/provider.dart';
import 'package:todoeyflutter/model/task_data.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (BuildContext context, TaskData taskData, Widget child) {
        return ListView.builder(
            itemBuilder: (context, itemIndex) {
              final task = taskData.tasks[itemIndex];
              return GestureDetector(
                onLongPress: () {
                  taskData.removeTask(itemIndex);
                },
                child: TaskTile(
                  taskName: task.name,
                  isChecked: task.isDone,
                  checkBoxCallback: (checkBoxState) {
                    taskData.updateTask(task);
                  },
                ),
              );
            },
            itemCount: taskData.taskCount);
      },
    );
  }
}
