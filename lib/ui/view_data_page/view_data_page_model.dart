import 'package:flutter/cupertino.dart';
import 'package:my_base/domain/dataproviders/local_dataprovider.dart';

class ViewDataPageModel extends ChangeNotifier {
  final _db = LocalDataRepository();

  void deleteItem(int id) {
    _db.deleteTitle(id);
    _db.deleteCredentials(id);
  }

  void editItem() {}
}
