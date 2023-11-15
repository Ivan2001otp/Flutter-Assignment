class Todo {
  String? id;
  String? task;
  bool? isDone;

  Todo({required this.id, required this.task, this.isDone = false});

  static List<Todo> todoListRepo() {
    return [
      Todo(id: '01', task: "Gymming", isDone: true),
      Todo(id: '02', task: "Gaming tournament"),
      Todo(id: '03', task: "Coding"),
      Todo(id: '04', task: "Sleeping", isDone: true),
      Todo(id: '05', task: "Chatting", isDone: true),
      Todo(id: '06', task: "Carroming"),
    ];
  }
}
