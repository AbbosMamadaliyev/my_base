import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../view_all_files/all_files_page_model.dart';

class AllFilesPage extends StatefulWidget {
  const AllFilesPage({Key? key}) : super(key: key);

  @override
  _AllFilesPageState createState() => _AllFilesPageState();
}

class _AllFilesPageState extends State<AllFilesPage> {
  FilePickerResult? result;
  File? file;

  @override
  void didChangeDependencies() {
    context.read<AllFilesPageModel>().getAllFiles();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AllFilesPageModel>();
    final files = model.files;

    return Scaffold(
      appBar: AppBar(
        title: const Text('my files'),
        actions: [
          IconButton(
            onPressed: model.selectFile,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: files.length,
          itemBuilder: (context, index) {
            final file = files[index];

            String? fileName;

            fileName = file.path?.split('/').last;

            return ListTile(
              onTap: () {
                model.sendFile(index);

                model.errorText.isEmpty
                    ? Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ViewFilePage()))
                    : ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(model.errorText)));
              },
              leading: const Icon(Icons.insert_drive_file),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.close),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.open_in_browser),
                  ),
                ],
              ),
              title: Text(
                fileName ?? '#####',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }),
    );
  }
}

/*
SfPdfViewer.network(
'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'),
)*/

class ExampleView extends StatelessWidget {
  ExampleView({Key? key}) : super(key: key);

  FilePickerResult? result;
  File? file;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () async {
              result = await FilePicker.platform.pickFiles();
              if (result != null) {
                file = File(result?.files.single.path ?? '');
                print(result?.files.single.path);
              } else {
                // User canceled the picker
              }
            },
            child: const Text('get file'),
          ),
          Text('file name: ${result?.names.map((e) => e)}'),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ViewFilePage()));
            },
            child: Text('view file'),
          ),
          ElevatedButton(
            onPressed: () {
              readFilesFromAssets(context);
            },
            child: Text('read file'),
          ),
        ],
      ),
    );
  }

  readFilesFromAssets(context) async {
    var assetContent = await rootBundle.load(file!.path);
    print("assetContent : $assetContent");

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Select file'),
            content: Text('file name: rrr'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Back')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save')),
            ],
          );
        });
  }
}

class ViewFilePage extends StatelessWidget {
  // final File file;

  const ViewFilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final file = context.watch<AllFilesPageModel>().file;

    return Scaffold(
      appBar: AppBar(),
      body: SfPdfViewer.file(file!),
    );
  }
}
