import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String email;

  HomePage({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome, $email', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login'); // Log out action
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
