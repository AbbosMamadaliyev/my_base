class FileModel {
  int? id;
  // int category_id;
  final String? path;

  static const String tableName = 'files';

  FileModel({
    required this.id,
    // required this.category_id,
    required this.path,
  });

  FileModel.add({
    // required this.category_id,
    required this.path,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      // 'category_id': this.category_id,
      'path': this.path,
    };
  }

  factory FileModel.fromMap(Map<String, dynamic> map) {
    return FileModel(
      id: map['id'] as int,
      // category_id: map['category_id'] as int,
      path: map['path'] as String,
    );
  }
}
