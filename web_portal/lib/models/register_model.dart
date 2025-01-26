class Register {
  final String username;
  final String email;
  final String password;


  Register({
    required this.username,
    required this.email,
    required this.password,

  });

  // Factory method to create a Register object from JSON
  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      username: json['username'],
      email: json['email'],
      password: json['password'],

    );
  }

  // Convert Register object to JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
