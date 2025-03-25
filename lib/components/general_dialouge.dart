import 'package:flutter/material.dart';

import '../constants.dart';

class GeneralDialouge extends StatelessWidget {
  const GeneralDialouge({super.key, required this.dialougeText});
  final String dialougeText;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SizedBox(
          width: 200,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                textAlign: TextAlign.center,
                dialougeText,
                style: const TextStyle(
                  fontFamily: 'Bricolage-SMB',
                  fontSize: 19.53,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  width: 292,
                  height: 30,
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
