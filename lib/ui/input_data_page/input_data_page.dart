import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../input_category_and_color_page/input_category_color_page.dart';
import 'input_data_page_model.dart';

class InputInfoPage extends StatefulWidget {
  const InputInfoPage({Key? key}) : super(key: key);

  @override
  _InputInfoPageState createState() => _InputInfoPageState();
}

class _InputInfoPageState extends State<InputInfoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<InputDataPageModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('input data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: model.titleController,
              decoration: const InputDecoration(
                hintText: 'title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /*SizedBox(
                  width: 200,
                  child: TextField(
                    controller: TextEditingController(
                      text: model.categoryNameController.text,
                    ),
                    enabled: false,
                    decoration: const InputDecoration(
                      hintText: 'category',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),*/
                Text(model.categoryNameController.text),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const InputCategoryPage()),
                    );
                  },
                  icon: const Icon(Icons.add),
                ),
                /* DropdownButton<String>(
                  elevation: 0,
                  underline: Container(),
                  items: buildDropDownMenuItems(model.items),
                  onChanged: model.onChangedDropdownBtn,
                ),*/
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: model.usernameController,
              decoration: const InputDecoration(
                hintText: 'username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: model.passwordController,
              decoration: const InputDecoration(
                hintText: 'password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            /*TextField(
              controller: model.filePathController,
              decoration: const InputDecoration(
                hintText: 'file',
                border: OutlineInputBorder(),
              ),
            ),*/
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                context.read<InputDataPageModel>().addData();
              },
              child: const Text('add'),
            ),
            // Text(context.watch<InputDataPageModel>().items[0].name.toString()),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<String>> items = [];
    for (String listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem),
          value: listItem,
        ),
      );
    }
    return items;
  }
}
