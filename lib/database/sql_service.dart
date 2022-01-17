import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_sqflite/database/database.dart';
import 'package:todo_sqflite/database/repo.dart';
import 'package:todo_sqflite/models/todo_model.dart';

class SqlService extends Repository {
  final db = DatabaseHelper.instance;
  @override
  Future init() async {
    await db.database;
  }

  @override
  Future<int> deleteTodo(Todo todo) async {
    return await db.deleteTodo(todo);
  }

  @override
  Future<List<Todo>> getAllTodo() async {
    return await db.getAllTodo();
  }

  @override
  Future<int> insertTodo(
      {required String title, required String description}) async {
    return await db.insertTodo(title: title, description: description);
  }

  @override
  Stream<List<Todo>> watchTodo() {
    return db.watchTodo();
  }

  @override
  Future close() async {
    db.close();
  }
}
