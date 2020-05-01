import 'package:flutter/material.dart';
import 'package:todoey_flutter/widgets/task_tile.dart';
import 'package:provider/provider.dart';

import '../moor_database.dart';

class TasksList extends StatelessWidget {
  TasksList({this.isCompletedTasks = false});
  final bool isCompletedTasks;
  @override
  Widget build(BuildContext context) {
    return _buildTaskList(context);
  }

  StreamBuilder<List<Task>> _buildTaskList(BuildContext context) {
    final database = Provider.of<TaskDao>(context);
    return StreamBuilder(
      stream: isCompletedTasks
          ? database.watchCompletedTasks()
          : database.watchAllTasks(),
      builder: (context, snapshot) {
        final tasks = snapshot.data ?? List();
        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final itemTask = tasks[index];
            return TaskTile(
              taskTitle: itemTask.name,
              isChecked: itemTask.completed,
              checkboxCallback: (checkboxState) => database
                  .updateTask(itemTask.copyWith(completed: checkboxState)),
              longPressCallback: () => database.deleteTask(itemTask),
            );
          },
        );
      },
    );
  }
}
