import 'package:todo_sqflite/models/todo_model.dart';

abstract class Repository {
  Future init();

  Future close();

  Future<List<Todo>> getAllTodo();

  Future<int> deleteTodo(Todo todo);

  Future<int> insertTodo({required String title, required String description});

  Stream<List<Todo>> watchTodo();
}
