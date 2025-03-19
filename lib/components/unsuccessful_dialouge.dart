import 'package:flutter/material.dart';
import 'package:sabai_app/constants.dart';

class UnsuccessfulDialouge extends StatelessWidget {
  const UnsuccessfulDialouge({super.key, required this.dialougeText,});
  final String dialougeText;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SizedBox(
          width: 324,
          height: 340,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'images/sad.png',
                width: 140,
                height: 140,
              ),
               Text(
                textAlign: TextAlign.center,
                dialougeText,
                style: const TextStyle(
                  fontFamily: 'Bricolage-SMB',
                  fontSize: 19.53,
                ),
              ),
              SizedBox(
                width: 292,
                height: 29,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: primaryPinkColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Back',
                      style: TextStyle(
                        fontFamily: 'Bricolage-R',
                        fontSize: 12.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
