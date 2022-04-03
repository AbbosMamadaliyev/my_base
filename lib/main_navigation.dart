import 'package:flutter/material.dart';
import 'package:my_base/ui/edit_item_page/edit_item_page.dart';
import 'package:my_base/ui/input_category_and_color_page/input_category_color_page.dart';

abstract class MainNavigationRouteNames {
  static const String inputCategoryPage = '/inputCategoryPage';
  static const String editItems = '/editItem';
}

class MainNavigation {
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.inputCategoryPage: (context) =>
        const InputCategoryPage(),
    MainNavigationRouteNames.editItems: (context) => const EditItemPage(),
  };
}
