import 'dart:io';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import 'components/app_bar.dart';
import 'components/form_fields.dart';
import 'components/signup_text_button.dart';
import 'components/welcome_back_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LocalAuthentication auth = LocalAuthentication();

  void checkBiometric() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (Platform.isIOS) {
      if (availableBiometrics.contains(BiometricType.face)) {
        // Face ID.
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        // Touch ID.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              WelcomeBackText(),
              FormFields(),
              SignUptextButton(),
            ],
          ),
        ),
      ),
    );
  }
}
