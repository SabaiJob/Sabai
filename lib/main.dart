import 'package:flutter/material.dart';
import 'package:sabai_app/screens/walkthrough.dart';

void main() {
  runApp(const Sabai());
}

class Sabai extends StatelessWidget {
  const Sabai({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Walkthrough(),
    );
  }
}
