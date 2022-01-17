import 'package:flutter/material.dart';
import 'package:todo_sqflite/database/sql_service.dart';
import 'package:todo_sqflite/views/todo_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoListView(),
    );
  }
}
