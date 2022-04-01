class Credentials {
  int? id;
  final int category_id;
  final String? username;
  final String? password;
  bool? isVisibility;

  static const String tableName = 'credentials';

  Credentials({
    required this.id,
    required this.category_id,
    this.username,
    this.password,
    this.isVisibility = false,
  });

  Credentials.add({
    required this.category_id,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'category_id': this.category_id,
      'username': this.username,
      'password': this.password,
    };
  }

  factory Credentials.fromMap(Map<String, dynamic> map) {
    return Credentials(
      id: map['id'] as int,
      category_id: map['category_id'] as int,
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }
}
