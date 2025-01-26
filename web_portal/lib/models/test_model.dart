import 'package:web_portal/models/question_model.dart';

class Test {
  final int id;
  String name;
  String description;
  final List<Question> questions;

  Test({
    required this.id,
    required this.name,
    required this.description,
    required this.questions,
  });
  Test copyWith({
    int? id,
    String? name,
    String? description,
    List<Question>? questions,
  }) {
    return Test(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      questions: questions ?? List.from(this.questions), // Create a copy of the questions list
    );
  }

  // Factory method to create a Test object from JSON
  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      questions: (json['questions'] as List)
          .map((questionJson) => Question.fromJson(questionJson))
          .toList(),
    );
  }

  // Convert Test object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'questions': questions.map((question) => question.toJson()).toList(),
    };
  }
}
