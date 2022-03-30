import 'package:flutter/cupertino.dart';
import 'package:my_base/domain/dataproviders/local_dataprovider.dart';
import 'package:my_base/domain/models/credentials.dart';
import 'package:my_base/domain/models/data_model.dart';
import 'package:my_base/domain/models/title.dart';

import '../../domain/models/categories.dart';

class HomePageModel extends ChangeNotifier {
  final dbRepository = LocalDataRepository();

  final db = LocalDataProvider.instance;
  int categoryId = 1;

  final List<Credentials> _credentials = [];
  final List<TitleModel> _titles = [];
  final List<DataModel> _allData = [];
  final List<DataModel> _data = [];

  List<Category> categories = [];

  List<Credentials> get credentials => _credentials;

  List<DataModel> get data => _data;

  List<TitleModel> get titles => _titles;

  List<DataModel> get allData => _allData;

  /*Future<List<Credentials>> _getCredentials(int category_id) async {
    final database = db.database;
    try {
      final db = await database;
      List<Map<String, dynamic>> maps = await db.rawQuery(
          'SELECT * FROM credentials WHERE category_id = $category_id');
      // print(maps);

      return List.generate(
          maps.length, (index) => Credentials.fromMap(maps[index]));
    } catch (e) {
      print(' error: $e');
      throw '$e';
    }
  }*/

  /*Future<List<DataModel>> _getDatas(int category_id) async {
    final database = db.database;
    try {
      final db = await database;
      List<Map<String, dynamic>> maps = await db
          .rawQuery('SELECT * FROM data WHERE category_id = $category_id');
      // print(maps);

      return List.generate(
        maps.length,
        (index) => DataModel.fromMap(maps[index]),
      );
    } catch (e) {
      print(' error: $e');
      throw '$e';
    }
  }*/

  Future<List<DataModel>> _getData(int categoryId) async {
    final database = db.database;
    try {
      final db = await database;
      List<Map<String, dynamic>> maps = await db
          .rawQuery('SELECT * FROM data WHERE category_id = $categoryId');
      // print(maps);

      return List.generate(
        maps.length,
        (index) => DataModel.fromMap(maps[index]),
      );
    } catch (e) {
      print(' error: $e');
      throw '$e';
    }
  }

  void setCategoryId(int index) {
    categoryId = index;
    // notifyListeners();
  }

  /* Future<List<TitleModel>> _getData(int categoryID) async {
    final database = db.database;
    try {
      final db = await database;
      List<Map<String, dynamic>> maps =
          await db.query('SELECT * FROM data WHERE category_id = $categoryID');

      return List.generate(
          maps.length, (index) => TitleModel.fromMap(maps[index]));
    } catch (e) {
      print('error: $e');
      throw '$e';
    }
  }*/

  void getCategory() {
    dbRepository.getCategory().then((value) {
      categories.clear();
      categories.addAll(value);
      notifyListeners();
    });
  }

  getData(int categoryId) {
    _getData(categoryId).then((value) {
      _data.clear();
      _data.addAll(value);
      notifyListeners();
    });
  }

  getAllData() {
    dbRepository.getAllData().then((value) {
      _allData.clear();
      _allData.addAll(value);
      notifyListeners();
    });
  }

  // delete
  Future<int?> _deleteItem(int id) async {
    final database = await db.database;
    return database.delete(
      DataModel.tableName,
      whereArgs: [id],
      where: 'id = ?',
    );
  }

  void deleteItem(int id, int index) {
    _deleteItem(id);
  }
}
