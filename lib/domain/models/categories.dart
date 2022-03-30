class Category {
  final int? id;
  final String? name;
  final String? color;

  static const String tableName = 'categories';

  const Category({
    this.id,
    required this.name,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'color': this.color,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      name: map['name'] as String,
      color: map['color'] as String?,
    );
  }
}
