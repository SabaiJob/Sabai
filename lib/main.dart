import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/materials/language_provider.dart';
import 'package:sabai_app/screens/walkthrough.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: const Sabai(),
    ),
  );
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
