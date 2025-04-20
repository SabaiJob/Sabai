import 'package:flutter/material.dart';
import 'package:sabai_app/components/cv_upload_model.dart';
import 'package:sabai_app/components/reusable_bulletpoints.dart';
import 'package:sabai_app/services/general_service.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:provider/provider.dart';

class TAndCDialog extends StatelessWidget {
  final int jobId;
  const TAndCDialog({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Container(
        width: double.infinity,
        height: 600,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xfff0f1f2),
            width: 10,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
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
                height: 50,
              ),
              TextButton(
                onPressed: () async {
                  await GeneralService.saveForApplyButton(true);
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (context) => CvUploadModel(
                            jobId: jobId,
                          ),
                      barrierDismissible: false);
                },
                style: TextButton.styleFrom(
                  minimumSize: const Size(277, 34),
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
            ],
          ),
        ),
      ),
    );
  }
}
