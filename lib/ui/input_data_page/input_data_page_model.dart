import 'package:flutter/material.dart';
import 'package:my_base/domain/dataproviders/local_dataprovider.dart';
import 'package:my_base/domain/models/categories.dart';

import '../../domain/models/credentials.dart';
import '../../domain/models/title.dart';

class InputDataPageModel extends ChangeNotifier {
  final dbRepository = LocalDataRepository();
  final categoryNameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final filePathController = TextEditingController();
  final titleController = TextEditingController();

  List<Category> categories = [];
  int? idCategory;

  int categoryId = 5;
  String categoryText = 'category';
  String errorText = '';

  void getCategory() {
    dbRepository.getCategory().then((value) {
      categories.clear();
      categories.addAll(value);
      notifyListeners();
    });
  }

  void addCategory(Color color, String categoryName, BuildContext context) {
    if (categoryName.isEmpty) {
      categoryName = 'Kategoriyasiz';
    }

    for (Category category in categories) {
      if (category.name == categoryName) {
        errorText =
            'bunday kategoriya mavjud, iltimos yangi kategoriya kiriting yoki mavjud kategoriyani tanlang';
        notifyListeners();
        return;
      }
    }

    errorText = 'Yangi kategoriya qo\'shildi';
    notifyListeners();

    final category = Category.add(name: categoryName, color: color.toString());
    print('name: ${category.name}, color: ${category.color}');
    dbRepository.addCategory(category).then((value) {
      idCategory = value;
      print('id: $idCategory');
      notifyListeners();
    });

    Navigator.pop(context, [categoryName, color]);
  }

  void _addData() {
    if (idCategory == null) {
      print('nullku id');
      return;
    }

    final title =
        TitleModel.add(category_id: idCategory!, title: titleController.text);

    final credentials = Credentials.add(
      category_id: idCategory!,
      password: passwordController.text,
      username: usernameController.text,
    );

    dbRepository.addCredentials(credentials);
    dbRepository.addTitle(title);

    errorText = '';
    notifyListeners();

    titleController.clear();
    passwordController.clear();
    usernameController.clear();
  }

  void addData(BuildContext context) {
    print(titleController.text);
    if (titleController.text.isEmpty) {
      errorText = 'title bo\'sh bo\'lishi mumkin emas. Iltimos nimadir yozing!';
      notifyListeners();
      return;
    }

    _addData();

    if (errorText.isNotEmpty) return;

    idCategory = null;
    notifyListeners();

    Navigator.of(context).pop();
  }
}
