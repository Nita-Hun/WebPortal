import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:web_portal/models/question_model.dart';
import 'package:web_portal/models/test_model.dart';
import 'package:web_portal/models/test_result.dart';
import 'package:web_portal/utils/constains.dart';

class TestProvider with ChangeNotifier {
  List<Test> _tests = []; // Local list of tests

  List<Test> get tests => [..._tests]; // Return a copy of the test list

  // Fetch tests from the API
  Future<void> fetchTests() async {
    const url = '$apiBaseUrl/tests'; // Replace with your actual API endpoint

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        _tests = responseData.map((testJson) => Test.fromJson(testJson)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to fetch tests: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Network error occurred: $error');
    }
  }

  // Create a new test
  Future<void> createTest(String name, String description, List<Question> questions) async {
    const url = '$apiBaseUrl/tests'; // Replace with your actual API endpoint

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'description': description,
          'questions': questions.map((question) => question.toJson()).toList(),
        }),
      );

      if (response.statusCode == 201) {
        await fetchTests(); // Fetch updated tests list after successful creation
      } else {
        throw Exception('Failed to create test: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Network error occurred: $error');
    }
  }

  // Save test result
  Future<void> saveTestResult(TestResult testResult) async {
    const url = '$apiBaseUrl/test_results'; // Replace with your actual API endpoint

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(testResult.toJson()),
      );

      if (response.statusCode == 201) {
        // Optionally handle success (e.g., notify user)
        debugPrint('Test result saved successfully');
      } else {
        throw Exception('Failed to save test result: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Network error occurred: $error');
    }
  }

  // Update an existing test
  Future<void> updateTest(Test test) async {
    final url = '$apiBaseUrl/tests/${test.id}'; // Replace with your actual API endpoint

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(test.toJson()),
      );

      if (response.statusCode == 200) {
        // Update local list of tests
        final index = _tests.indexWhere((t) => t.id == test.id);
        if (index >= 0) {
          _tests[index] = test;
          notifyListeners();
        }
      } else {
        throw Exception('Failed to update test: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error updating test: $error');
    }
  }

  // Delete a test
  Future<void> deleteTest(int testId) async {
    final url = '$apiBaseUrl/tests/$testId'; // Replace with your actual API endpoint

    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        // Remove test from local list
        _tests.removeWhere((test) => test.id == testId);
        notifyListeners();
      } else {
        throw Exception('Failed to delete test: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Network error occurred: $error');
    }
  }
}
