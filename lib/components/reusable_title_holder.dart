import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/services/language_provider.dart';

class ReusableTitleHolder extends StatelessWidget {
  final String? title;
  ReusableTitleHolder({required this.title});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Text(title!,
        style: languageProvider.lan == 'English'
            ? const TextStyle(
                fontFamily: 'Bricolage-M',
                fontSize: 24.41,
              )
            : const TextStyle(
                fontFamily: 'Walone-B',
                fontSize: 24.41,
              ));
  }
}
