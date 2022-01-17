import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_sqflite/database/sql_service.dart';
import 'package:todo_sqflite/models/todo_model.dart';

class CreateViewModel extends BaseViewModel {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  SqlService sqlService = SqlService();

  List<Todo> todos = [];
  addTodo() async {
    setBusy(true);
    int result = await sqlService.insertTodo(
        title: title.text, description: description.text);
    setBusy(false);
    return result != 0;
  }
}
