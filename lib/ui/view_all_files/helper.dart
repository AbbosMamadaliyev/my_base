/*
import 'dart:io';

import 'package:aes_crypt/aes_crypt.dart';

class EncryptData {
  static String encrypt_file(String path) {
    AesCrypt crypt = AesCrypt();
    crypt.setOverwriteMode(AesCryptOwMode.on);
    crypt.setPassword('pass123');
    String encFilepath;
    try {
      encFilepath = crypt.encryptFileSync(path);
      print('The encryption has been completed successfully.');
      print('Encrypted file: $encFilepath');
    } catch (e) {
      rethrow;
    }
    return encFilepath;
  }

  static String decrypt_file(String path) {
    AesCrypt crypt = AesCrypt();
    crypt.setOverwriteMode(AesCryptOwMode.on);
    crypt.setPassword('pass123');
    String decFilepath;
    try {
      decFilepath = crypt.decryptFileSync(path);
      print('The decryption has been completed successfully.');
      print('Decrypted file 1: $decFilepath');
      print('File content: ' + File(decFilepath).path);
    } catch (e) {
      rethrow;
    }
    return decFilepath;
  }
}
*/
