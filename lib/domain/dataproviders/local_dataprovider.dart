import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:my_base/domain/models/credentials.dart';
import 'package:my_base/domain/models/title.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/categories.dart';
import '../models/files.dart';

class LocalDataProvider {
  LocalDataProvider._();

  static const databaseName = 'my_base.db';
  static const databaseVersion = 1;

  LocalDataProvider._privateConstructor();

  static final LocalDataProvider instance =
      LocalDataProvider._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      return initializeDatabase();
    }

    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    var databasePath = await getDatabasesPath();

    String path = join(databasePath, databaseName);
    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e);
      }
      ByteData data = await rootBundle.load(join('assets/db', databaseName));

      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);

      return openDatabase(path, version: databaseVersion);
    } else {
      //tepadagi ifdan ochvoladi birinchi, keyin elsedan ochilganni ishlataveradi

      return openDatabase(path, version: databaseVersion);
    }
  }
}

class LocalDataRepository {
  final db = LocalDataProvider.instance;

  Future<int?> addCategory(Category category) async {
    final database = await db.database;
    final res = database.insert(
      Category.tableName,
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  Future<List<Category>> getCategory() async {
    final database = db.database;
    try {
      final db = await database;
      List<Map<String, dynamic>> maps = await db.query('categories');

      return List.generate(
        maps.length,
        (index) => Category.fromMap(maps[index]),
      );
    } catch (e) {
      print(' error: $e');
      throw '$e';
    }
  }

  Future<List<TitleModel>> getAllTitle() async {
    final database = db.database;
    try {
      final db = await database;
      List<Map<String, dynamic>> maps = await db.query('title');

      return List.generate(
        maps.length,
        (index) => TitleModel.fromMap(maps[index]),
      );
    } catch (e) {
      print(' error: $e');
      throw '$e';
    }
  }

  Future<int?> addCredentials(Credentials credentials) async {
    final database = await db.database;
    final res = database.insert(
      Credentials.tableName,
      credentials.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  Future<int?> addTitle(TitleModel titleModel) async {
    final database = await db.database;
    final res = database.insert(
      TitleModel.tableName,
      titleModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  Future<int?> addFile(FileModel fileModel) async {
    final database = await db.database;
    final res = database.insert(
      FileModel.tableName,
      fileModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  Future<List<Credentials>> getCredentialsByCategoryId(int categoryId) async {
    final database = db.database;
    try {
      final db = await database;
      List<Map<String, dynamic>> maps = await db.rawQuery(
          'SELECT * FROM credentials WHERE category_id = $categoryId');

      return List.generate(
        maps.length,
        (index) => Credentials.fromMap(maps[index]),
      );
    } catch (e) {
      print(' error: $e');
      throw '$e';
    }
  }

  Future<List<TitleModel>> getTitlesByCategoryId(int categoryId) async {
    final database = db.database;
    try {
      final db = await database;
      List<Map<String, dynamic>> maps = await db
          .rawQuery('SELECT * FROM title WHERE category_id = $categoryId');

      return List.generate(
        maps.length,
        (index) => TitleModel.fromMap(maps[index]),
      );
    } catch (e) {
      print(' error: $e');
      throw '$e';
    }
  }

  Future<List<FileModel>> getAllFiles() async {
    final database = db.database;
    try {
      final db = await database;
      List<Map<String, dynamic>> maps = await db.query(FileModel.tableName);

      return List.generate(
        maps.length,
        (index) => FileModel.fromMap(maps[index]),
      );
    } catch (e) {
      print(' error: $e');
      throw '$e';
    }
  }

  Future<int?> deleteTitle(int category_id) async {
    final database = await db.database;
    return database.delete(
      TitleModel.tableName,
      whereArgs: [category_id],
      where: 'category_id = ?',
    );
  }

  Future<int?> deleteFile(int id) async {
    final database = await db.database;
    return database.delete(
      FileModel.tableName,
      whereArgs: [id],
      where: 'id = ?',
    );
  }

  Future<int?> deleteCredentials(int category_id) async {
    final database = await db.database;
    return database.delete(
      Credentials.tableName,
      whereArgs: [category_id],
      where: 'category_id = ?',
    );
  }

  Future<int?> deleteCategory(int id) async {
    final database = await db.database;
    return database.delete(
      Category.tableName,
      whereArgs: [id],
      where: 'id = ?',
    );
  }

  // update, edit
  Future<int?> updateTitle(TitleModel title) async {
    final database = await db.database;
    return database.update(
      TitleModel.tableName,
      title.toMap(),
      where: 'id = ?',
      whereArgs: [title.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // update, edit
  Future<int?> updateCredentials(Credentials credentials) async {
    final database = await db.database;
    return database.update(
      Credentials.tableName,
      credentials.toMap(),
      where: 'id = ?',
      whereArgs: [credentials.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // update, edit
  Future<int?> updateCategory(Category category) async {
    final database = await db.database;
    return database.update(
      Category.tableName,
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
