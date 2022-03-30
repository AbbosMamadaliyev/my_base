import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_page/home_page_model.dart';

class ViewDataPage extends StatefulWidget {
  final int index;

  const ViewDataPage({Key? key, required this.index}) : super(key: key);

  @override
  _ViewDataPageState createState() => _ViewDataPageState();
}

class _ViewDataPageState extends State<ViewDataPage> {
  bool isVisibilityPass = false;
  String pass = '***********';

  @override
  void didChangeDependencies() {
    context.watch<HomePageModel>().getData(widget.index);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomePageModel>();

    final datas = model.data;

    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: ListView.builder(
          itemCount: datas.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(datas[index].title),
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
                                              context
                                                  .read<HomePageModel>()
                                                  .deleteItem(
                                                      datas[index].id!, index);

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
                    Text(
                      'username: ${datas[index].username!}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'password: $pass',
                          style: const TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isVisibilityPass = !isVisibilityPass;
                              pass = isVisibilityPass
                                  ? datas[index].password!
                                  : '***********';
                              print(pass);
                              print(isVisibilityPass);
                            });
                          },
                          icon: isVisibilityPass
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
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
