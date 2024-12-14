import 'package:flutter/material.dart';

class ReusableTitleHolder extends StatelessWidget {
  final String? title;
  ReusableTitleHolder({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
    title!, 
    style: const TextStyle(
      fontFamily: 'Bricolage-M',
      fontSize: 24.41,
    ),);
  }
}
