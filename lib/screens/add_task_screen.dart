import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:provider/provider.dart';
import '../moor_database.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String newTaskTitle;
    return Container(
      color: Color(0xff757575),
      child: Container(
        height: 200,
        width: double.infinity,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: ListView(
          children: <Widget>[
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.lightBlueAccent,
              ),
            ),
            TextField(
                autofocus: true,
                onChanged: (newText) {
                  newTaskTitle = newText;
                }),
            FlatButton(
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.lightBlueAccent,
              onPressed: () {
                final database = Provider.of<TaskDao>(context);
                final task = TasksCompanion(
                  name: Value(newTaskTitle),
                );
                database.insertTask(task);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
