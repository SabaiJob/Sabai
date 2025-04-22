import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/services/language_provider.dart';

class ReusableBulletPoints extends StatelessWidget {
  final String? content;
  const ReusableBulletPoints({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
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
              style: languageProvider.lan == 'English'
                  ? const TextStyle(
                      fontSize: 15.63,
                      fontFamily: 'Walone-R',
                      //color: Color(0xFF4C5258),
                    )
                  : const TextStyle(
                      fontSize: 11,
                      fontFamily: 'Walone-B',
                      //color: Color(0xFF4C5258),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
