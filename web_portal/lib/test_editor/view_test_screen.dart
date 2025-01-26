import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_portal/models/test_model.dart';
import 'package:web_portal/test_editor/edit_test_screen.dart';

import '../providers/test_provider.dart';

class ViewTestsScreen extends StatefulWidget {
  static const routeName = '/view_tests';

  const ViewTestsScreen({super.key});

  @override
  State<ViewTestsScreen> createState() => _ViewTestsScreenState();
}

class _ViewTestsScreenState extends State<ViewTestsScreen> {
  @override
  Widget build(BuildContext context) {
    final testProvider = Provider.of<TestProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Tests'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Fetch tests again when refresh button is pressed
              testProvider.fetchTests();
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: testProvider.fetchTests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(fontSize: 16),
              ),
            );
          } else {
            final tests = testProvider.tests;

            if (tests.isEmpty) {
              return const Center(
                child: Text(
                  'No tests available. Create a test to get started!',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              itemCount: tests.length,
              itemBuilder: (ctx, index) {
                final test = tests[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    title: Text(
                      test.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(test.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              EditTestScreen.routeName,
                              arguments: test,
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deleteTest(test);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> _deleteTest(Test test) async {
    final testProvider = Provider.of<TestProvider>(context, listen: false);
    final shouldDelete = await _showDeleteConfirmationDialog(context, test.name);

    if (shouldDelete) {
      try {
        await testProvider.deleteTest(test.id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Test deleted successfully!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error deleting test: ${e.toString()}'),
            ),
          );
        }
      }
    }
  }

  Future<bool> _showDeleteConfirmationDialog(
      BuildContext context, String testName) async {
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Delete Test'),
            content: Text('Are you sure you want to delete "$testName"?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false); // Cancel
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true); // Confirm
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false; // Default to false if dialog is dismissed
  }
}
