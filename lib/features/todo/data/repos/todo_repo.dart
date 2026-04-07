import '../models/todo_data_class.dart';

abstract class TodoRepo {
  //get todo list
  Future<List<TodoDataClass>> getTodos();
  //add todo
  Future<void> addTodo(TodoDataClass newTodo);
  //update todo
  Future<void> updateTodo(TodoDataClass todo);
  //delete todo
  Future<void> deleteTodo(TodoDataClass todo);
}
