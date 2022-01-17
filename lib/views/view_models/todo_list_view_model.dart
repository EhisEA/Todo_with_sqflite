import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_sqflite/database/database.dart';
import 'package:todo_sqflite/database/sql_service.dart';
import 'package:todo_sqflite/models/todo_model.dart';

class TodoListViewModel extends BaseViewModel {
  TodoProvider todoDBHelper = TodoProvider();
  List<Todo> todos = [];
  SqlService sqlService = SqlService();
  TodoListViewModel() {
    sqlService.init();
  }
  @override
  dispose() {
    sqlService.close();
    super.dispose();
  }

  getTodos() async {
    setBusy(true);
    await Future.delayed(const Duration(seconds: 5));
    todos = await todoDBHelper.getTodos();
    setBusy(false);
  }
}
