import 'package:flutter/material.dart';
import 'package:my_base/ui/input_category_and_color_page/input_category_color_page.dart';

abstract class MainNavigationRouteNames {
  static const String inputCategoryPage = '/inputCategoryPage';
}

class MainNavigation {
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.inputCategoryPage: (context) =>
        const InputCategoryPage()
  };
}
