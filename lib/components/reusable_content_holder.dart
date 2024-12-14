import 'package:flutter/material.dart';

class ReusableContentHolder extends StatelessWidget {
  final String? content;
  ReusableContentHolder({required this.content});

  @override
  Widget build(BuildContext context) {
    return Text(content!,
    style: const TextStyle(
      fontFamily: 'Bricolage-R',
      fontSize: 15.63,
      color: Color(0xFF08210E),
    ),
    );
  }
}