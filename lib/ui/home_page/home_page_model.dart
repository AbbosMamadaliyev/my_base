import 'package:flutter/cupertino.dart';
import 'package:my_base/domain/dataproviders/local_dataprovider.dart';
import 'package:my_base/domain/models/credentials.dart';
import 'package:my_base/domain/models/title.dart';

import '../../domain/models/categories.dart';

class HomePageModel extends ChangeNotifier {
  final dbRepository = LocalDataRepository();

  final List<Credentials> _credentials = [];
  final List<TitleModel> _titles = [];
  List<Category> categories = [];

  List<Credentials> get credentials => _credentials;

  List<TitleModel> get titles => _titles;

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
      // fullDefault();

      notifyListeners();
    });
  }

  getDataByCategoryId(int categoryId) {
    _getCredentialsByCategoryId(categoryId);
    _getTitlesByCategoryId(categoryId);
  }

  void deleteData(int categoryId) {
    dbRepository.deleteCredentials(categoryId);
    dbRepository.deleteTitle(categoryId);
    dbRepository.deleteCategory(categoryId);
  }

  void getAllTitles() {
    dbRepository.getAllTitle().then((value) => print('data: ${value.length}'));
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
