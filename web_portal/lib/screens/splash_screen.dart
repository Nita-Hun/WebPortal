import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_portal/screens/login_screen1.dart';

import '../providers/auth_provider.dart';
import '../screens/admin_panel.dart';
import '../screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthProvider _authProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate loading

    if (_authProvider.isAuthenticated) {
      // Determine user role and navigate accordingly
      if (_authProvider.userRole == 'admin') {
        if(mounted){
          Navigator.pushReplacementNamed(context, AdminPanel.routeName);
        }
        
      } else {
        if (mounted){
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
        
      }
    } else {
      if(mounted){
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}