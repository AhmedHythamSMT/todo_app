import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/features/todo/data/models/isar_todo.dart';
import 'package:todo_app/features/todo/data/repos/isar_todo_repo.dart';
import 'package:todo_app/features/todo/data/repos/todo_repo.dart';
import 'package:todo_app/features/todo/ui/screens/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // get directory for storing data
  final dir = await getApplicationDocumentsDirectory();

  //open isar db
  final isar = await Isar.open([IsarTodoSchema], directory: dir.path);

  // intialize todo repo with isar db
  final isarTodoRepo = IsarTodoRepo(isar);

  //run app
  runApp(MainApp(todoRepo: isarTodoRepo));
}

class MainApp extends StatelessWidget {
  //db injection through the app
  final TodoRepo todoRepo;

  const MainApp({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(todoRepo: todoRepo),
    );
  }
}
