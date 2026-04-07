/*
TO DO View: responsible for building ui
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/data/models/todo_data_class.dart';
import 'package:todo_app/features/todo/ui/cubit/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  //show add dialog box for user
  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();

    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(controller: textController),
        actions: [
          //cancel button
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          //add button
          TextButton(
            onPressed: () {
              todoCubit.addTodo(textController.text);
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  //buildl ui
  @override
  Widget build(BuildContext context) {
    //cubit
    final todoCubit = context.read<TodoCubit>();

    // scaffold
    return Scaffold(
      //FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoBox(context),
        child: const Icon(Icons.add),
      ),

      //bloc builder
      body: BlocBuilder<TodoCubit, List<TodoDataClass>>(
        builder: (context, todos) {
          //list view of todos
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              // get individual todo from todos list
              final todo = todos[index];
              return ListTile(
                //text
                title: Text(todo.text),

                //check box
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (_) => todoCubit.toggleCompletion(todo),
                ),

                //delete button
                trailing: IconButton(
                  onPressed: () => todoCubit.deleteTodo(todo),
                  icon: const Icon(Icons.cancel),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
