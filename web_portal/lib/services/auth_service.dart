import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_portal/models/user_model.dart';
import 'package:web_portal/utils/constains.dart';



class AuthService { 
  static const String _jwtKey = 'jwt_token';
  static const String _secretKey = ''; 

  /// Login API with role and email as optional parameters
  /// 
  Future<User?> registerUser(String username, String email, String password) async {
    const url = '$apiBaseUrl/register';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password, 
        }),
      );

      if (response.statusCode == 201) {
        final userData = jsonDecode(response.body);
        return User.fromJson(userData);
      } else {
        throw Exception('Registration failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }
  Future<User?> loginUser(String emailOrUsername, String password) async {
    const url = '$apiBaseUrl/login';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'emailOrUsername': emailOrUsername,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        final user = User.fromJson(userData);

        final claims = {
          'userId': user.id,
          'role': user.role,
          'exp': DateTime.now().add(const Duration(hours: 24)).millisecondsSinceEpoch ~/ 1000, 
        };
        final jwt = JWT(claims).sign(SecretKey(_secretKey)); 

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_jwtKey, jwt); 

        return user; 
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_jwtKey); 
  }

  Future<String?> getJwt() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_jwtKey);
  }
}