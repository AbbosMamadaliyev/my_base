class Files {
  final int id;
  final int title_id;
  final String path;

  const Files({
    required this.id,
    required this.title_id,
    required this.path,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title_id': this.title_id,
      'path': this.path,
    };
  }

  factory Files.fromMap(Map<String, dynamic> map) {
    return Files(
      id: map['id'] as int,
      title_id: map['title_id'] as int,
      path: map['path'] as String,
    );
  }
}
