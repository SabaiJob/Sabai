import 'package:flutter/material.dart';
import 'package:sabai_app/components/cv_upload_model.dart';
import 'package:sabai_app/components/reusable_bulletpoints.dart';
import 'package:sabai_app/components/t&c_bullentpoints.dart';
import 'package:sabai_app/services/general_service.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:provider/provider.dart';

class TAndCDialog extends StatelessWidget {
  final int jobId;
  final VoidCallback onPressed;
  const TAndCDialog({super.key, required this.jobId, required this.onPressed});

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
                languageProvider.lan == "English"
                  ? const Text(
                      'Important Notice',
                      style: TextStyle(
                        fontFamily: 'Walone-R',
                        fontSize: 11,
                        color: Color(0xFF2B2F32)
                      ),
                    )
                  : const Text(
                      'အရေးကြီးသောသတိပေးချက်',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Walone-R',
                        fontSize: 11,
                        color: Color(0xFF2B2F32)
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              TnCBulletPoints(
                  content: languageProvider.lan == "English"
                      ? 'At Sabai Job, we are commited to creating a safe and reliable platform. We carefully review and verify job postings before they appear on the app to help protect our users.'
                      : 'ကျွန်ုပ်တို့ အနေဖြင့် Sabai Job ကို ယုံကြည်စိတ်ချ၊ အားထားရသော ပလက်ဖောင်းတစ်ခုဖြစ်အောင် ဖန်တီးထားပါသည်။ ကျွန်ုပ်တို့၏ အသုံးပြုသူများကို ကာကွယ်ရန်အတွက် အလုပ်ကြော်ငြာများကို  ဂရုတစိုက် စစ်ဆေးအတည်ပြုပြီးမှသာ အပလိီကေးရှင်းပေါ်သို့ တင်ပေးပါသည်။'),
              TnCBulletPoints(
                  content: languageProvider.lan == "English"
                      ? 'However, because situations can change and some details may not always be visible online, it is also the user\'s responsibility to carefully review the job information and verify important details with the employer before applying.'
                      : 'မည်သို့ပင်ဆိုစေကာမူ အခြေအနေများသည် ပြောင်းလဲနိုင်ပြီး အချို့သော အသေးစိတ်အချက်အလက်များကို အွန်လိုင်းပေါ်တွင် အမြဲမမြင်နိုင်သောကြောင့် အလုပ်ခေါ်စာ နှင့် အလုပ်ရှင်အကြောင်းကို အသုံးပြုသူများ ကိုယ်တိုင်လည်း ဂရုတစိုက် ထပ်မံစစ်ဆေးပြီးမှသာ လျှောက်ထားသင့်ပါသည်။'),
              TnCBulletPoints(
                  content: languageProvider.lan == "English"
                      ? 'Sabai Job verifies with care. You, as a user, must also check with care. By working together, we can ensure a safer and better job-seeking experience for everyone.'
                      : 'Sabai Job အနေဖြင့် အလုပ်ခေါ်စာများအား မေတ္တာဖြင့် ဂရုတစိုက် စစ်ဆေးအတည်ပြုပါသည်။ အသုံးပြုသူများအားလည်း ဂရုတစိုက် စစ်ဆေးအတည်ပြုရန် မေတ္တာရပ်ခံပါသည်။ ကျွန်ုပ်တို့ အတူတကွ ပူးပေါင်းဆောင်ရွက်ခြင်းအားဖြင့် လူတိုင်းအတွက် ပိုမိုလုံခြုံကောင်းမွန်သော အလုပ်အကိုင်ရှာဖွေမှု အတွေ့အကြုံကို ရရှိစေမည် ဖြစ်ပါသည်။'),
              TnCBulletPoints(
                  content: languageProvider.lan == "English"
                      ? 'If you notice anything suspicious, please report it to us immediately.'
                      : 'မသင်္ကာဖွယ်ရာ တစ်စုံတစ်ခုကို သတိပြုမိပါက၊ ကျွန်ုပ်တို့ထံသို့ ချက်ချင်း အကြောင်းကြားပါ။'),
              TnCBulletPoints(
                  content: languageProvider.lan == "English"
                      ? 'Thank you for being part of the Sabai Job community.'
                      : 'Sabai Job အသိုင်းအဝိုင်း၏ တစ်စိတ်တစ်ပိုင်းဖြစ်သော သင့်အား ကျေးဇူးတင်ပါသည်။'),
              const SizedBox(
                height: 10,
              ),
              if (languageProvider.lan == "English") ...[
                const Text(
                  'By clicking "I Accept," you acknowledge that you have read, understood, and agree to these terms and conditions.',
                  style: TextStyle(
                      fontFamily: 'Walone-B',
                      fontSize: 11,
                      color: Color(0xFF2B2F32)),
                )
              ] else ...[
                const Text(
                  '“I Accept” အား နှိပ်ခြင်းဖြင့် သင်သည် စဥ်းမျဥ်းစည်းကမ်းများ နှင့် သတ်မှတ်ချက်များအား ဖတ်ရှုနားလည်ပြီး သဘောတူညီမှုရှိကြောင်း အတည်ပြုပါသည်။',
                  style: TextStyle(
                      fontFamily: 'Walone-B',
                      fontSize: 11,
                      color: Color(0xFF2B2F32)),
                )
              ],
              const SizedBox(
                height: 20,
              ),
              TextButton(
                // onPressed: () async {
                //   await GeneralService.saveForApplyButton(true);
                //   Navigator.pop(context);
                //   showDialog(
                //       context: context,
                //       builder: (context) => CvUploadModel(
                //             jobId: jobId,
                //           ),
                //       barrierDismissible: false);
                // },
                onPressed: onPressed,
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
