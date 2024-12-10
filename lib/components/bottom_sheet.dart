import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/services/language_provider.dart';

class Bottomsheet extends StatelessWidget {
  const Bottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvide = Provider.of<LanguageProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      height: 641,
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Image.asset(
              'images/Verification.png',
              height: 212,
              width: 212,
            ),
            languageProvide.lan == 'English'
                ? const Text(
                    "Welcome to Sabai Job!",
                    style: TextStyle(
                      fontFamily: 'Bricolage-M',
                      fontSize: 19.53,
                      color: Colors.black,
                    ),
                  )
                : const Text(
                    "Sabai Job မှကြိုဆိုပါတယ် !",
                    style: TextStyle(
                      fontFamily: 'Bricolage-B',
                      fontSize: 19.53,
                      color: Colors.black,
                    ),
                  ),
            SizedBox(
              height: 5,
            ),
            languageProvide.lan == 'English'
                ? const Text(
                    'Here\'s how we ensure your job search is safe',
                    style: TextStyle(
                      color: Color(0xff6C757D),
                      fontFamily: 'Bricolage-R',
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : const Text(
                    textAlign: TextAlign.center,
                    'သင့်အလုပ်ရှာဖွေမှု လုံခြုံစေဖို့ အလုပ်ပိုစ့်များရဲ့\nယုံကြည်ရမှုအဆင့်များ',
                    style: TextStyle(
                      color: Color(0xff6C757D),
                      fontFamily: 'Bricolage-B',
                      fontSize: 11,
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 380,
              height: 308,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.pink.shade50,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    languageProvide.lan == 'English'
                        ? const BottomSheetContent(
                            level: 'Level - 1',
                            text1: 'Be Cautions',
                            text2: 'New or unverified jobs.',
                            text3: 'Use extra caution',
                          )
                        : const BottomSheetContent(
                            level: 'အဆင့် - ၁',
                            text1: 'သတိထားပါ',
                            text2:
                                'အသစ်ရောက်ရှိသောအလုပ်များ (သို့)\nအတည််မပြုရသေးသောအလုပ်များ',
                            text3: 'အထူးသတိထားပါ',
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    languageProvide.lan == 'English'
                        ? const BottomSheetContent(
                            level: 'Level - 2',
                            text1: 'Safe but Verify',
                            text2: 'Generally save',
                            text3: 'Confirm details with the employer.',
                          )
                        : const BottomSheetContent(
                            level: 'အဆင့် - ၂',
                            text1: 'ယုံကြည်ရသော်လည်း အတည်ပြုပါ',
                            text2: 'အများအားဖြင့် ယုံကြည်ရတယ်',
                            text3:
                                'အလုပ်ရှင်များနှင့် အသေးစိတ် ကိုပြန်စစ်ဆေးပါ',
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    languageProvide.lan == 'English'
                        ? const BottomSheetContent(
                            level: 'Level - 3',
                            text1: 'Totally Safe',
                            text2:
                                'From partnered companies or reliable\nsources.',
                            text3: 'Apply with confidence.',
                          )
                        : const BottomSheetContent(
                            level: 'အဆင့် - ၃',
                            text1: 'လုံးဝယုံကြည်ရတယ်',
                            text2:
                                'မိတ်ဖက်ကုမ္ပဏီများ (သို့)\nယုံကြည်စိတ်ချရသောအရင်းအမြစ်များမှ ဖြစ်တယ',
                            text3: 'စိတ်ချလက်ချ လျှောက်ထားနိုင်တယ်',
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

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({
    super.key,
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
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              languageProvider.lan == 'English'
                  ? Text(
                      level,
                      style: const TextStyle(
                        fontFamily: 'Bricolage-M',
                        color: Color(0xffFF3997),
                        fontSize: 15.63,
                      ),
                    )
                  : Text(
                      level,
                      style: const TextStyle(
                        fontFamily: 'Bricolage-B',
                        color: Color(0xffFF3997),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              const SizedBox(
                width: 5,
              ),
              const CircleAvatar(
                radius: 2,
                backgroundColor: Color(0xffFF9CCB),
              ),
              const SizedBox(
                width: 5,
              ),
              languageProvider.lan == 'English'
                  ? Text(
                      text1,
                      style: const TextStyle(
                        fontFamily: 'Bricolage-R',
                        fontSize: 12.5,
                        color: Color(0xffFF3997),
                      ),
                    )
                  : Text(
                      text1,
                      style: const TextStyle(
                        fontFamily: 'Bricolage-M',
                        fontSize: 11,
                        color: Color(0xffFF3997),
                      ),
                    ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 2,
                    backgroundColor: Colors.black,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  languageProvider.lan == 'English'
                      ? Text(
                          text2,
                          style: const TextStyle(
                            color: Color(0xff41464B),
                            fontFamily: 'Bricolage-R',
                            fontSize: 15.63,
                          ),
                        )
                      : Text(
                          text2,
                          style: const TextStyle(
                            color: Color(0xff41464B),
                            fontFamily: 'Bricolage-B',
                            fontSize: 14,
                          ),
                        ),
                ],
              ),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 2,
                    backgroundColor: Colors.black,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  languageProvider.lan == 'English'
                      ? Text(
                          text3,
                          style: const TextStyle(
                            color: Color(0xff41464B),
                            fontFamily: 'Bricolage-R',
                            fontSize: 15.63,
                          ),
                        )
                      : Text(
                          text3,
                          style: const TextStyle(
                            color: Color(0xff41464B),
                            fontFamily: 'Bricolage-B',
                            fontSize: 14,
                          ),
                        ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
