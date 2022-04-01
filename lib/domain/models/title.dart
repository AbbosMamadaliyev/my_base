class TitleModel {
  int? id;
  final int category_id;
  final String title;

  static const String tableName = 'title';

  TitleModel({
    required this.id,
    required this.category_id,
    required this.title,
  });

  TitleModel.add({
    required this.category_id,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'category_id': this.category_id,
      'title': this.title,
    };
  }

  factory TitleModel.fromMap(Map<String, dynamic> map) {
    return TitleModel(
      id: map['id'] as int,
      category_id: map['category_id'] as int,
      title: map['title'] as String,
    );
  }
}
