import 'package:flutter/material.dart';
import 'package:web_portal/models/test_model.dart';

class QuestionScreen extends StatefulWidget {
  static const routeName = '/question_manager';

  final Test test;

  const QuestionScreen({super.key, required this.test});

  @override
  State<QuestionScreen> createState() => _QuestionManagerScreenState();
}

class _QuestionManagerScreenState extends State<QuestionScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      "id": 1,
      "question": "Which ingredients are required for the Tonno e cipolla pizza?",
      "options": [
        "Mozzarella, Tuna, Onion seasoned with Oregano, Basil, Salt, Pepper with a splash of Extra Virgin Olive Oil",
        "Mozzarella, Tomato Sauce, Spicy Salami, Oregano",
        "Mozzarella, Tomato Puree, Cooked Ham, Boiled Eggs, Mushrooms, Artichokes, Pitted Black Olives, Oregano, Basil"
      ],
      "correctOption": 0,
      "type": "Single choice",
      "points": 1
    },
    {
      "id": 2,
      "question": "What type of pizza is this?",
      "imageUrl": "https://via.placeholder.com/300", // Example image URL
      "options": ["Neapolitan", "Margherita", "Tonno e Cipolla"],
      "correctOption": 1,
      "type": "Single choice",
      "points": 1
    },
  ];

  void _addQuestion() {
    final TextEditingController questionController = TextEditingController();
    final TextEditingController pointsController = TextEditingController();
    final TextEditingController option1Controller = TextEditingController();
    final TextEditingController option2Controller = TextEditingController();
    final TextEditingController option3Controller = TextEditingController();
    String selectedQuestionType = "Single choice"; // Default question type

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Question'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: questionController,
                decoration: const InputDecoration(labelText: 'Question'),
              ),
              const SizedBox(height: 8),
              const Text('Question Type:', style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: selectedQuestionType,
                items: const [
                  DropdownMenuItem(value: 'Single choice', child: Text('Single Choice')),
                  DropdownMenuItem(value: 'Multiple choice', child: Text('Multiple Choice')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedQuestionType = value!;
                  });
                },
              ),
              TextField(
                controller: pointsController,
                decoration: const InputDecoration(labelText: 'Points'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              const Text('Options:', style: TextStyle(fontWeight: FontWeight.bold)),
              TextField(
                controller: option1Controller,
                decoration: const InputDecoration(labelText: 'Option 1'),
              ),
              TextField(
                controller: option2Controller,
                decoration: const InputDecoration(labelText: 'Option 2'),
              ),
              TextField(
                controller: option3Controller,
                decoration: const InputDecoration(labelText: 'Option 3'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (questionController.text.isNotEmpty &&
                  pointsController.text.isNotEmpty) {
                setState(() {
                  questions.add({
                    "id": questions.length + 1,
                    "question": questionController.text,
                    "options": [
                      option1Controller.text,
                      option2Controller.text,
                      option3Controller.text,
                    ],
                    "correctOption": 0, // Default correct option
                    "type": selectedQuestionType,
                    "points": int.tryParse(pointsController.text) ?? 1,
                  });
                });
                Navigator.of(ctx).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questions Manager - ${widget.test.name}'),
      ),
      body: Row(
        children: [
          // Sidebar (optional)
          Container(
            width: 200,
            color: Colors.grey[200],
            child: ListView(
              children: const [
                ListTile(title: Text('Test configuration')),
                ListTile(title: Text('Questions manager')),
                ListTile(title: Text('My test')),
                ListTile(title: Text('Test access')),
                ListTile(title: Text('Result')),
              ],
            ),
          ),

          // Main content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top actions row
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: _addQuestion,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Question'),
                      ),
                      const Spacer(),
                      DropdownButton<String>(
                        value: "All categories",
                        items: ["All categories", "Product Knowledge"]
                            .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                ))
                            .toList(),
                        onChanged: (value) {
                          // Handle category filter
                        },
                      ),
                    ],
                  ),
                ),

                // List of questions
                Expanded(
                  child: ListView.builder(
                    itemCount: questions.length,
                    itemBuilder: (ctx, index) {
                      final question = questions[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Question title
                              Text(
                                'Q. ${index + 1} ${question['question'] ?? 'No question provided'}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),

                              // Image (if available)
                              if (question['imageUrl'] != null)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0),
                                  child: Image.network(
                                    question['imageUrl'],
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                              // Options (if available)
                              if (question['options'] != null)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: (question['options'] as List<String>)
                                      .map((option) {
                                    int optionIndex = question['options'].indexOf(option);
                                    return ListTile(
                                      title: Text(option),
                                      leading: Radio<int>(
                                        value: optionIndex,
                                        groupValue: question['correctOption'],
                                        onChanged: (value) {
                                          setState(() {
                                            question['correctOption'] = value!;
                                          });
                                        },
                                      ),
                                    );
                                  }).toList(),
                                ),

                              // Footer: type and points
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Type: ${question['type'] ?? 'Unknown'}',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    'Points: ${question['points'] ?? 0}',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
