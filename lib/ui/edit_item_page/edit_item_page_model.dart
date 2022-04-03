import 'package:flutter/cupertino.dart';
import 'package:my_base/domain/dataproviders/local_dataprovider.dart';
import 'package:my_base/domain/models/credentials.dart';
import 'package:my_base/domain/models/title.dart';

class EditItemPageModel extends ChangeNotifier {
  final _dbRepository = LocalDataRepository();

  void editItem(TitleModel titleModel, Credentials credentials) {
    _dbRepository.updateTitle(titleModel);
    _dbRepository.updateCredentials(credentials);
  }
}
