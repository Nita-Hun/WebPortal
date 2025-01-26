import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_portal/screens/admin_panel.dart';
import 'package:web_portal/screens/home_screen.dart';
import 'package:web_portal/utils/constains.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';

  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController =TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final String username = usernameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (username.isEmpty || email.isEmpty ||password.isEmpty) {
      showError("Please fill in all fields.");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/login'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"username": username,"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final String role = data['role'];
        final String token = data['token'];

        // Save role and token locally
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('role', role);
        await prefs.setString('token', token);

        // Navigate to the appropriate homepage using a separate method
        await _navigateToHomepage(role);
      } else {
        showError("Invalid credentials.");
      }
    } catch (error) {
      showError("An error occurred: $error");
    }
  }

  void showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // New method to handle navigation without BuildContext
  Future<void> _navigateToHomepage(String role) async {
    if (role == "ADMIN") {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminPanel()),
      );
    } else {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left section (Login form)
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B3948),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Enter your account details',
                    style: TextStyle(color: Color(0xFF0B3948)),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Color(0xFF0B3948)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF0B3948)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF0B3948)),
                      ),
                      suffixIcon: Icon(Icons.visibility, color: Color(0xFF0B3948)),
                    ),
                    style: TextStyle(color: Color(0xFF0B3948)),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Color(0xFF0B3948)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF0B3948)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF0B3948)),
                      ),
                      suffixIcon: Icon(Icons.visibility, color: Color(0xFF0B3948)),
                    ),
                    style: TextStyle(color: Color(0xFF0B3948)),
                  ),

                  const SizedBox(height: 16),
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Color(0xFF0B3948)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF0B3948)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF0B3948)),
                      ),
                      suffixIcon: Icon(Icons.visibility, color: Color(0xFF0B3948)),
                    ),
                    style: TextStyle(color: Color(0xFF0B3948)),
                  ),

                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Color(0xFF0B3948)),
                    ),
                  ),
                   const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(onPressed: login, 
                      child: const Text("login"))
                    
                   ),
                    
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register_screen');
                      },
                      child: const Text(
                        "Don't have an account? Register",
                        style: TextStyle(color: Color(0xFF0B3948)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right section (Welcome message)
          Expanded(
            flex: 2,
            child: Container(
              color: const Color(0xFF0B3948),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome to',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Web Portal for TEST',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Login to access your account',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 32),
                    Image.asset(
                      'assets/images/cyber.png', // Add your illustration here
                      height: 200,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}