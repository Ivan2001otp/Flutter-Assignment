import 'package:sqflite/sqflite.dart';

import '../model/todo.dart';
import 'dart:async';
import 'dart:io';
import '../Database/database_helper.dart';

class DatabaseRepository {
  final _tableName = 'todo_table';
  String colId = '_todoId';
  String colTitle = '_todoTitle';
  String colPriority = '_todoPriority';
  String colDeadline = '_todoDeadline';

  Future<int> insertTodo(Todo todo) async {
    final Database db = await DatabaseHelper().database;
    var result = db.insert(_tableName, todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future<List<Todo>> getAllTodoList() async {
    final Database db = await DatabaseHelper().database;

    if (!db.isOpen) {
      //open it
    }
    List<Map<String, dynamic>> resultMapDb =
        await db.rawQuery('SELECT * FROM $_tableName order by $colId DESC');

    return List.generate(
        resultMapDb.length, (index) => Todo.fromMapObject(resultMapDb[index]));
  }

  Future<void> closeDatabaseLayer() async {
    final Database _db = await DatabaseHelper().database;
    await _db.close();
  }

  Future<Map<String, dynamic>> _fetchTodoListById(int id) async {
    final Database _db = await DatabaseHelper().database;

    List<Map<String, dynamic>> todoItem =
        await _db.rawQuery('SELECT * FROM $_tableName WHERE $colId = $id');
    return todoItem.first;
  }

  Future<int> deleteTodoList(int id) async {
    final Database _db = await DatabaseHelper().database;
    int deleteStatus =
        await _db.rawDelete('DELETE FROM $_tableName WHERE _todoId = ?', [id]);

    return deleteStatus;
  }

  Future<void> updateTodoList(int id, String up_todoTitle,
      String up_todoDeadline, String up_priority) async {
    print('updation executed!');
    final Database _db = await DatabaseHelper().database;

    List<Map<String, dynamic>> updateStatus = await _db.rawQuery(
        'UPDATE $_tableName SET _todoTitle=?,_todoPriority=?,_todoDeadline=? WHERE _todoId=?',
        [up_todoTitle, up_priority, up_todoDeadline, id]);
    // print(updateStatus.first[0]);
  }
}
