import 'package:flutter/material.dart';
import 'package:my_base/ui/home_page/home_page_model.dart';
import 'package:my_base/ui/input_data_page/input_data_page.dart';
import 'package:my_base/ui/input_data_page/input_data_page_model.dart';
import 'package:provider/provider.dart';

import '../view_all_files/all_files_page.dart';
import '../view_data_page/view_data_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<HomePageModel>().getCategory();
    context.read<InputDataPageModel>().getCategory();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomePageModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('my informations'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AllFilesPage()));
            },
            icon: const Icon(Icons.insert_drive_file_rounded),
          ),
        ],
      ),
      body: model.categories.isEmpty
          ? const Center(child: Text('No data'))
          : GridView.builder(
              itemCount: model.categories.length,
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2.1,
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemBuilder: (context, index) {
                int categoryId = model.categories[index].id!;

                String valueString = model.categories[index].color!
                    .split('(0x')[1]
                    .split(')')[0]; // kind of hacky..
                int value = int.parse(valueString, radix: 16);
                Color otherColor = Color(value);

                return GestureDetector(
                  onLongPress: () {
                    print('long');
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Delete category'),
                            content: const Text(
                                'Do you really want to delete this category?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  model.deleteData(categoryId);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Muvaffaqiyatli o\'chirildi'),
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          );
                        });
                  },
                  onTap: () {
                    print('id: $categoryId');
                    print('categories: ${model.categories.length}');

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewDataPage(id: categoryId),
                    ));
                  },
                  child: Card(
                    color: otherColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            model.categories[index].name!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const InputInfoPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
