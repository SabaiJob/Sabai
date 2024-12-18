import 'package:flutter/material.dart';

class ReusableBulletPoints extends StatelessWidget {
  final String? content;
  const ReusableBulletPoints({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            size: 6,
            color: Colors.pink,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
            content!,
            style: const TextStyle(
                fontSize: 12.5,
                fontFamily: 'Bricolage-R',
                color: Color(0xFF4C5258)),
          )),
        ],
      ),
    );
  }
}