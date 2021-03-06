import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_base/ui/view_data_page/widgets/password_data_widget.dart';
import 'package:my_base/ui/view_data_page/widgets/title_data_widget.dart';
import 'package:my_base/ui/view_data_page/widgets/username_data_widget.dart';
import 'package:provider/provider.dart';

import '../home_page/home_page_model.dart';

/*class ViewDataPage extends StatefulWidget {
  final int id;

  const ViewDataPage({Key? key, required this.id}) : super(key: key);

  @override
  _ViewDataPageState createState() => _ViewDataPageState();
}*/

class ViewDataPage extends StatefulWidget {
  final int id;
  const ViewDataPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ViewDataPage> createState() => _ViewDataPageState();
}

class _ViewDataPageState extends State<ViewDataPage> {
  @override
  void didChangeDependencies() {
    context.watch<HomePageModel>().getDataByCategoryId(widget.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomePageModel>();
    final titles = model.titles;

    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
      ),
      body: FutureBuilder(builder: (context, snapshot) {
        return ListView.builder(
            itemCount: titles.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleDataWidget(index: index),
                      UsernameDataWidget(index: index),
                      PasswordDataWidget(index: index, length: titles.length),
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}
