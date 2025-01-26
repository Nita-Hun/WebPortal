import 'package:flutter/material.dart';
import 'package:web_portal/front_screen/question_screen.dart';
import 'package:web_portal/models/test_model.dart';


class TestManagementScreen extends StatefulWidget {
  const TestManagementScreen({super.key});
  

  @override
  TestManagementScreenState createState() => TestManagementScreenState();
}

class TestManagementScreenState extends State<TestManagementScreen> {
  // Sample list of tests
  List<Test> tests = [
    Test(
      id: 1,
      name: "Example Quiz for Restaurant Staff",
      description: "A quiz for training restaurant staff.",
      questions: [],
    ),
    Test(
      id: 2,
      name: "Example Product Knowledge Test for Sales",
      description: "A quiz to test sales knowledge.",
      questions: [],
    ),
  ];

  // Method to add a new test
  void _addNewTest(String name, String description) {
    setState(() {
      tests.add(Test(
        id: tests.length + 1,
        name: name,
        description: description,
        questions: [],
      ));
    });
  }

  // Method to display a dialog for creating a new test
  void _showCreateTestDialog() {
    String testName = "";
    String testDescription = "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Create New Test"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Test Name"),
                onChanged: (value) {
                  testName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Test Description"),
                onChanged: (value) {
                  testDescription = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (testName.isNotEmpty) {
                  _addNewTest(testName, testDescription);
                  Navigator.pop(context);
                }
              },
              child: const Text("Create"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Management"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showCreateTestDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: tests.length,
          itemBuilder: (context, index) {
            final test = tests[index];
            return Card(
              elevation: 4.0,
              margin: const EdgeInsets.only(bottom: 16.0),
              child: ListTile(
                title: Text(
                  test.name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(test.description),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  // Navigate to the Questions Screen for the selected test
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionScreen(test: test,),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _showCreateTestDialog,
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
