import 'package:flutter/material.dart';

class All extends StatelessWidget {
  const All({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: 100, // Total number of items
        itemBuilder: (context, index) {
          return ListTile(title: Text('Item $index'));
        },
      ),
    );
  }
}
