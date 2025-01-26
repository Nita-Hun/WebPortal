import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_portal/models/answer_model.dart';
import 'package:web_portal/models/question_model.dart';
import 'package:web_portal/models/test_model.dart';
import '../providers/test_provider.dart';

class CreateTestScreen extends StatefulWidget {
  static const routeName = '/create_test';

  const CreateTestScreen({super.key, required Test test});

  @override
  CreateTestScreenState createState() => CreateTestScreenState();
}

class CreateTestScreenState extends State<CreateTestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _testNameController = TextEditingController();
  final _testDescriptionController = TextEditingController();
  List<Question> _questions = [];

  @override
  void initState() {
    super.initState();
    _questions = []; // Initialize with an empty list of questions
  }

  void _addQuestion() {
    setState(() {
      _questions.add(Question(
        id: 0, // Placeholder for ID (backend will assign)
        questionText: '',
        questionType: 'multiple_choice', // Default question type
        weight: 1,
        imagePath: '',
        answers: [],
        options: [],
        correctAnswerIds: [],
        test: Test(
          id: 0,
          name: '',
          description: '',
          questions: [],
        ),
      ));
    });

    
  }

  void _saveTest() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final testProvider = Provider.of<TestProvider>(context, listen: false);
      await testProvider.createTest(
        _testNameController.text,
        _testDescriptionController.text,
        _questions,
      );

      // Navigate back to the test list screen
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Test Name Input
              TextFormField(
                controller: _testNameController,
                decoration: const InputDecoration(labelText: 'Test Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a test name';
                  }
                  return null;
                },
              ),
              // Test Description Input
              TextFormField(
                controller: _testDescriptionController,
                decoration: const InputDecoration(labelText: 'Test Description'),
              ),
              // List of Questions
              Expanded(
                child: ListView.builder(
                  itemCount: _questions.length,
                  itemBuilder: (context, index) {
                    return _buildQuestion(index);
                  },
                ),
              ),
              // Add Question Button
              ElevatedButton(
                onPressed: _addQuestion,
                child: const Text('Add Question'),
              ),
              // Save Test Button
              ElevatedButton(
                onPressed: _saveTest,
                child: const Text('Save Test'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(int index) {
    final question = _questions[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Question ${index + 1}'),
          // Question Text Input
          TextFormField(
            initialValue: question.questionText,
            decoration: const InputDecoration(labelText: 'Question Text'),
            onChanged: (value) => setState(() => _questions[index].questionText = value),
          ),
          // Question Type Dropdown
          DropdownButtonFormField<String>(
            value: question.questionType,
            items: const [
              DropdownMenuItem(value: 'multiple_choice', child: Text('Multiple Choice')),
              DropdownMenuItem(value: 'single_choice', child: Text('Single Choice')),
            ],
            onChanged: (value) => setState(() => _questions[index].questionType = value!),
          ),
          // Question Weight Input
          TextFormField(
            initialValue: question.weight.toString(),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Weight'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a weight';
              }
              try {
                double.parse(value);
              } catch (error) {
                return 'Please enter a valid weight (number)';
              }
              return null;
            },
            onChanged: (value) {
              setState(() => _questions[index].weight = double.parse(value));
            },
          ),
          // Answer Options for the Question
          _buildAnswerOptions(index),
        ],
      ),
    );
  }

  Widget _buildAnswerOptions(int index) {
    final question = _questions[index];

    return Column(
      children: [
        for (int i = 0; i < question.answers!.length; i++)
          Row(
            children: [
              // Answer Text Field
              Expanded(
                child: TextFormField(
                  initialValue: question.answers![i].answerText,
                  decoration: const InputDecoration(labelText: 'Answer'),
                  onChanged: (value) {
                    setState(() {
                      question.answers?[i] = Answer(
                        id: question.answers![i].id, // Preserve ID
                        answerText: value, // Update answer text
                        question: question, // Preserve question reference
                        isCorrect: question.answers![i].isCorrect, // Preserve isCorrect
                      );
                    });
                  },
                ),
              ),
              // Correct Answer Checkbox
              Checkbox(
                value: question.answers![i].isCorrect,
                onChanged: (value) {
                  setState(() {
                    question.answers![i] = Answer(
                      id: question.answers![i].id, // Preserve ID
                      answerText: question.answers![i].answerText, // Preserve answer text
                      question: question, // Preserve question reference
                      isCorrect: value ?? false, // Update isCorrect
                    );
                  });
                },
              ),
            ],
          ),
        // Add Option Button
        ElevatedButton(
          onPressed: () {
            setState(() {
              
              question.answers!.add(
                Answer(
                  id: 0, // Placeholder ID
                  answerText: '', // Empty text for new answer
                  question: question, // Associate with current question
                  isCorrect: false, // Default to not correct
                ),
              );
            });
          },
          child: const Text('Add Option'),
        ),
      ],
    );
  }
}
