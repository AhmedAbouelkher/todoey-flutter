import 'package:flutter/material.dart';
import 'package:todoey_flutter/moor_database.dart';
import 'package:todoey_flutter/screens/tasks_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      builder: (_) => AppDatabase().taskDao,
      child: MaterialApp(
        home: TasksScreen(),
      ),
    );
  }
}
