import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/services/language_provider.dart';

class ReusableContentHolder extends StatelessWidget {
  final String? content;
  const ReusableContentHolder({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Text(
      content!,
      style: languageProvider.lan == 'English'
          ? const TextStyle(
              fontFamily: 'Bricolage-R',
              fontSize: 15.63,
              color: Color(0xFF08210E),
            )
          : const TextStyle(
              fontFamily: 'Walone-R',
              fontSize: 14,
              color: Colors.black,
            ),
    );
  }
}
