import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_sqflite/database/database.dart';
import 'package:todo_sqflite/models/todo_model.dart';

class TodoListViewModel extends BaseViewModel {
  TodoProvider todoDBHelper = TodoProvider();
  List<Todo> todos = [];
  getTodos() async {
    setBusy(true);
    await Future.delayed(const Duration(seconds: 5));
    todos = await todoDBHelper.getTodos();
    setBusy(false);
  }
}

class AddTodoViewModel extends BaseViewModel {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();

  TodoProvider todoDBHelper = TodoProvider();
  List<Todo> todos = [];
  addTodo() async {
    setBusy(true);
    bool success = await todoDBHelper.insert(
        title: title.text, description: description.text);
    setBusy(false);
    return success;
  }
}
