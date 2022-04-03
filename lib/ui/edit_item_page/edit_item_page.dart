import 'package:flutter/material.dart';
import 'package:my_base/domain/models/credentials.dart';
import 'package:my_base/domain/models/title.dart';
import 'package:my_base/ui/edit_item_page/edit_item_page_model.dart';
import 'package:provider/provider.dart';

class EditItemPage extends StatefulWidget {
  const EditItemPage({Key? key}) : super(key: key);

  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  final titleController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<EditItemPageModel>();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    Credentials credential = args['credential'];
    TitleModel titleModel = args['titleModel'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            /* showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('O\'zgarishlarni saqlash'),
                    actions: [
                      IconButton(onPressed: (){}, icon: Icon())
                    ],
                  );
                });*/
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: titleController..text = titleModel.title,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: usernameController..text = credential.username ?? '',
              decoration: const InputDecoration(
                labelText: 'Username',
                hintText: 'username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController..text = credential.password ?? '',
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final username = usernameController.text;
                final password = passwordController.text;

                if (titleController.text.isEmpty) {
                  const snackBar = SnackBar(
                    content: Text('Title bo\'sh bo\'lishi mumkin emas!'),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }

                final newTitleModel = TitleModel(
                    id: titleModel.id,
                    category_id: titleModel.category_id,
                    title: title);

                final newCredentials = Credentials(
                    id: credential.id,
                    category_id: credential.category_id,
                    username: username,
                    password: password);

                model.editItem(newTitleModel, newCredentials);

                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
