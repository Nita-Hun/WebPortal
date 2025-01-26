import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_portal/models/user_model.dart';
import 'package:web_portal/utils/constains.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _userId;
  String? _userRole;
  User? _user;

  bool get isAuthenticated {
    return _token != null;
  }
  User? get user => _user;

  String? get token {
    return _token;
  }

  String? get userId {
    return _userId;
  }

  String? get userRole {
    return _userRole; 
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse('$apiBaseUrl/login'); 
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      _token = responseData['token'];
      _userId = responseData['userId'];
      _userRole = responseData['role']; // Assuming 'role' is the key for user role in the response
      notifyListeners();
    } else {
      // Handle login error (e.g., display an error message)
      throw Exception('Failed to login');
    }
  }

  Future<void> register(String username, String email, String password) async {
    // ... (Your existing registration logic)
    final url = Uri.parse('$apiBaseUrl/register'); // Replace with your actual API endpoint
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      // Handle successful registration (e.g., navigate to login screen)
      // You can also store the user's role if it's returned in the response
      final responseData = jsonDecode(response.body);
      _token = responseData['token'];
      _userId = responseData['userId'];
      _userRole = responseData['role']; // Assuming 'role' is the key for user role in the response
      notifyListeners();
    } else {
      // Handle registration error (e.g., display an error message)
      throw Exception('Failed to register');
    }
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _userRole = null; 
    notifyListeners();
  }

  Future<String?> getUserRole() async {
    // If userRole is already available, return it directly
    if (_userRole != null) {
      return _userRole;
    }

    // Fetch user role from the API (if required)
    // Example:
    if (_token == null || _userId == null) {
      return null; 
    }

    final url = Uri.parse('$apiBaseUrl/user/$_userId'); 
    final response = await http.get(
      url, 
      headers: {'Authorization': 'Bearer $_token'} 
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body); 
      _userRole = responseData['role']; 
      notifyListeners(); 
    } else {
      // Handle API error (e.g., display an error message)
      throw Exception('Failed to fetch user role');
    }

    return _userRole;
  }
}