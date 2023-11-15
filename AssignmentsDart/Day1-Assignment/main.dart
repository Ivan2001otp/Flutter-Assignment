//todo app
/*
 * Entity-todo:
 *  task-name,task-id,Priority which is represented using enum.
 * 
 * insert todo task
 * update task
 * delete task
 * 
 * */
import 'dart:math';
import 'dart:io';

class TodoItem {
  String? todoName;
  String? todoId;
  String? todoPriority;

  factory TodoItem(String t_name, String t_priority, String t_id) {
    return TodoItem._private(t_name, t_priority, t_id);
  }

  void setTodoName(String? name) {
    if (name != null) {
      throw ArgumentError('Name is null');
    }

    this.todoName = name;
  }

  String get _todoName => this.todoName!;

  void setTodoPriority(String? priority) {
    if (priority != null) {
      throw ArgumentError('priority is null');
    }

    this.todoPriority = priority;
  }

  String get _todoPriority => this.todoPriority!;

  TodoItem._private(this.todoName, this.todoPriority, this.todoId);

  void _toString() {
    print('${todoId} - ${todoName} - ${todoPriority}\n');
  }
}

List<TodoItem> tempDB = List.empty(growable: true);

int getRandomGenerator() {
  return Random().nextInt(10000);
}

int getTodo(String id) {
  for (int i = 0; i < tempDB.length; i++) {
    if (id == tempDB[i].todoId) {
      return i;
    }
  }

  return -1;
}

void main() {
  // var item1 = TodoItem('Gymming', 'HIGH', '1');

  String ch = 'y';

  do {
    print(
        '1.Add task\n2.Update task\n3.Delete Task\n4.Show all tasks \n5.Exit\n');
    int? choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        print('task name : ');
        var task_name = stdin.readLineSync() ?? 'task_name??';
        print('task-priority : ');
        var task_priority = stdin.readLineSync() ?? 'task_priority??';
        tempDB.add(TodoItem(task_name!, task_priority!,
            (getRandomGenerator() % 100 + 1).toString()));
        print('task added!');
        break;

      case 2:
        print('enter the task id you want to update!');
        String id = stdin.readLineSync()!;

        int todoItemInstanceIndex = getTodo(id);
        if (todoItemInstanceIndex != -1) {
          tempDB.removeAt(todoItemInstanceIndex);
        }

        print('enter the task name & priority');
        var task_name = stdin.readLineSync()! ?? 'task_name??';
        var task_priority = stdin.readLineSync()! ?? 'task_priority??';
        tempDB.add(TodoItem(task_name!, task_priority!,
            (getRandomGenerator() % 100 + 1).toString()));

        break;

      case 3:
        print('enter the task Id that want to be deleted!');
        String id = stdin.readLineSync()!;

        int todoItemInstanceIndex = getTodo(id);
        if (todoItemInstanceIndex != -1) {
          tempDB.removeAt(todoItemInstanceIndex);
        }
        print('item Deleted successfully!');
        break;

      case 4:
        if (tempDB.isEmpty) {
          print('no todos in list.');
        } else {
          for (int i = 0; i < tempDB.length; i++) {
            tempDB[i]._toString();
          }
        }

        break;

      case 5:
        ch = 'n';
        break;
    }
  } while (ch == 'y');

  // item1._toString();
}
