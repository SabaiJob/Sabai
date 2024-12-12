import 'package:flutter/material.dart';

class ReusableRadioButton extends StatelessWidget {
  final String selectedOption;
  final ValueChanged<String?> onChanged;
  final String yesText;
  final String noText;

  const ReusableRadioButton({
    required this.selectedOption,
    required this.onChanged,
    this.yesText = 'Yes',
    this.noText = 'No',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Radio<String>(
              value: yesText,
              groupValue: selectedOption,
              onChanged: onChanged,
              activeColor: Colors.pink,
            ),
            Text(
              yesText,
              style: const TextStyle(
                fontFamily: 'Bricolage-M',
                fontSize: 15.63,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Row(
          children: [
            Radio<String>(
              value: noText,
              groupValue: selectedOption,
              onChanged: onChanged,
              activeColor: Colors.pink,
            ),
            Text(
              noText,
              style: const TextStyle(
                fontFamily: 'Bricolage-M',
                fontSize: 15.63,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
