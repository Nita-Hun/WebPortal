import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_portal/models/answer_model.dart';
import 'package:web_portal/models/test_result.dart';
import 'package:web_portal/models/user_model.dart';
import 'package:web_portal/providers/auth_provider.dart';
import 'package:web_portal/test_system/view_result_screen.dart';

// Import your models

import '../models/question_model.dart';
import '../models/test_model.dart';
 // Assuming TestResult model name

// Import your provider
import '../providers/test_provider.dart';

class TakeTestScreen extends StatefulWidget {
  static const routeName = '/take_test';

  const TakeTestScreen({super.key, required this.test});

  final Test test;
  

  @override
  TakeTestScreenState createState() => TakeTestScreenState();
}

class TakeTestScreenState extends State<TakeTestScreen> {
  int _currentQuestionIndex = 0;
  final Map<int, int> _selectedAnswers = {}; // Map question index to selected answer ID

  @override
  Widget build(BuildContext context) {
    final test = widget.test;
    final currentQuestion = test.questions[_currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('Taking Test: ${test.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Question ${_currentQuestionIndex + 1} of ${test.questions.length}'),
            // Display question text
            Text(currentQuestion.questionText),
            // Display answer options with RadioButtons
            _buildAnswerOptions(currentQuestion),
            ElevatedButton(
              onPressed: () {
                // Handle next question logic
                if (_currentQuestionIndex < test.questions.length - 1) {
                  setState(() {
                    _currentQuestionIndex++;
                  });
                } else {
                  // Submit test results
                  _submitTestResults(context, test);
                }
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerOptions(Question question) {
    return Column(
      children: question.answers!.map((answer) => _buildRadioListTile(answer)).toList(),
    );
  }

  Widget _buildRadioListTile(Answer answer) {
    return RadioListTile<int>(
      title: Text(answer.answerText),
      value: answer.id,
      groupValue: _selectedAnswers[_currentQuestionIndex],
      onChanged: (value) => setState(() => _selectedAnswers[_currentQuestionIndex] = value!),
    );
  }

  Future<void> _submitTestResults(BuildContext context, Test test) async {
    // Calculate test score based on selected answers and question weights
    double score = 0;
    for (int i = 0; i < test.questions.length; i++) {
      final question = test.questions[i];
      final selectedAnswerId = _selectedAnswers[i];
      if (selectedAnswerId != null && question.answers!.any((answer) => answer.id == selectedAnswerId && answer.isCorrect)) {
        // Assuming correctAnswerIds is a list of correct answer IDs
        score += question.weight;
      }
    }
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final User? user = authProvider.user;
    if(user == null){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login first')),
      );
      return;
    }
    final navigator = Navigator.of(context);
    // Create TestResult object
    final testResult = TestResult(
      id: 0,
      user: user,
      test: test,
      score: score,
      // Add other relevant fields like user ID, timestamp, etc.
    );
    
    // Save test result to database (using TestProvider)
    final testProvider = Provider.of<TestProvider>(context, listen: false);
    await testProvider.saveTestResult(testResult);

    // Navigate to ViewResultsScreen
    if(mounted){
      navigator.pushReplacementNamed(
      ViewResultsScreen.routeName,
      arguments: test,
    );
    
    }
      
    
  }
}