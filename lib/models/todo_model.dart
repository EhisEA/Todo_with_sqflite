///this is to create consistnecy for the field
///names used across the app
///e.g for sql table and map creation
class TodoField {
  static const id = "id";
  static const title = "title";
  static const description = "description";
}

class Todo {
  int id;
  String title;
  String description;
  // Category category;

  Todo({
    required this.id,
    required this.description,
    required this.title,
  });

  factory Todo.fromJson(Map json) => Todo(
        id: json[TodoField.id],
        title: json[TodoField.title],
        description: json[TodoField.description],
      );
  toMap() => {
        TodoField.id: id,
        TodoField.title: title,
        TodoField.description: description,
      };
}
