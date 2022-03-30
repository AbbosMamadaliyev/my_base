class DataModel {
  int? id;
  final int category_id;
  final String? username;
  final String? password;
  final String? filePath;
  final String title;

  static const String tableName = 'data';

  DataModel({
    required this.id,
    required this.category_id,
    required this.username,
    required this.password,
    required this.filePath,
    required this.title,
  });

  DataModel.add({
    required this.category_id,
    required this.username,
    required this.password,
    required this.filePath,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'category_id': this.category_id,
      'username': this.username,
      'password': this.password,
      'filePath': this.filePath,
      'title': this.title,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      id: map['id'] as int,
      category_id: map['category_id'] as int,
      username: map['username'] as String,
      password: map['password'] as String,
      filePath: map['filePath'] as String,
      title: map['title'] as String,
    );
  }
}
