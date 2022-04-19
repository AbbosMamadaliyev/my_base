import 'dart:io';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_base/domain/dataproviders/local_dataprovider.dart';
import 'package:my_base/domain/models/files.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AllFilesPageModel extends ChangeNotifier {
  final _dbRepository = LocalDataRepository();
  Widget body = Container();
  FilePickerResult? result;
  File? file;
  String fileName = '';
  String errorText = '';
  bool isGranted = true;

  final List<FileModel> _files = [];

  List<FileModel> get files => _files;

  void selectFile() async {
    result = await FilePicker.platform.pickFiles();
    final path = result?.files.single.path;

    if (path == null) return;

    fileName = path.split('/').last;

    encryptMethod(path, fileName);
  }

  void encryptMethod(String filepath, String fileName) async {
    if (isGranted) {
      Directory d = await getExternalVisibleDir;

      _downloadAndCreate(filepath, d, fileName);
    } else {
      print('not permission');
      requestStoragePermission();
    }
  }

  _downloadAndCreate(String filePath, Directory d, String fileName) async {
    final oldFile = File(filePath);

    final fileNameWithPath = d.path + '/$fileName.aes';
    await _writeData(await oldFile.readAsBytes(), fileNameWithPath);

    /// add path to sql base
    _addFilePathToSql(fileNameWithPath);
  }

  getNormalFile(Directory d, String fileName) async {
    final encData = await _readDataAsBytes(d.path + '/$fileName.aes');

    String p = await _writeData(encData, d.path + '/$fileName');
    print('file decrypted ok : $p');
  }

  Future<Uint8List> _readDataAsBytes(fileNameWithPath) async {
    final f = File(fileNameWithPath);
    return await f.readAsBytes();
  }

  _writeData(List<int> dataToWrite, fileNameWithPath) async {
    final f = File(fileNameWithPath);
    await f.writeAsBytes(dataToWrite);
    return f.absolute.toString();
  }

  void decryptMethod(String fileName) async {
    if (isGranted) {
      Directory d = await getExternalVisibleDir;

      getNormalFile(d, fileName);
    } else {
      print('not permission');
      requestStoragePermission();
    }
  }

  void _addFilePathToSql(String? path) {
    final fileModel = FileModel.add(path: path);

    _dbRepository.addFile(fileModel);
  }

  void getAllFiles() {
    _dbRepository.getAllFiles().then((value) {
      _files.clear();
      _files.addAll(value);
      notifyListeners();
    });
  }

  void viewMyFile(int index) async {
    var path = _files[index].path;
    print('path: $path');
    print('index: $index');

    // print(await getApplicationDocumentsDirectory());
    // print(await getApplicationSupportDirectory());
    // print(await getExternalStorageDirectory());
    // print(await getTemporaryDirectory());
    // print(await getDatabasesPath());

    final fName = path!.split('/').last.split('.').getRange(0, 2).join('.');

    final format = fName.split('.').last;

    switch (format) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
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

  IconData checkIcon(int index) {
    IconData icon;
    final format =
        _files[index].path!.split('/').last.split('.').getRange(0, 2).last;

    switch (format) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        icon = Icons.photo;
        break;
      case 'msword':
      case 'docx':
        icon = Icons.insert_drive_file;
        break;
      case 'msexcel':
        icon = Icons.insert_drive_file;
        break;
      case 'pdf':
        icon = Icons.picture_as_pdf;
        break;
      default:
        icon = Icons.insert_drive_file;
    }

    return icon;
  }

  Future get getAppDir async {
    final appDocDir = await getExternalStorageDirectory();
    return appDocDir;
  }

  Future get getExternalVisibleDir async {
    if (await Directory('/storage/emulated/0/MyEncFolder').exists()) {
      final externalDir = Directory('/storage/emulated/0/MyEncFolder');
      return externalDir;
    } else {
      await Directory('/storage/emulated/0/MyEncFolder')
          .create(recursive: true);
      final externalDir = Directory('/storage/emulated/0/MyEncFolder');
      return externalDir;
    }
  }

  requestStoragePermission() async {
    if (!await Permission.storage.isGranted) {
      PermissionStatus result = await Permission.storage.request();
      if (result.isGranted) {
        isGranted = true;
        notifyListeners();
      } else {
        isGranted = false;
      }
    }
  }

  void deleteFileOnDb(int id, int index) {
    _dbRepository.deleteFile(id);
    _deleteFileOnDir(index);
  }

  void _deleteFileOnDir(int index) async {
    var path = _files[index].path;

    final file = File(path!);
    await file.delete().then((value) {
      print('delted file');
    });
  }
}

class MyEncryptKey {
  static final key = enc.Key.fromUtf8('my 32 length key................');

  static final encrypter = enc.Encrypter(enc.AES(key));
  static final iv = enc.IV.fromLength(16);
}
