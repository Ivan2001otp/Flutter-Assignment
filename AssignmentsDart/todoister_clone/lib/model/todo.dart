import 'package:uuid/uuid.dart';

class Todo {
  int? _todoId;
  String _todoTitle = '';
  String _todoDeadline = '';
  String _todoPriority = '';

  Todo(this._todoTitle, this._todoDeadline, this._todoPriority);

  Todo.withId(
      this._todoId, this._todoTitle, this._todoDeadline, this._todoPriority);

  String get todoDeadline => this._todoDeadline;
  String get todoTitle => this._todoTitle;
  String get todoPriority => this._todoPriority;
  int get todoID => this._todoId!;

  set titleSetter(String newTitle) {
    if (newTitle.length <= 255) this._todoTitle = newTitle;
  }

  set DateTime(String newDateTime) {
    if (newDateTime.isNotEmpty && newDateTime != null) {
      this._todoDeadline = newDateTime;
    }
  }

  set prioritySetter(String newPriority) {
    this._todoPriority = newPriority;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_todoId != null) {
      map['_todoId'] = this._todoId;
    }
    map['_todoTitle'] = this._todoTitle;
    map['_todoDeadline'] = this._todoDeadline;
    map['_todoPriority'] = this._todoPriority;

    return map;
  }

  Todo.fromMapObject(Map<String, dynamic> map) {
    this._todoId = map['_todoId'];
    this._todoTitle = map['_todoTitle'];
    this._todoPriority = map['_todoPriority'];
    this._todoDeadline = map['_todoDeadline'];
  }
}
