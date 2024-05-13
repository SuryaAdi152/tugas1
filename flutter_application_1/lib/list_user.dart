import 'package:flutter/material.dart';

class ListUser extends StatelessWidget {
  ListUser({super.key});

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List User'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          itemCount: 50,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text('User $index'),
              ),
            );
          },
        ),
      ),
    );
  }
}