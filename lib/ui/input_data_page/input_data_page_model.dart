import 'package:flutter/material.dart';
import 'package:my_base/domain/dataproviders/local_dataprovider.dart';
import 'package:my_base/domain/models/categories.dart';
import 'package:my_base/domain/models/data_model.dart';

class InputDataPageModel extends ChangeNotifier {
  final dbRepository = LocalDataRepository();
  final categoryNameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final filePathController = TextEditingController();
  final titleController = TextEditingController();

  int categoryId = 5;

  List<Category> items = [
    /*'Bank va gos. organ',
    'Ish',
    'Universitet',
    'Ijtimoiy tarmoqlar',
    'Dastur va ilovalar',
    'Kategoriyasiz',*/
  ];

  void addCategory(Color color) {
    final category =
        Category(name: categoryNameController.text, color: color.toString());
    print('name: ${category.name}, color: ${category.color}');
    dbRepository.addCategory(category);

    dbRepository.getCategory().then((value) {
      print(value.length);
    });
  }

  void getCategory() {
    dbRepository.getCategory().then((value) {
      items.clear();
      items.addAll(value);
      notifyListeners();
    });
  }

  void onChangedDropdownBtn(String? value) {
    categoryNameController.text = value!;
    _chooseCategoryId(value);
    notifyListeners();
  }

  void addData() {
    final dataModel = DataModel.add(
      username: usernameController.text,
      password: passwordController.text,
      filePath: filePathController.text,
      title: titleController.text,
      category_id: categoryId,
    );

    dbRepository.addData(dataModel);

    titleController.clear();
    usernameController.clear();
    filePathController.clear();
    passwordController.clear();
  }

  void _chooseCategoryId(String value) {
    switch (value) {
      case 'Bank va gos. organ':
        categoryId = 0;
        notifyListeners();
        break;
      case 'Ish':
        categoryId = 1;
        notifyListeners();
        break;
      case 'Universitet':
        categoryId = 2;
        notifyListeners();
        break;
      case 'Ijtimoiy tarmoqlar':
        categoryId = 3;
        notifyListeners();
        break;
      case 'Dastur va ilovalar':
        categoryId = 4;
        notifyListeners();
        break;
      case 'Kategoriyasiz':
        categoryId = 5;
        notifyListeners();
        break;
    }
  }
}
