import 'package:isar/isar.dart';

import 'todo_data_class.dart';

// to generate isar todo obj, run by: dart run build_runner build
part 'isar_todo.g.dart';

@Collection()
class IsarTodo {
  Id id = Isar.autoIncrement;
  late String text;
  late bool isCompleted;

  // CONVERT ISAR OBJ TO PURE OBJJ TO USE IN UI
  TodoDataClass toDomain() {
    return TodoDataClass(id: id, text: text, isCompleted: isCompleted);
  }

  // CONVERT ISAR OBJ TO PURE OBJJ TO USE IN UI
  static IsarTodo fromDomain(TodoDataClass todo) {
    final isarTodo = IsarTodo()
      ..id = todo.id
      ..text = todo.text
      ..isCompleted = todo.isCompleted;
    return isarTodo;
  }
}
