import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../signup_page_model.dart';

class CreateButton extends StatelessWidget {
  const CreateButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SignUpProvider>();

    final onPressed = model.canStartAuth == true
        ? () => model.registerButtonAction(context)
        : null;

    final child = model.isAuthProgress == true
        ? const SizedBox(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
            height: 15,
            width: 15,
          )
        : const Text(
            'Завести аккаунт',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          );

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xff659ed7),
          ),
          height: 56,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
