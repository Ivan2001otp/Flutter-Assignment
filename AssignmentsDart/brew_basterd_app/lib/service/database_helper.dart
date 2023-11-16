import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
import 'dart:io';
import 'dart:async';

class DatabaseHelper {
  int _dbVersion = 1;
  String _tableName = 'brew_table';
  String colId = 'id';
  String colName = 'name';
  String colImg = 'image_url';

  static DatabaseHelper _dbInstance = DatabaseHelper._internal();

  factory DatabaseHelper() => _dbInstance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database == null || !(_database!.isOpen)) {
      _database = await _initializeDB();
    }
    return _database!;
  }

  Future<Database> _initializeDB() async {
    var directory = await getApplicationDocumentsDirectory();

    String path = '${directory.path}brew.db';
    // deleteDatabase(path);

    var databaseInstance = await openDatabase(path,
        version: _dbVersion, onCreate: _OnCreateCallback);
    return databaseInstance;
  }

  Future<void> _OnCreateCallback(Database dbInstance, int dbversion) async {
    await dbInstance.execute(
        'CREATE TABLE ${_tableName}($colId INTEGER PRIMARY KEY,$colName TEXT,$colImg TEXT)');
  }
}
