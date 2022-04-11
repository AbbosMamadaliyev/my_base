import 'package:flutter/material.dart';
import 'package:my_base/ui/edit_item_page/edit_item_page.dart';
import 'package:my_base/ui/home_page/home_page.dart';
import 'package:my_base/ui/input_category_and_color_page/input_category_color_page.dart';
import 'package:my_base/ui/signup_page/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/login_page/login_page.dart';

abstract class MainNavigationRouteNames {
  static const String inputCategoryPage = '/inputCategoryPage';
  static const String editItems = '/editItem';
  static const String homePage = '/home';
  static const String signIn = '/signin';
  static const String signUp = '/signUp';
}

class MainNavigation {
  Future<String> initialRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogIn = prefs.getBool('is_login_in') ?? false;
    return isLogIn
        ? MainNavigationRouteNames.signIn
        : MainNavigationRouteNames.signUp;
  }

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.inputCategoryPage: (context) =>
        const InputCategoryPage(),
    MainNavigationRouteNames.editItems: (context) => const EditItemPage(),
    MainNavigationRouteNames.homePage: (context) => const MyHomePage(),
    MainNavigationRouteNames.signIn: (context) => const LoginPage(),
    MainNavigationRouteNames.signUp: (context) => const SignupPage(),
  };
}
