import 'package:path/path.dart';
import 'package:save_u/models/sub_category.dart';
import 'package:sqflite/sqflite.dart';
import 'package:save_u/models/safe_info.dart';

class DBHelper {
  static const int _version = 1;
  static const String _dbName = "SaveU.db";

  static var sub_categories = [
    {"id": 1, "name": "지진/해일", "categoryId": 1},
    {"id": 2, "name": "태풍/침수/홍수/낙뢰/호우", "categoryId": 1},
    {"id": 3, "name": "산불/화재", "categoryId": 1},
    {"id": 4, "name": "가뭄/폭염", "categoryId": 1},
    {"id": 5, "name": "한파/폭설", "categoryId": 1},
    {"id": 6, "name": "황사/미세먼지", "categoryId": 1},
  ];

  static Future<Database> _getDatabase() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) => _createDatabase(db), version: _version);
  }

  static void _createDatabase(Database db) async {
    await db.execute(
        "CREATE TABLE category(id INTEGER PRIMARY KEY, name TEXT NOT NULL);");
    await db.execute(
        "CREATE TABLE SubCategory(id INTEGER PRIMARY KEY, name TEXT NOT NULL, categoryId INT NOT NULL);");
    await db.execute(
        "CREATE TABLE SafeInfo(id INTEGER PRIMARY KEY, title TEXT NOT NULL, content TEXT NOT NULL, scrab BOOLEAN NOT NULL, link TEXT NOT NULL, subCategoryId INTEGER NOT NULL);");
    var categories = [
      {"id": 1, "name": "자연재해"}
    ];
    await db.insert('category', categories[0]);

    var batch = db.batch();
    for (int i = 0; i < sub_categories.length; i++) {
      batch.insert('SubCategory', sub_categories[i]);
    }
    await batch.commit(noResult: true);
  }

  static Future<int> addSafeInfo(SafeInfo safeInfo) async {
    final db = await _getDatabase();
    return await db.insert("SafeInfo", safeInfo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateSafeInfoScrab(SafeInfo safeInfo) async {
    final db = await _getDatabase();
    return await db.update("SafeInfo", safeInfo.toJson(),
        where: 'id=?',
        whereArgs: [safeInfo.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteNote(SafeInfo safeInfo) async {
    final db = await _getDatabase();
    return await db.delete(
      "SafeInfo",
      where: 'id=?',
      whereArgs: [safeInfo.id],
    );
  }

  static Future<List<SubCategory>?> getAllSubCategories() async {
    final db = await _getDatabase();

    final List<Map<String, dynamic>> maps = await db.query("SubCategory");

    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => SubCategory.fromJson(maps[index]));
  }

  static Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);
}
