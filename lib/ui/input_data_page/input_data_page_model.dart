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

  int categoryId = -1;
  String categoryText = 'Kategoriyasiz';
  String errorText = '';

  List<DataModel> dataList = [];

  List<Category> items = [
    /*'Bank va gos. organ',
    'Ish',
    'Universitet',
    'Ijtimoiy tarmoqlar',
    'Dastur va ilovalar',
    'Kategoriyasiz',*/
  ];

  onChangedCategory(String value) {
    categoryText = value;
    print(categoryText);
    notifyListeners();
  }

  void addCategory(/*Color color*/) {
    // categoryText = text;
    print('text: $categoryText');
    notifyListeners();

    /*  final category =
        Category(name: categoryNameController.text, color: color.toString());
    print('name: ${category.name}, color: ${category.color}');
    dbRepository.addCategory(category);

    dbRepository.getCategory().then((value) {
      print(value.length);
    });*/
  }

  void getCategory() {
    dbRepository.getCategory().then((value) {
      items.clear();
      items.addAll(value);
      notifyListeners();
    });
  }

  void getAllData() {
    dbRepository.getAllData().then((value) {
      dataList.clear();
      dataList.addAll(value);
      notifyListeners();
    });
  }

  void onChangedDropdownBtn(String? value) {
    categoryNameController.text = value!;
    _chooseCategoryId(value);
    notifyListeners();
  }

  void addData(Color color, String categoryname, BuildContext context) {
    print('category text :${categoryname}');
    if (categoryname.isEmpty) {
      categoryname = 'Kategoriyasiz';
    } else {
      for (DataModel data in dataList) {
        if (data.category_name == categoryname) {
          print('bunday categoriya mavjud');
          errorText =
              'bunday kategoriya mavjud, iltimos yangi kategoriya kiriting';
          notifyListeners();
          return;
        }
      }
    }

    final dataModel = DataModel.add(
      username: usernameController.text,
      password: passwordController.text,
      filePath: filePathController.text,
      title: titleController.text,
      category_name: categoryname,
      color: color.toString(),
    );

    dbRepository.addData(dataModel);

    titleController.clear();
    usernameController.clear();
    filePathController.clear();
    passwordController.clear();

    Navigator.of(context).pop();
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
