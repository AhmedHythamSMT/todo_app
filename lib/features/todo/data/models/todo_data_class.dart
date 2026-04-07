class TodoDataClass {
  final int id;
  final String text;
  final bool isCompleted;
  TodoDataClass({
    required this.id,
    required this.text,
    this.isCompleted = false,
  });

  TodoDataClass toggleCompletion() {
    return TodoDataClass(id: id, text: text, isCompleted: !isCompleted);
  }
}
