import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/todo_data_class.dart';
import '../../data/repos/todo_repo.dart';

class TodoCubit extends Cubit<List<TodoDataClass>> {
  //ref of todo repo
  final TodoRepo todoRepo;
  // constructor intializes the cubit with an empty list
  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  //load
  Future<void> loadTodos() async {
    //fetch list of todos from repo
    final todoList = await todoRepo.getTodos();

    //emit the fetched list as a the new state
    emit(todoList);
  }

  //add
  Future<void> addTodo(String text) async {
    //create new todo with unique id
    final newTodo = TodoDataClass(
      id: DateTime.now().millisecondsSinceEpoch,
      text: text,
    );
    //save the new todo to repo
    await todoRepo.addTodo(newTodo);
    //re-load
    loadTodos();
  }

  //delete
  Future<void> deleteTodo(TodoDataClass todo) async {
    //delete the specificed todofrom repo
    await todoRepo.deleteTodo(todo);
    //re-load
    loadTodos();
  }

  //toggle
  Future<void> toggleCompletion(TodoDataClass todo) async {
    //toggle the comp sttus of the todo
    final updateedTodo = todo.toggleCompletion();
    //update the todo in repo
    await todoRepo.updateTodo(todo);
    //re-load
    loadTodos();
  }
}
