
import 'package:web_portal/models/answer_model.dart';
import 'package:web_portal/models/test_model.dart';

class Question {
  final int id;
  String questionText;
  String questionType;
  double weight;
  final String? imagePath;// e.g., "multiple-choice", "single-choice"
  final List<Answer>? answers;
  final List<String> options;
  final List<int> correctAnswerIds;
  final Test test;

  Question({
    required this.id,
    required this.questionText,
    required this.questionType,
    required this.weight,
    required this.imagePath,
    required this.answers,
    required this.options,
    required this.correctAnswerIds,
    required this.test,
  });

  // Factory method to create a Question object from JSON
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      questionText: json['questionText'],
      questionType: json['questionType'],
      weight: json['weight'],
      imagePath: json['imagePath'],
      answers: json['answer'] != null? (json['answers'] as List)
          .map((answerJson) => Answer.fromJson(answerJson))
          .toList()
          :null,
      options: List<String>.from(json['options'] ?? []),
      correctAnswerIds: json['correctAnswerIds'],
      test: Test.fromJson(json['test']),
    );
    
  }

  // Convert Question object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionText': questionText,
      'questionType': questionType,
      'weight': weight,
      'imagePath': imagePath,
      'answers': answers?.map((answer) => answer.toJson()).toList(),
      'options': options,
      'correctAnswerIds': correctAnswerIds,
      'test': test,
    };
  }
}
