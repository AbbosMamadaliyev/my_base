import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Navigator.of(context).pushNamed(MainNavigationRouteNames.forgotPass);
        },
        child: const Text(
          'Forgot Password',
          style: TextStyle(color: Colors.redAccent),
        ),
      ),
    );
  }
}
