import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoister_clone/model/todo.dart';

class DatabaseHelper {
  //name of db is - todos.db
  int _dbVersion = 1;
  String tableName = 'todo_table';
  String colId = '_todoId';
  String colTitle = '_todoTitle';
  String colPriority = '_todoPriority';
  String colDeadline = '_todoDeadline';
  //remeber to store date time values in String which is in ISO 8601 format

  static DatabaseHelper _dbInstance = DatabaseHelper._internal();

  factory DatabaseHelper() => _dbInstance;

  static Database? _database;

  DatabaseHelper._internal();

  //creating the datbase
  Future<Database> get database async {
    if (_database == null || !(_database!.isOpen)) {
      _database = await _initializeDB();
    }
    return _database!;
  }

  void closeDatabaseLayer() async {
    Database db = await database;
    await db.close();
  }

  Future<Database> _initializeDB() async {
    var directory = await getApplicationDocumentsDirectory();
    // String path = directory.path + 'todos.db';
    String path = join(directory.path, 'todos.db');
    //clean slate
    // await deleteDatabase(path);

    var databaseInstance = await openDatabase(path,
        version: _dbVersion, onCreate: _onCreateCallback);

    return databaseInstance;
  }

  Future<void> _onCreateCallback(Database dbInstance, int db_version) async {
    //creates table
    await dbInstance.execute(
        'CREATE TABLE $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colTitle TEXT,$colDeadline TEXT,$colPriority TEXT)');
  }
}
