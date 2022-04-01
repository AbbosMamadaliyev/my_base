import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../home_page/home_page_model.dart';

class ViewDataPage extends StatefulWidget {
  final int id;

  const ViewDataPage({Key? key, required this.id}) : super(key: key);

  @override
  _ViewDataPageState createState() => _ViewDataPageState();
}

class _ViewDataPageState extends State<ViewDataPage> {
  bool obscureText = true;

  @override
  void didChangeDependencies() {
    context.watch<HomePageModel>().getDataByCategoryId(widget.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomePageModel>();
    final credentials = model.credentials;
    final titles = model.titles;

    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
      ),
      body: ListView.builder(
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '--- ${titles[index].title}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'username:   ${credentials[index].username!}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                    text: credentials[index].username))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "username copied to clipboard")));
                            });
                          },
                          icon: const Icon(Icons.copy),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'password: ',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          width: 150,
                          child: TextField(
                            enabled: false,
                            controller: TextEditingController(
                                text: credentials[index].password!),
                            obscureText: obscureText,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: obscureText
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                    text: credentials[index].password))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "password copied to clipboard")));
                            });
                          },
                          icon: const Icon(Icons.copy),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

/*
    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('title'),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.green,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Delete item'),
                                        content: const Text(
                                            'Rostan o\'chirmoqchimisiz?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('no'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('yes'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

* */
