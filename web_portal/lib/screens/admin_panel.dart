import 'package:flutter/material.dart';

class AdminPanel extends StatelessWidget {
  static String routeName ='/admin_panel';

  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web Partal for Testing'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/test_editor_screen'); 
              },
              child: const Text('Take Test'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/view_results_screen'); 
              },
              child: const Text('Add Question'),
            ),
          ],
        ),
      ),
    );
  }
}