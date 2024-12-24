import 'package:flutter/material.dart';
import 'package:sabai_app/components/reusable_bulletpoints.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:provider/provider.dart';

class TAndCDialog extends StatelessWidget {
  const TAndCDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        width: 309,
        height: 530,
        decoration: const BoxDecoration(
          color: Color(0xFFF0F1F2),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Container(
          width: 293,
          height: 514,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/t&c.png',
                width: 110,
                height: 100,
              ),
              languageProvider.lan == "English"
                  ? const Text(
                      'Terms and Conditions',
                      style: TextStyle(
                        fontFamily: 'Bricolage-M',
                        fontSize: 19.53,
                      ),
                    )
                  : const Text(
                      'သတ်မှတ်ချက်များနှင့်\nအခြေအနေများ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Walone-B',
                        fontSize: 19.53,
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              languageProvider.lan == 'English'
                  ? const Text(
                      'Please read and accept our Terms and Conditions before proceeding.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Bricolage-R',
                        fontSize: 12.5,
                        color: Colors.black54,
                      ),
                    )
                  : const Text(
                      'ကျွန်ုပ်တို့၏ သတ်မှတ်ချက်များနှင့် အခြေအနေများကို အရင်ဖတ်ပါ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Walone-B',
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              const ReusableBulletPoints(
                  content: 'Lorem ipsum dolor sit amet consectetur.'),
              const ReusableBulletPoints(
                  content:
                      'Lorem ipsum dolor sit amet consectetur. Purus faucibus sed fames arcu.'),
              const ReusableBulletPoints(
                  content:
                      'Lorem ipsum dolor sit amet consectetur. Purus faucibus sed fames arcu.'),
              const ReusableBulletPoints(
                  content:
                      'Lorem ipsum dolor sit amet consectetur. Purus faucibus sed fames arcu.'),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'By clicking "I Accept," you acknowledge that you have read, understood, and agree to these terms and conditions.',
                style: TextStyle(
                    fontFamily: 'Bricolage-M',
                    fontSize: 12.5,
                    color: Color(0xFF41464B)),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 277,
                height: 34,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    side: const BorderSide(color: Color(0xffFF3997)),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Set the border radius
                    ),
                  ),
                  child: languageProvider.lan == 'English'
                      ? const Text(
                          'I accept',
                          style: TextStyle(
                            color: Color(0xffFF3997),
                            fontFamily: 'Bricolage-B',
                            fontSize: 15.63,
                          ),
                        )
                      : const Text(
                          'လက်ခံပါသည်',
                          style: TextStyle(
                            color: Color(0xffFF3997),
                            fontFamily: 'Walone-B',
                            fontSize: 14,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
