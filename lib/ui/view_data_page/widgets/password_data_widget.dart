import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../home_page/home_page_model.dart';

class PasswordDataWidget extends StatefulWidget {
  final int index;
  final int length;

  const PasswordDataWidget(
      {Key? key, required this.index, required this.length})
      : super(key: key);

  @override
  State<PasswordDataWidget> createState() => _PasswordDataWidgetState();
}

class _PasswordDataWidgetState extends State<PasswordDataWidget> {
  late List<int> defaultIndex;
  late List<bool> visiblt;

  @override
  void initState() {
    super.initState();
    defaultIndex = List.filled(widget.length, -1, growable: true);
    visiblt = List.filled(widget.length, false, growable: true);
  }

  @override
  Widget build(BuildContext context) {
    final password =
        context.watch<HomePageModel>().credentials[widget.index].password ?? '';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'password: ',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 150,
          child: Visibility(
            child: Text(
              password,
              overflow: TextOverflow.ellipsis,
            ),
            visible: visiblt[widget.index],
            replacement: Text(password.isEmpty ? '' : '*******'),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              if (defaultIndex[widget.index] == widget.index) {
                defaultIndex[widget.index] = -1;
                visiblt[widget.index] = false;
              } else {
                defaultIndex[widget.index] = widget.index;
                visiblt[widget.index] = true;
              }
            });
          },
          icon: defaultIndex[widget.index] == widget.index
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
        ),
        IconButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: password)).then((_) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("password copied to clipboard")));
            });
          },
          icon: const Icon(Icons.copy),
        ),
      ],
    );
  }
}
