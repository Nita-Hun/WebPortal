

class User {
  final int id;
  final String username;
  final String email;
  final String password;
  final String role;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.role,
  });

  // Factory method to create a User object from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'role': role,
    };
  }
}
