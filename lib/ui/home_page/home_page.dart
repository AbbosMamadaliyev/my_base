import 'package:flutter/material.dart';
import 'package:my_base/ui/home_page/home_page_model.dart';
import 'package:my_base/ui/input_data_page/input_data_page.dart';
import 'package:my_base/ui/view_data_page/view_data_page.dart';
import 'package:provider/provider.dart';

import '../input_data_page/input_data_page_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> items = [
    'Bank va gos. organ',
    'Ish',
    'Universitet',
    'Ijtimoiy tarmoqlar',
    'Dastur va ilovalar',
    'Kategoriyasiz',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<HomePageModel>().getAllData();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomePageModel>();

    final allData = model.allData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('my informations'),
      ),
      body: GridView.builder(
          itemCount: allData.length,
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2.1,
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemBuilder: (context, index) {
            // model.setCategoryId(index);
            // Color color = model.categories[index].color as Color;

            final data = allData[index];

            String valueString =
                data.color!.split('(0x')[1].split(')')[0]; // kind of hacky..
            int value = int.parse(valueString, radix: 16);
            Color otherColor = new Color(value);

            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                        create: (BuildContext context) => HomePageModel(),
                        child: ViewDataPage(index: index)),
                  ),
                );
              },
              child: Card(
                color: otherColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        // items[index],
                        data.category_name,
                        style: const TextStyle(
                            // color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      /* Text(
                        'count: ${datas[index].title}',
                        style: const TextStyle(color: Colors.white),
                      ),*/
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  create: (BuildContext context) => InputDataPageModel(),
                  child: const InputInfoPage())));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Color> colors = [
    Color(0xff14b3b3),
    Color(0xff1914b3),
    Color(0xff9614b3),
    Color(0xffdc3db4),
    Color(0xff2c871c),
    Color(0xff29b684),
  ];
}
