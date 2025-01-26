
import 'package:web_portal/models/test_model.dart';
import 'package:web_portal/models/user_model.dart';

// Import other relevant models (e.g., User, Test)

class TestResult {
  final int id;
  final User user; // Assuming you have a User model
  final Test test; // Assuming you have a Test model
  final double score;

  TestResult({
    required this.id,
    required this.user,
    required this.test,
    required this.score,
  });

  // Factory constructor to create a TestResult object from a Map (for potential JSON parsing)
  factory TestResult.fromJson(Map<String, dynamic> json) {
    return TestResult(
      id: json['id'],
      user: User.fromJson(json['user']), // Assuming User model has a fromJson method
      test: Test.fromJson(json['test']), // Assuming Test model has a fromJson method
      score: json['score'] as double,
    );
  }

  // Convert TestResult object to a Map (for potential JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(), // Assuming User model has a toJson method
      'test': test.toJson(), // Assuming Test model has a toJson method
      'score': score,
    };
  }
}