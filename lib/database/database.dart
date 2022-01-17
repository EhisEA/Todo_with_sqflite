import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:todo_sqflite/models/todo_model.dart';

const String databaseName = 'todo3.db';
const String tableTodo = 'todo';
const String columnId = 'id';
const String columnTitle = 'title';
const String columnDescription = 'description';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  DatabaseHelper._init();

  // Constants for the database name and version.
  static const _databaseName = 'Todo6.db';
  static const _databaseVersion = 1;
  // Table name
  static const todoTable = 'Todo';

  static BriteDatabase? _streamDatabase;
  static Database? _database;

// TODO: Add create database code here

// create table
  Future _onCreate(Database db, int version) async {
    // create todo table in the database
    await db.execute('''
      Create Table $todoTable(
        ${TodoField.id} Integer Primary Key autoincrement,
        ${TodoField.title} Text not null,
        ${TodoField.description} Text not null

      )
      ''');
  }

// open

  Future<Database> _initDatabase() async {
    // get database directory
    final documentDirectory = await getDatabasesPath();
    // get path to databas file
    final path = join(documentDirectory, _databaseName);

    // open database with path
    // set database version
    // set the onCreate function is called
    // when database is newly created
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // get database object/instance
  Future<Database> get database async {
    // retrun database if it already exist
    if (_database != null) return _database!;

    // initialise database
    // set _database and _streamDatabase with database value
    if (_database == null) {
      _database = await _initDatabase();
      _streamDatabase = BriteDatabase(_database!);
    }

    return _database!;
  }

  // get stream database object/instance
  Future<BriteDatabase> get streamDatabase async {
    // check and initialize database
    await database;
    // retrun _streamDatabase instance
    return _streamDatabase!;
  }

//insert

  Future<int> insert(String table, Map<String, dynamic> rowData) async {
    final db = await instance.streamDatabase;
    return db.insert(table, rowData);
  }

  Future<int> insertTodo(
      {required String title, required String description}) async {
    Map<String, dynamic> value = {
      TodoField.title: title,
      TodoField.description: description,
    };
    return insert(todoTable, value);
  }

// Fetch
  Stream<List<Todo>> watchTodo() async* {
    final db = await instance.streamDatabase;
    yield* db.createQuery(todoTable).mapToList((row) => Todo.fromJson(row));
  }

  Future<List<Todo>> getAllTodo() async {
    final db = await instance.database;
    List<Map<String, dynamic>> data = await db.query(todoTable);
    return data.map<Todo>((row) => Todo.fromJson(row)).toList();
  }

//Delete
  Future<int> delete(String table, int id) async {
    final db = await instance.streamDatabase;
    return db.delete(
      table,
      where: "${TodoField.id}=?",
      whereArgs: [id],
    );
  }

  Future<int> deleteTodo(Todo todo) {
    return delete(todoTable, todo.id);
  }

//close

  void close() async {
    await _streamDatabase?.close();
  }
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
