import 'package:flutter/material.dart';
import 'package:web_portal/screens/login_screen1.dart';


import '../screens/register_screen.dart';

class AuthenticationScreen extends StatelessWidget {
  static const routeName = '/authentication';

  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text ('Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RegistrationScreen.routeName);
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}