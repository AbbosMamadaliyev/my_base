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

  List<bool> isVisibilityPass = [];

  final List<Credentials> _credentials = [];
  final List<TitleModel> _titles = [];
  final List<List<DataModel>> _datas = [];
  final List<DataModel> _data = [];

  List<Category> categories = [];

  List<Credentials> get credentials => _credentials;

  List<DataModel> get data => _data;

  List<TitleModel> get titles => _titles;

  List<List<DataModel>> get datas => _datas;

  List<String> defaultPass = [];

  void setCategoryId(int index) {
    categoryId = index;
    // notifyListeners();
  }

  void getCategory() {
    dbRepository.getCategory().then((value) {
      categories.clear();
      categories.addAll(value);
      notifyListeners();
    });
  }

  getCredentialsByCategoryId(int categoryId) {
    dbRepository.getCredentialsByCategoryId(categoryId).then((value) {
      _credentials.clear();
      _credentials.addAll(value);
      notifyListeners();
    });
  }

  void fullDefault() {
    isVisibilityPass = List.filled(_credentials.length, false, growable: false);
    defaultPass = List.filled(_credentials.length, '*****', growable: true);
  }

  void visibility(int index) {
    print('index:$index');
    print('v: ${isVisibilityPass[index]}');
    // isVisibilityPass[index] = !isVisibilityPass[index];
    if (isVisibilityPass[index] == false) {
      isVisibilityPass[index] = true;
      defaultPass[index] = _credentials[index].password!;
      print('vis do: ${isVisibilityPass[index]}');
      print('pass do: ${defaultPass[index]}');

      notifyListeners();
    } else {
      isVisibilityPass[index] = false;
      defaultPass[index] = '***********';
      print('vis posle: ${isVisibilityPass[index]}');
      notifyListeners();
    }
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
