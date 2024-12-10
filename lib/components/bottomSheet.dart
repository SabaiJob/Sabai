import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Bottomsheet extends StatelessWidget {
  const Bottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 641,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(30)),
            ),
            SizedBox(
              height: 15,
            ),
            Image.asset(
              'images/Verification.png',
              height: 212,
              width: 212,
            ),
            Text("Welcome to Sabai Job!",
                style: TextStyle(
                  fontFamily: 'Bricolage-M',
                  fontSize: 19.53,
                )),
            Text(
              'Here\'s how we ensure your job search is safe',
              style: TextStyle(
                color: Color(0xff6C757D),
                fontFamily: 'Bricolage-R',
                fontSize: 12.5,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 380,
              height: 315,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.pink.shade50,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    bottomSheet_content(
                      level: 'Level - 1',
                      text1: 'Be Cautions',
                      text2: 'New or unverified jobs.',
                      text3: 'Use extra caution',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    bottomSheet_content(
                      level: 'Level - 2',
                      text1: 'Safe but Verify',
                      text2: 'Generally save',
                      text3: 'Confirm details with the employer.',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    bottomSheet_content(
                      level: 'Level - 3',
                      text1: 'Totally Safe',
                      text2: 'From partnered companies or reliable\nsources.',
                      text3: 'Apply with confidence.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class bottomSheet_content extends StatelessWidget {
  bottomSheet_content({
    required this.level,
    required this.text1,
    required this.text2,
    required this.text3,
  });

  final String level;
  final String text1;
  final String text2;
  final String text3;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(level),
              CircleAvatar(
                radius: 2,
              ),
              Text(text1),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 2,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(text2),
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 2,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(text3),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
