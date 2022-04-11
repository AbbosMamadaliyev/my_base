import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:mime/mime.dart';
import 'package:my_base/domain/dataproviders/local_dataprovider.dart';
import 'package:my_base/domain/models/files.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AllFilesPageModel extends ChangeNotifier {
  final _dbRepository = LocalDataRepository();
  FilePickerResult? result;
  File? file;
  String errorText = '';

  final List<FileModel> _files = [];

  List<FileModel> get files => _files;

  void selectFile() async {
    // app path
    final appDocDir = await getApplicationDocumentsDirectory();

    result = await FilePicker.platform.pickFiles();
    final path = result?.files.single.path;

    // yangi pathga copy qilyabdi
    final fileName = path!.split('/').last;
    final newPath = '${appDocDir.path}/$fileName';
    final file = File(path);
    file.copy(newPath);
    print('new path: ---- ${file.path}');

    print('old path: $path');
    _addFile(path);
  }

  void appPath() async {}

  void _addFile(String? path) {
    final fileModel = FileModel.add(path: path);

    _dbRepository.addFile(fileModel).then((value) => print('value: $value'));
  }

  void getAllFiles() {
    _dbRepository.getAllFiles().then((value) {
      _files.clear();
      _files.addAll(value);
      notifyListeners();
    });
  }

  Widget body = Container();

  void sendFile(int index) async {
    var path = _files[index].path;

    print('path: $path');

    print(lookupMimeType(path!)?.split('/').last);
    print(lookupMimeType(path));

    final format = lookupMimeType(path)?.split('/').last;

    switch (format) {
      case 'jpg':
      case 'jpeg':
      case 'png':
        file = File(path);
        body = Image.file(file!);
        errorText = '';
        notifyListeners();
        break;
      case 'msword':
      case 'docx':
        errorText = 'ochishda xatolik! format qollab quvvatlanmadi.';
        // file = File(path);
        // errorText = '';
        notifyListeners();
        break;
      case 'msexcel':
        errorText = 'ochishda xatolik! format qollab quvvatlanmadi.';

        // file = File(path);
        // errorText = '';
        notifyListeners();
        break;
      case 'pdf':
        file = File(path);
        body = SfPdfViewer.file(file!);
        errorText = '';
        notifyListeners();
        break;
      default:
        errorText = 'ochishda xatolik! format qollab quvvatlanmadi.';
        notifyListeners();
    }
  }

  void encryptData(int index) {
    var path = _files[index].path;

    // final res = EncryptData.encrypt_file(path!);
  }

  void decryptData(int index) {
    var path = _files[index].path;

    print('path: $path');

    final plainText = path;
    // final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);

    // final encrypter = Encrypter(AES(key));

    // final encrypted = encrypter.encrypt(plainText!, iv: iv);
    // final decrypted = encrypter.decrypt(encrypted, iv: iv);

    // EncryptData.decrypt_file(path!);
  }

  void deleteFile(int id) {
    _dbRepository.deleteFile(id);
  }
}
