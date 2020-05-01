import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/moor_database.dart';
import 'package:todoey_flutter/widgets/tasks_list.dart';
import 'package:todoey_flutter/screens/add_task_screen.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool isCompletedSelected = false;

  StreamBuilder<List<Task>> _taskNumber(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<TaskDao>(context).watchAllTasks(),
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
        final tasks = snapshot.data ?? List();
        return Text(
          tasks.length.toString() + " Tasks",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent,
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: AddTaskScreen())));
          }),
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      child: Icon(
                        Icons.list,
                        size: 30.0,
                        color: Colors.lightBlueAccent,
                      ),
                      backgroundColor: Colors.white,
                      radius: 30.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Todoey',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _taskNumber(context)
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: TasksList(isCompletedTasks: isCompletedSelected),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Row(
              children: <Widget>[
                Text("Show Completed Tasks"),
                Switch(
                    value: isCompletedSelected,
                    onChanged: (newValue) {
                      setState(() {
                        isCompletedSelected = newValue;
                      });
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
