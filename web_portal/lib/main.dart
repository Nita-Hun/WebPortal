import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_portal/front_screen/sign_in.dart';
import 'package:web_portal/front_screen/sign_up.dart';
import 'package:web_portal/front_screen/test_screen.dart';
import 'package:web_portal/providers/test_provider.dart';
import 'package:web_portal/screens/admin_panel.dart';
import 'package:web_portal/screens/auth_screen.dart';
import 'package:web_portal/screens/home_screen.dart';
import 'package:web_portal/screens/login_screen1.dart';
import 'package:web_portal/screens/register_screen.dart';
import 'package:web_portal/test_editor/view_test_screen.dart';




void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TestProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'Web Portal',
      home: const HomeScreen (),
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/', 
      routes: {
        //'/': (context) => const SplashScreen(),
        '/sign_up': (context) => const SignUp(title: "Sign Up",),
        '/sign_in': (context) => const SignIn(title: "Sign In"),
        '/test_screen': (context) => const TestManagementScreen(),
        '/view_test_screen': (context) => const ViewTestsScreen(),
        '/authenication': (context) => const AuthenticationScreen(), 
        '/login': (context) => const LoginScreen(),
        '/admin_panel': (context) => const AdminPanel(),
        '/home_screen': (context) => const HomeScreen(),
        '/register_screen': (context) => const RegistrationScreen(),
        '/login_screen1': (context) => const LoginScreen(),
        //'/create_test': (context) => const CreateTestScreen(),
        '/view_test': (context) => const ViewTestsScreen(),
        //'/edit_test': (context) => const EditTestScreen(),

        
        
      },
    );
  }
}