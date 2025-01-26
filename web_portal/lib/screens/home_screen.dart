import 'package:flutter/material.dart';



class HomeScreen extends StatelessWidget {
  static String routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              color: const Color(0xFF0B3948), // Dark teal background
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  // Navigation Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.white, size: 32),
                          SizedBox(width: 8),
                          Text(
                            'Webportal',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'About Us',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Who's it for",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Resources',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/sign_in');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal[300],
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                            ),
                            child: const Text('Login'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/sign_up');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow[600],
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                            ),
                            child: const Text('Register'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Main Header Content
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Turn your assessments into success stories',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'AI-powered skills and knowledge assessment software, serving 2.5M+ business and educational users worldwide.',
                              style: TextStyle(color: Colors.white70, fontSize: 16),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow[600],
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              ),
                              child: const Text(
                                'Register - it\'s free',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Image.asset(
                          'assets/images/laptop.png', // Add your image here
                          height: 300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Access Code Section
            Container(
              color: const Color(0xFFEDE8F9), // Light purple background
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  const Text(
                    'Here to take a test?',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                 
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
      
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/test_screen');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal[300],
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        ),
                        child: const Text('Start your test'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Footer Section
            Container(
              padding:const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: const Column(
                children: [
                  Text(
                    'Create online tests, quizzes, and exams',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We helped these great brands write their success stories. Join them now. Choose professional online assessment tools.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
