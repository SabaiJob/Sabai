import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabai_app/components/bottomSheet.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    // Show the bottom sheet automatically after the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => const Bottomsheet(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bottom Sheet Example")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text("Show Bottom Sheet"),
        ),
      ),
    );
  }
}
