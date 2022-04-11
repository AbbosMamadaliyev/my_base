import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../signup_page_model.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final errorMsg = context.watch<SignUpProvider>().signUpErrorMessage;
    if (errorMsg == null) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(top: height * 0.02, bottom: height * 0.2),
        child: Text(
          errorMsg,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
