import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_sqflite/views/todo_list_view_model.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (constext) => const Er()));
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
          return ListView.builder(
            itemCount: model.todos.length,
            itemBuilder: (context, index) {
              log(model.todos[index].toMap().toString());
              return ListTile(
                leading: CircleAvatar(
                  child: Text(model.todos[index].id.toString()),
                ),
                title: Text(
                  model.todos[index].title,
                  style: const TextStyle(color: Colors.black),
                ),
                subtitle: Text(
                  model.todos[index].description,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Er extends StatelessWidget {
  const Er({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddTodoViewModel>.reactive(
        viewModelBuilder: () => AddTodoViewModel(),
        builder: (context, model, _) {
          return Scaffold(
              body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: model.title,
                ),
                TextField(
                  controller: model.description,
                ),
                ElevatedButton(
                  onPressed: () async {
                    bool result = await model.addTodo();
                    if (result) Navigator.of(context).pop();
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          ));
        });
  }
}
