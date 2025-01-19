import 'package:flutter/material.dart';

class PopupWidget extends StatelessWidget {
  const PopupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      color: const Color(0xfff0f1f2),
      height: 28,
      width: 130,
      child: const Text(
        'Sourced from partnered companies and reliable sources. Apply with confidence.',
        style: TextStyle(
          fontSize: 6,
          fontFamily: 'Bricolage-R',
        ),
      ),
    );
  }
}
