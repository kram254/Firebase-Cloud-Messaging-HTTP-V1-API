import 'package:flutter/material.dart';

class OtherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn Python'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Python Learning!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Python is a popular programming language. It was created by Guido van Rossum, and released in 1991.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Why Learn Python?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '1. Easy to learn and use\n'
              '2. Interpreted language\n'
              '3. Vast libraries support\n'
              '4. Versatile, can be used for web development, data analysis, AI, and more.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Sample Code:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.grey[200],
              child: Text(
                'print("Hello, World!")',
                style: TextStyle(fontSize: 18, fontFamily: 'Courier'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
