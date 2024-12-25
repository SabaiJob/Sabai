import 'package:flutter/material.dart';

class ReusableLabelHolder extends StatelessWidget {
  final String? labelName;
  final TextStyle? textStyle;
  final bool? isStarred;
  const ReusableLabelHolder({super.key, required this.labelName, required this.textStyle, required this.isStarred});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Align(
        alignment: Alignment.topLeft,
        child: RichText(
            text: TextSpan(text: labelName, style: textStyle!, children:  [
          if(isStarred == true)...[
            const TextSpan(
            text: ' *',
            style: TextStyle(
              color: Colors.pink,
            ),
          )
          ]
        ])),
      ),
    );
  }
}
