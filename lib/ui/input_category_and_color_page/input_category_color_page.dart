import 'package:flutter/material.dart';
import 'package:my_base/ui/input_data_page/input_data_page_model.dart';
import 'package:provider/provider.dart';

class InputCategoryPage extends StatefulWidget {
  const InputCategoryPage({Key? key}) : super(key: key);

  @override
  _InputCategoryPageState createState() => _InputCategoryPageState();
}

class _InputCategoryPageState extends State<InputCategoryPage> {
  final categoryController = TextEditingController();

  int selectIndex = 2;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<InputDataPageModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter category name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('category name'),
            const SizedBox(height: 8),
            TextField(
              controller: categoryController,
              autofocus: true,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 24),
            GridView.builder(
                shrinkWrap: true,
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  childAspectRatio: 2,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print('color: ${colors[index].toString()}');
                      setState(() {
                        selectIndex = index;
                      });
                    },
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: colors[index],
                      child: Icon(
                        Icons.done,
                        color: selectIndex == index
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                  );
                }),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                final color = colors[selectIndex];

                context
                    .read<InputDataPageModel>()
                    .addCategory(color, categoryController.text, context);

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    model.errorText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  backgroundColor: Colors.black87,
                ));
              },
              child: const Text('add'),
            ),
          ],
        ),
      ),
    );
  }
}
// demo

List<Color> colors = [
  Color(0xffb85430),
  Color(0xff9c2013),
  Color(0xffad0505),
  Color(0xffdc3db4),
  Color(0xffa67c1c),
  Color(0xff6e6a0a),
  Color(0xff41610f),
  Color(0xff1a7817),
  Color(0xff0c752f),
  Color(0xff04615e),
  Color(0xff14b3b3),
  Color(0xff2d0e75),
  Color(0xff4707de),
  Color(0xff361f6e),
  Color(0xffdc3db4),
  Color(0xff5e0954),
  Color(0xff5e0530),
  Color(0xff29b684),
  Color(0xff093769),
  Color(0xff29b684),
];
