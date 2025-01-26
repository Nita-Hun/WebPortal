
import 'package:web_portal/models/question_model.dart';

class Answer {
  final int id;
  final String answerText;
  final Question question;
  final bool isCorrect;

  Answer({
    required this.id,
    required this.answerText,
    required this.question,
    required this.isCorrect,
  });

  // Factory method to create an Answer object from JSON
  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      answerText: json['answerText'],
      question: Question.fromJson(json['question']),
      isCorrect: json['isCorrect'],
    );
  }

  // Convert Answer object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'answerText': answerText,
      'question': question,
      'isCorrect': isCorrect,
    };
  }
}
