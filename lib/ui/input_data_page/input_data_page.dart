import 'package:flutter/material.dart';
import 'package:my_base/ui/home_page/home_page_model.dart';
import 'package:provider/provider.dart';

import '../../main_navigation.dart';
import 'input_data_page_model.dart';

class InputInfoPage extends StatefulWidget {
  const InputInfoPage({Key? key}) : super(key: key);

  @override
  _InputInfoPageState createState() => _InputInfoPageState();
}

class _InputInfoPageState extends State<InputInfoPage> {
  dynamic result;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<HomePageModel>().getCategory();
  }

  String categoryName = '';

  @override
  Widget build(BuildContext context) {
    final model = context.watch<InputDataPageModel>();
    final categories = context.watch<HomePageModel>().categories;

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
                Text(
                  'category: $categoryName',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: SizedBox(
                              width: double.maxFinite,
                              // height: 450,
                              child: ListView(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  OutlinedButton(
                                    onPressed: () async {
                                      result = await Navigator.of(context)
                                          .popAndPushNamed(
                                              MainNavigationRouteNames
                                                  .inputCategoryPage);
                                      setState(() {
                                        categoryName = result[0];
                                      });
                                    },
                                    child: const Text(
                                      'new category',
                                      style:
                                          TextStyle(color: Color(0xff0e0c0c)),
                                    ),
                                  ),
                                  ListView.builder(
                                      itemBuilder: (context, index) {
                                        return OutlinedButton(
                                          onPressed: () {
                                            model.idCategory =
                                                categories[index].id!;

                                            setState(() {
                                              categoryName =
                                                  categories[index].name!;
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            categories[index].name!,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color(0xff0e0c0c)),
                                          ),
                                        );
                                      },
                                      itemCount: categories.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics()),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  icon: const Icon(Icons.add),
                ),
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
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                if (model.idCategory == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('iltimos kategoriyani kiriting'),
                    backgroundColor: Colors.red,
                  ));
                  return;
                }
                context.read<InputDataPageModel>().addData(context);

                model.errorText.isEmpty
                    ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Yaratildi'),
                        backgroundColor: Colors.red,
                      ))
                    : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(model.errorText),
                        backgroundColor: Colors.red,
                      ));
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
