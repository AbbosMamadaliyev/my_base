import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../home_page/home_page_model.dart';

class UsernameDataWidget extends StatelessWidget {
  final int index;
  const UsernameDataWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final username = context.select<HomePageModel, String>(
    //     (value) => value.credentials[index].username ?? '');
    final username = context.watch<HomePageModel>().credentials[index].username;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'username:   $username',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        IconButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: username)).then((_) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("username copied to clipboard")));
            });
          },
          icon: const Icon(Icons.copy),
        ),
      ],
    );
  }
}
