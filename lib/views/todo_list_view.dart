import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_sqflite/models/todo_model.dart';
import 'package:todo_sqflite/views/view_models/todo_list_view_model.dart';

import 'create_todo.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (constext) => const CreateTodo(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: ViewModelBuilder<TodoListViewModel>.reactive(
        viewModelBuilder: () => TodoListViewModel(),
        onModelReady: (model) => model.getTodos(),
        builder: (context, model, _) {
          if (model.isBusy) {
            return const Center(child: CircularProgressIndicator());
          }
          return StreamBuilder<List<Todo>>(
            stream: model.sqlService.watchTodo(),
            builder: (context, snapshot) {
              List<Todo> todos = snapshot.data ?? [];
              return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(todos[index].id.toString()),
                    ),
                    title: Text(
                      todos[index].title,
                      style: const TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      todos[index].description,
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
