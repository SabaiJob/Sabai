import 'package:flutter/material.dart';

class DividerLine extends StatelessWidget {
  const DividerLine({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 311,
      child: Divider(
        color: Color(0xFFE2E3E5),
      ),
    );
  }
}