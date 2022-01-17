import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_sqflite/models/todo_model.dart';

const String databaseName = 'todo3.db';
const String tableTodo = 'todo';
const String columnId = 'id';
const String columnTitle = 'title';
const String columnDescription = 'description';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  DatabaseHelper._init();
}

class TodoProvider {
  late Database db;

  static final TodoProvider _instance = TodoProvider._internal();
  factory TodoProvider() => _instance;
  TodoProvider._internal() {
    open();
    DatabaseHelper.instance;
  }

  Future open() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableTodo ( 
  $columnId integer primary key autoincrement, 
  $columnTitle text not null,
  $columnDescription text not null)
''');
    });
  }

  Future<bool> insert(
      {required String title, required String description}) async {
    log({
      "description": description,
      "title": title,
    }.toString());
    int id = await db.insert(
      tableTodo,
      {
        "description": description,
        "title": title,
      },
    );
    return id != 0;
  }

  Future<List<Todo>> getTodos() async {
    List<Map> maps = await db.query(tableTodo);
    // columns: [columnId, columnDescription, columnTitle],
    // where: '$columnId = ?',
    // whereArgs: [id]);
    if (maps.isNotEmpty) {
      return maps.map<Todo>((e) => Todo.fromJson(e)).toList();
    }
    return [];
  }

  Future<Todo?> getTodo(int id) async {
    List<Map> maps = await db.query(tableTodo,
        columns: [columnId, columnDescription, columnTitle],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Todo.fromJson(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Todo todo) async {
    return await db.update(tableTodo, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

  Future close() async => db.close();
}

class To {
  static final To _instance = To._internal();

  factory To() => _instance;

  To._internal();

  String? d;
}
