import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/job_provider.dart';
import '../services/language_provider.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.languageProvider,
    required this.textEng,
    required this.textMm,
    required this.color,
    required this.widget,
    required this.tColor,
    required this.bColor,
    required this.isGuest,
  });

  final LanguageProvider languageProvider;
  final String textEng;
  final String textMm;
  final Color color;
  final Widget widget;
  final Color tColor;
  final Color bColor;
  final bool isGuest;

  @override
  Widget build(BuildContext context) {
    var jobProvider = Provider.of<JobProvider>(context);
    return Container(
      width: 343,
      height: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: () {
          jobProvider.setGuest(isGuest);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => widget,
            ),
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: bColor),
            borderRadius: BorderRadius.circular(8), // Set the border radius
          ),
        ),
        child: languageProvider.lan == 'English'
            ? Text(
                textEng,
                style: TextStyle(
                  fontFamily: 'Bricolage-B',
                  color: tColor,
                  fontSize: 15.63,
                ),
              )
            : Text(
                textMm,
                style: TextStyle(
                  color: tColor,
                  fontSize: 14,
                  fontFamily: 'Walone-B',
                ),
              ),
      ),
    );
  }
}
