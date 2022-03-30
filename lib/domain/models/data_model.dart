class DataModel {
  int? id;
  final String category_name;
  final String? username;
  final String? password;
  final String? filePath;
  final String? color;
  final String title;

  static const String tableName = 'data';

  DataModel({
    required this.id,
    required this.category_name,
    required this.username,
    required this.password,
    required this.filePath,
    required this.color,
    required this.title,
  });

  DataModel.add({
    required this.category_name,
    required this.username,
    required this.password,
    required this.color,
    required this.filePath,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'category_name': this.category_name,
      'username': this.username,
      'password': this.password,
      'color': this.color,
      'filePath': this.filePath,
      'title': this.title,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      id: map['id'] as int,
      category_name: map['category_name'] as String,
      username: map['username'] as String,
      color: map['color'] as String,
      password: map['password'] as String,
      filePath: map['filePath'] as String,
      title: map['title'] as String,
    );
  }
}
