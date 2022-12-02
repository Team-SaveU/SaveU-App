/*import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:save_u/models/sub_category.dart';
import 'package:sqflite/sqflite.dart';
import 'package:save_u/models/safe_info.dart';

class DBHelper {
  static const int _version = 1;
  static const String _dbName = "SaveU.db";

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
        "CREATE TABLE SafeInfo(id INTEGER PRIMARY KEY, title TEXT NOT NULL, content TEXT NOT NULL, scrab BOOLEAN NOT NULL, link TEXT, subCategoryId INTEGER NOT NULL);");

    final String response =
        await rootBundle.loadString('assets/categories.json');
    final data = await json.decode(response);
    var categories = data["items"];

    final String response2 =
        await rootBundle.loadString('assets/sub_categories.json');
    final data2 = await json.decode(response2);
    var subCategories = data2["items"];

    final String response3 =
        await rootBundle.loadString('data/safe_infos.json');
    final data3 = await json.decode(response3);
    var safeInfos = data3["items"];

    var batch = db.batch();
    for (int i = 0; i < categories.length; i++) {
      batch.insert('category', categories[i]);
    }
    for (int i = 0; i < subCategories.length; i++) {
      batch.insert('SubCategory', subCategories[i]);
    }
    for (int i = 0; i < safeInfos.length; i++) {
      batch.insert('SafeInfo', safeInfos[i]);
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
*/