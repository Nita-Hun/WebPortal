import 'package:flutter/material.dart';
import 'package:web_portal/models/test_model.dart';


class ViewResultsScreen extends StatelessWidget {
  static const routeName = '/view_results';

  const ViewResultsScreen({super.key, required this.test});

  final Test test;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Test: ${test.name}'),
            Text('Your Score: ${test.questions}'),
            // Display more detailed results (e.g., correct/incorrect answers) 
          ],
        ),
      ),
    );
  }
}