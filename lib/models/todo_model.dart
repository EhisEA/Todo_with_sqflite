class Todo {
  int id;
  String title;
  String description;
  // Category category;

  Todo({
    required this.id,
    // required this.category,
    required this.description,
    required this.title,
  });

  factory Todo.fromJson(Map json) => Todo(
        id: json["id"],
        title: json["title"],
        description: json["description"],
      );
  toMap() => {
        "id": id,
        "title": title,
        "description": description,
      };
}
