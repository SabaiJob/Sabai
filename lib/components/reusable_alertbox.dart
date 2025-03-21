import 'package:flutter/material.dart';

class ReusableAlertBox extends StatelessWidget {
  final String text;
  const ReusableAlertBox({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: SizedBox(
        width: 120,
        height: 200,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 110,
              width: 110,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 70, // Outer circle size
                    width: 70,
                    child: CircularProgressIndicator(
                      color: Color(0xffFF3997),
                      strokeWidth: 4.0, // Outer circle thickness
                    ),
                  ),
                  SizedBox(
                    height: 30, // Inner circle size
                    width: 30,
                    child: CircularProgressIndicator(
                      color: Color(0xffFF3997),
                      strokeWidth: 4.0, // Inner circle thickness
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Text(
              //'Loading...',
              text,
              style: const TextStyle(
                fontSize: 12.5,
                fontFamily: 'Bricolage-R',
                color: Color(0xff41464B),
              ),
            )
          ],
        ),
      ),
    );
  }
}
