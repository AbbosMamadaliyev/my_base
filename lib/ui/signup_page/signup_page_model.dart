import 'package:flutter/material.dart';

import '../../domain/dataproviders/auth_service/auth_service.dart';
import '../../domain/models/user.dart';
import '../../main_navigation.dart';

class SignUpProvider extends ChangeNotifier {
  final _authService = AuthService();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isAuthProgress = false;
  bool get isAuthProgress => _isAuthProgress;
  bool get canStartAuth => !_isAuthProgress;

  String? _signUpErrorMessage;
  String? get signUpErrorMessage => _signUpErrorMessage;

  void registerButtonAction(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    String name = nameController.text;

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      _signUpErrorMessage = '- Заполните поля';
      notifyListeners();
      return;
    }

    _signUpErrorMessage = null;
    _isAuthProgress = true;
    print('sorov yuborildi: $_isAuthProgress');
    notifyListeners();

    UserModel? userModel = await _authService.registerWithEmailAndPass(
      email.trim(),
      password.trim(),
    );

    _isAuthProgress = false;
    print('javob keldi: $_isAuthProgress');
    notifyListeners();

    if (userModel == null) {
      _signUpErrorMessage =
          '- Этот адрес электронной почты мог быть использован ранее, пожалуйста, введите другой адрес электронной почты! Количество символов пароля должно быть не менее 8';
      notifyListeners();
    } else {
      Navigator.pushNamed(context, MainNavigationRouteNames.signIn);
      _isAuthProgress = false;
      _signUpErrorMessage = null;
      emailController.clear();
      passwordController.clear();
      nameController.clear();
      notifyListeners();
    }
  }
}
