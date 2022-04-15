import 'dart:io';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
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

    fileName = path!.split('/').last;
    notifyListeners();

    // encryptData(path);
    encryptMethod(path);

    // moveFile(path, fileName);
  }

  void encryptMethod(String filepath) async {
    if (isGranted) {
      Directory d = await getExternalVisibleDir;

      downloadAndCreate(filepath, d, fileName);
    } else {
      print('not permission');
      requestStoragePermission();
    }
  }

  downloadAndCreate(String filePath, Directory d, String fileName) async {
    final oldFile = File(filePath);
    // var encResult = _encryptData(await oldFile.readAsBytes());

    final fileNameWithPath = d.path + '/$fileName.aes';
    String p = await _writeData(await oldFile.readAsBytes(), fileNameWithPath);

    /// add path to sql base
    _addFilePathToSql(fileNameWithPath);

    print('encrypted path: $p');
  }

  ///
  void moveFile(String filePath, String fileName) async {
    Directory d = await getExternalVisibleDir;
    final fileNameWithPath = d.path + '/$fileName';

    final oldFile = File(filePath);

    final f = File(fileNameWithPath);
    await f.writeAsBytes((await oldFile.readAsBytes()));
  }

  ///

  enc.Encrypted _encryptData(plainString) {
    final encrypted =
        MyEncryptKey.encrypter.encryptBytes(plainString, iv: MyEncryptKey.iv);
    return encrypted;
  }

  String _decryptData(Uint8List encData) {
    final en = enc.Encrypted(encData);

    final decrypted = MyEncryptKey.encrypter.decrypt(en, iv: MyEncryptKey.iv);
    return decrypted;
  }

  getNormalFile(Directory d, String fileName) async {
    final encData = await _readDataAsBytes(d.path + '/$fileName.aes');
    // final newFile = File();
    // var plainData = _decryptData(encData);
    // print('das: ${plainData}');
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

    final fName = path!.split('/').last.split('.').getRange(0, 2).join('.');

    // print(lookupMimeType(path!)?.split('/').last);
    // print(lookupMimeType(path));

    // decryptMethod(fName);

    final format = fName.split('.').last;
    print('format: $format');

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
        // notifyListeners();
      }
    }
  }

  void deleteFile(int id) {
    _dbRepository.deleteFile(id);
  }
}

class MyEncryptKey {
  static final key = enc.Key.fromUtf8('my 32 length key................');

  static final encrypter = enc.Encrypter(enc.AES(key));
  static final iv = enc.IV.fromLength(16);
}

/*void encryptData(String path) {
    // var path = _files[index].path;

    final key = KeyZZ.fromUtf8('my 32 length key................');

    final encrypter = EncrypterZZ(AESZZ(key));
    final iv = IVZZ.fromLength(16);

    // final res = encrypter.encrypt(path);
    final encrypted = encrypter.encrypt(path, iv: iv);

    print('byts: ${encrypted.bytes}');
    print('bas64: ${encrypted.base64}');
  }

  void decryptData(int index) {
    var path = _files[index].path;

    print('path: $path');

    final plainText = path;
    final key = KeyZZ.fromUtf8('my 32 length key................');
    final iv = IVZZ.fromLength(16);

    final encrypter = EncrypterZZ(AESZZ(key));

    final encrypted = encrypter.encrypt(plainText!, iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    print('sd: $decrypted');

    // EncryptData.decrypt_file(path!);
  }
*/
