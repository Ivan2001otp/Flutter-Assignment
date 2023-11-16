import 'package:brew_basterd_app/model/brew_model.dart';
import 'package:brew_basterd_app/service/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  String _tableName = 'brew_table';
  String colId = 'id';
  String colName = 'name';
  String colImg = 'image_url';

  Future<List<SavedModel>> getAllSavedList() async {
    final databaseInstance = await DatabaseHelper().database;

    List<Map<String, dynamic>> responseDBList =
        await databaseInstance.rawQuery('SELECT * FROM $_tableName');

    return List.generate(responseDBList.length,
        (index) => SavedModel.fromMapObject(responseDBList[index]));
  }

  Future<int> saveFavouriteBrew(SavedModel savedModel) async {
    final databaseInstance = await DatabaseHelper().database;

    var result = databaseInstance.insert(_tableName, savedModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);

    return result;
  }

  Future<void> closeDatabaseLayer() async {
    final Database _db = await DatabaseHelper().database;
    await _db.close();
  }

  Future<int> deleteFavouriteBrew(int id) async {
    final databaseInstance = await DatabaseHelper().database;

    int deleteStatus = await databaseInstance
        .rawDelete('DELETE FROM $_tableName WHERE id = ?', [id]);

    return deleteStatus;
  }
}
