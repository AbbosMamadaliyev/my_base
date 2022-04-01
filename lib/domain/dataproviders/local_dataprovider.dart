import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:my_base/domain/models/credentials.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/categories.dart';
import '../models/data_model.dart';

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

  Future<int?> addData(DataModel dataModel) async {
    final database = await db.database;
    final res = database.insert(
      DataModel.tableName,
      dataModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  Future<List<DataModel>> getData(int categoryId) async {
    final database = db.database;
    try {
      final db = await database;
      List<Map<String, dynamic>> maps = await db
          .rawQuery('SELECT * FROM data WHERE category_id = $categoryId');

      return List.generate(
        maps.length,
        (index) => DataModel.fromMap(maps[index]),
      );
    } catch (e) {
      print(' error: $e');
      throw '$e';
    }
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
}
