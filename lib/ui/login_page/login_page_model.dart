import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/dataproviders/auth_service/auth_service.dart';
import '../../domain/models/user.dart';
import '../../main_navigation.dart';

class SignInProvider extends ChangeNotifier {
  final _authService = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? _loginErrorMessage;

  String? get loginErrorMessage => _loginErrorMessage;

  bool _isAuthProgress = false;

  bool get isAuthProgress => _isAuthProgress;

  bool get canStartAuth => !_isAuthProgress;

  void loginButtonAction(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _loginErrorMessage = '- Заполните поля';
      notifyListeners();
      return;
    }
    _loginErrorMessage = null;
    _isAuthProgress = true;
    print('sorov yuborildi: $_isAuthProgress');
    notifyListeners();

    UserModel? userModel = await _authService.signinWithEmailAndPass(
      email.trim(),
      password.trim(),
    );

    _isAuthProgress = false;
    print('javob keldi: $_isAuthProgress');
    notifyListeners();

    if (userModel == null) {
      _loginErrorMessage =
          '- Ошибка электронной почты или пароля! \n Если вы посещаете сайт впервые, пожалуйста, зарегистрируйтесь.';
      notifyListeners();
    } else {
      _saveLogin();
      Navigator.pushReplacementNamed(
          context, MainNavigationRouteNames.homePage);
      _isAuthProgress = false;
      emailController.clear();
      passwordController.clear();
      notifyListeners();
    }
  }

  Future<void> checkInternet(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      print('ok internet');
      loginButtonAction(context);
      return;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      print('ok wifi');

      loginButtonAction(context);
      return;
    } else if (connectivityResult == ConnectivityResult.none) {
      print('no');

      _loginErrorMessage = ' - No internet';
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No internet, please check your connectivity!'),
        backgroundColor: Colors.red,
      ));
      notifyListeners();
      return;
    }
  }

  void _saveLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_login_in', true);
  }
}
