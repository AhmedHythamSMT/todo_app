/* 

implement todo repo and handling storing, retrieving, updating,
and deleting todo items using Isar database.

*/

import 'package:isar/isar.dart';

import '../models/isar_todo.dart';
import '../models/todo_data_class.dart';
import 'todo_repo.dart';

class IsarTodoRepo implements TodoRepo {
  final Isar db;
  IsarTodoRepo(this.db);

  @override
  Future<List<TodoDataClass>> getTodos() async {
    //fetch from db
    final todos = await db.isarTodos.where().findAll();
    //return list for domain layer
    return todos.map((IsarTodo) => IsarTodo.toDomain()).toList();
  }

  @override
  Future<void> addTodo(TodoDataClass newTodo) async {
    // convert todo to isar todo
    final isarTodo = IsarTodo.fromDomain(newTodo);
    // to store data in isar db
    return await db.writeTxn(() => db.isarTodos.put(isarTodo));
  }

  @override
  Future<void> updateTodo(TodoDataClass todo) async {
    // convert todo to isar todo
    final isarTodo = IsarTodo.fromDomain(todo);
    // to store data in isar db
    return await db.writeTxn(() => db.isarTodos.put(isarTodo));
  }

  @override
  Future<void> deleteTodo(TodoDataClass todo) async {
    await db.writeTxn(() => db.isarTodos.delete(todo.id));
  }
}
