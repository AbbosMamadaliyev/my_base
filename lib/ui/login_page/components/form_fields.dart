import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../login_page_model.dart';
import 'create_button.dart';
import 'custom_container_for_forms.dart';
import 'custom_input_decoration.dart';
import 'error_text.dart';

class FormFields extends StatefulWidget {
  const FormFields({Key? key}) : super(key: key);

  @override
  State<FormFields> createState() => _FormFieldsState();
}

class _FormFieldsState extends State<FormFields> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          emailFormField(),
          passwordFormField(),
          const ErrorText(),
          const LoginButton(),
        ],
      ),
    );
  }

  CustomContainer passwordFormField() {
    return CustomContainer(
      titleForm: 'Пароль',
      child: TextFormField(
        controller: context.watch<SignInProvider>().passwordController,
        style: const TextStyle(color: Colors.black),
        validator: (value) {},
        decoration: customPasswordInputDecoration('Your password'),
        obscureText: !_showPassword,
      ),
    );
  }

  CustomContainer emailFormField() {
    return CustomContainer(
      titleForm: 'Email',
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        controller: context.watch<SignInProvider>().emailController,
        decoration: customInputDecoration('Your email address'),
      ),
    );
  }

  InputDecoration customPasswordInputDecoration(String hintText) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      suffixIcon: IconButton(
        onPressed: () {
          _toggleVisibility();
        },
        icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
      ),
      border: InputBorder.none,
      hintText: hintText,
      // hintStyle: TextStyle(color: Colors.black),
      enabledBorder: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.lightBlue),
      ),
    );
  }

  void _toggleVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
}
