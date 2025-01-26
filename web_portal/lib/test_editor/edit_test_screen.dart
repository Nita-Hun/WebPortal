import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_portal/models/answer_model.dart';
import 'package:web_portal/models/test_model.dart';
import '../providers/test_provider.dart';

class EditTestScreen extends StatefulWidget {
  static const routeName = '/edit_test';

  const EditTestScreen({super.key, required this.test});

  final Test test;

  @override
  State<EditTestScreen> createState() => _EditTestScreenState();
}

class _EditTestScreenState extends State<EditTestScreen> {
  late Test _test;

  @override
  void initState() {
    super.initState();
    _test = widget.test.copyWith(); // Create a copy of the original test
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Test: ${_test.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTestDetails(),
              const SizedBox(height: 20),
              _buildQuestionsList(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveChanges,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTestDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: _test.name,
          decoration: const InputDecoration(labelText: 'Test Name'),
          onChanged: (value) => setState(() => _test.name = value),
        ),
        TextFormField(
          initialValue: _test.description,
          decoration: const InputDecoration(labelText: 'Test Description'),
          onChanged: (value) => setState(() => _test.description = value),
        ),
      ],
    );
  }

  Widget _buildQuestionsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _test.questions.length,
      itemBuilder: (context, index) {
        return _buildQuestion(index);
      },
    );
  }

  Widget _buildQuestion(int index) {
    final question = _test.questions[index];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Question ${index + 1}'),
            TextFormField(
              initialValue: question.questionText,
              decoration: const InputDecoration(labelText: 'Question Text'),
              onChanged: (value) => setState(() => _test.questions[index].questionText = value),
            ),
            DropdownButtonFormField<String>(
              value: question.questionType,
              items: const [
                DropdownMenuItem(value: 'multiple_choice', child: Text('Multiple Choice')),
                DropdownMenuItem(value: 'single_choice', child: Text('Single Choice')),
              ],
              onChanged: (value) => setState(() => _test.questions[index].questionType = value!),
            ),
            TextFormField(
              initialValue: question.weight.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Weight'),
              onChanged: (value) {
                
                  setState(() => _test.questions[index].weight = double.parse(value));
                
              },
            ),
            _buildAnswerOptions(index),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  _test.questions.removeAt(index);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerOptions(int questionIndex) {
    final question = _test.questions[questionIndex];

    return Column(
      children: [
        for (int i = 0; i < question.answers!.length; i++)
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: question.answers![i].answerText,
                  decoration: const InputDecoration(labelText: 'Answer'),
                  onChanged: (value) => setState(() {
                    _test.questions[questionIndex].answers![i]= Answer(
                      id: question.answers![i].id, 
                      answerText: value, 
                      question: question, 
                      isCorrect: question.answers![i].isCorrect);
                  }),
                ),
              ),
              Checkbox(
                value: question.correctAnswerIds.contains(i),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      _test.questions[questionIndex].correctAnswerIds.add(i);
                    } else {
                      _test.questions[questionIndex].correctAnswerIds.remove(i);
                    }
                  });
                },
              ),
            ],
          ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _test.questions[questionIndex].answers!.add(Answer(
                id: 0,
                answerText: '',
                question: question,
                isCorrect: false,
              ));
            });
          },
          child: const Text('Add Option'),
        ),
      ],
    );
  }

  void _saveChanges() async {

    final testProvider = Provider.of<TestProvider>(context, listen: false);
    try {
      await testProvider.updateTest(_test);
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Test updated successfully!')),
      );
      }
      if(mounted){
        Navigator.of(context).pop();
      }
      
    } catch (e) {
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error updating test. Please try again.')),
      );
      }
      
    }
  }
}