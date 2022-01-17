import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_sqflite/views/view_models/create_view_model.dart';

class CreateTodo extends StatelessWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateViewModel>.reactive(
      viewModelBuilder: () => CreateViewModel(),
      builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Create Todo"),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    decoration: const InputDecoration(hintText: "Title"),
                    controller: model.title,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    decoration: const InputDecoration(hintText: "Description"),
                    maxLines: null,
                    controller: model.description,
                  ),
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
          ),
        );
      },
    );
  }
}
