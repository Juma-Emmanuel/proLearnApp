class User {
  final int id;
  final String first_name;
  final String last_name;
  final String email;

  const User({
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.id,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      first_name: json['first_name'] ?? '',
      last_name: json['last_name'] ?? '',
    );
  }
}
