import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:mime/mime.dart';
import 'package:my_base/domain/dataproviders/local_dataprovider.dart';
import 'package:my_base/domain/models/files.dart';
import 'package:path_provider/path_provider.dart';

class AllFilesPageModel extends ChangeNotifier {
  final _dbRepository = LocalDataRepository();
  FilePickerResult? result;
  File? file;

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

  String errorText = '';

  void sendFile(int index) async {
    var path = _files[index].path;

    print('path: $path');

    print(lookupMimeType(path!)?.split('/').last);

    final fileName = path.split('/').last;
    final format = fileName.substring(fileName.length - 3, fileName.length);

    if (format != 'pdf') {
      errorText = 'ochishda xatolik! format qollab quvvatlanmadi.';
      notifyListeners();
    } else {
      file = File(path);
      errorText = '';
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
