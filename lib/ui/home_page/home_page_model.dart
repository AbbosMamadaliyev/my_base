import 'package:flutter/cupertino.dart';
import 'package:my_base/domain/dataproviders/local_dataprovider.dart';
import 'package:my_base/domain/models/credentials.dart';
import 'package:my_base/domain/models/title.dart';

import '../../domain/models/categories.dart';

class HomePageModel extends ChangeNotifier {
  final dbRepository = LocalDataRepository();

  final db = LocalDataProvider.instance;
  int categoryId = 1;

  List<bool> isVisibilityPass = [];

  final List<Credentials> _credentials = [];
  final List<TitleModel> _titles = [];

  List<Category> categories = [];

  List<Credentials> get credentials => _credentials;

  List<TitleModel> get titles => _titles;

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

  _getCredentialsByCategoryId(int categoryId) {
    dbRepository.getCredentialsByCategoryId(categoryId).then((value) {
      _credentials.clear();
      _credentials.addAll(value);
      notifyListeners();
    });
  }

  _getTitlesByCategoryId(int categoryId) {
    dbRepository.getTitlesByCategoryId(categoryId).then((value) {
      _titles.clear();
      _titles.addAll(value);
      notifyListeners();
    });
  }

  getDataByCategoryId(int categoryId) {
    _getCredentialsByCategoryId(categoryId);
    _getTitlesByCategoryId(categoryId);
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

  /*// delete
  Future<int?> _deleteItem(int id) async {
    final database = await db.database;
    return database.delete(
      DataModel.tableName,
      whereArgs: [id],
      where: 'id = ?',
    );
  }*/

  /*void deleteItem(int id, int index) {
    _deleteItem(id);
  }*/
}
