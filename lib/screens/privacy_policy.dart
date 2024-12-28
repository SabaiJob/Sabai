import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/services/language_provider.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);

    const labelTextStyle = TextStyle(
      fontFamily: 'Bricolage-M',
      fontSize: 12.5,
      color: Color(0xff363B3F),
    );

    const labelTextStyleMm = TextStyle(
      fontFamily: 'Walone-B',
      fontSize: 11,
      color: Color(0xff363B3F),
    );

    const infoTextStyle = TextStyle(
      fontFamily: 'Bricolage-R',
      fontSize: 10,
      color: Color(0xff6C757D),
    );

    const infoTextStyleMn = TextStyle(
      fontFamily: 'Walone-R',
      fontSize: 10,
      color: Color(0xff6C757D),
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        surfaceTintColor: Colors.transparent,
        title: languageProvider.lan == 'English'
            ? const Text(
                'Privacy Policy',
                style: appBarTitleStyleEng,
              )
            : const Text(
                'ကိုယ်ရေးအချက်အလက် မူဝါဒ',
                style: appBarTitleStyleMn,
              ),
        iconTheme: const IconThemeData(
          color: primaryPinkColor,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'images/privacy.png',
                width: 113,
                height: 114,
              ),
              const SizedBox(
                height: 10,
              ),
              languageProvider.lan == 'English'
                  ? const Text(
                      'Privacy Policy',
                      style: labelStyleEng,
                    )
                  : const Text(
                      'ကိုယ်ရေးအချက်အလက် မူဝါဒ',
                      style: labelStyleMm,
                    ),
              const SizedBox(
                height: 5,
              ),
              languageProvider.lan == 'English'
                  ? const Text(
                      'Effective Date : January 31,2024',
                      style: TextStyle(
                        fontFamily: 'Bricolage-R',
                        fontSize: 12.5,
                        color: Color(0xff616971),
                      ),
                    )
                  : const Text(
                      'အကြုံး၀င်သောရက်ဆွဲ : January 31,2024',
                      style: TextStyle(
                        fontFamily: 'Walone-B',
                        fontSize: 11,
                        color: Color(0xff616971),
                      ),
                    ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      languageProvider.lan == 'English'
                          ? const Text(
                              'Introduction',
                              style: labelTextStyle,
                            )
                          : const Text(
                              'နိဒါန်း',
                              style: labelTextStyleMm,
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Sabai Jobs ("ကျွန်ုပ်တို့", "သင့်", သို့မဟုတ် "ကျွန်ုပ်တို့၏") သည် သင်၏ ကိုယ်ရေးအချက်အလက်များကို ကာကွယ်ရန် တာဝန်ယူပါသည်။ ဤကိုယ်ရေးအချက်အလက် မူဝါဒသည် သင်၏ အလုပ်ရှာဖွေရေး စက်ရုံဝန်ဆောင်မှုများ ("ဝန်ဆောင်မှုများ") ကို အသုံးပြုသည့်အခါ၊ ကျွန်ုပ်တို့က သင်၏ အချက်အလက်များကို စုဆောင်း၊ အသုံးပြု၊ ဖော်ပြ၊ နှင့် ကာကွယ်ပေးသည့် နည်းလမ်းများကို ရှင်းလင်းဖော်ပြပါသည်။ သင်သည် ဝန်ဆောင်မှုများကို ဝင်ရောက်သုံးစွဲခြင်းဖြင့် ဤကိုယ်ရေးအချက်အလက် မူဝါဒ၏ သဘောတူညီချက်ကို လက်ခံသည်ဟု ယူဆပါသည်။ သင်သည် ဤသဘောတူညီချက်နှင့် သဘောတူမပါက ဝန်ဆောင်မှုများကို အသုံးပြုမည်မဟုတ်ပါ။',
                        style: infoTextStyleMn,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      languageProvider.lan == 'English'
                          ? const Text(
                              '1. Information We Collect',
                              style: labelTextStyle,
                            )
                          : const Text(
                              '၁။ ကျွန်ုပ်တို့က စုဆောင်းသော အချက်အလက်များ',
                              style: labelTextStyleMm,
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      languageProvider.lan == 'English'
                          ? const Text(
                              'We may collect personal information from you in a variety of ways when you use our Services, including:',
                              style: infoTextStyle,
                            )
                          : const Text(
                              'ကျွန်ုပ်တို့သည် သင်၏ ဝန်ဆောင်မှုများအသုံးပြုနေစဉ် အစိတ်အပိုင်းအများအပြားဖြင့် ကိုယ်ရေးအချက်အလက်များကို စုဆောင်းနိုင်ပါသည်။ ထို့အတူ',
                              style: infoTextStyleMn),
                      const BulletInfo(
                        padding: 25,
                        infoTextStyle: infoTextStyle,
                        text:
                            'Personal Identification Information: This includes your name, email address, phone number, gender, date of birth, and other contact details.',
                        textmm:
                            'ကိုယ်ရေးအကြံပြုချက်အချက်အလက်: သင့်နာမည်၊ အီးမေးလ်လိပ်စာ၊ ဖုန်းနံပါတ်၊ လိင်၊ မွေးနေ့၊ နှင့် အခြားဆက်သွယ်မှုအချက်အလက်များ',
                        infoTextStylemm: infoTextStyleMn,
                        paddingmm: 20,
                      ),
                      const BulletInfo(
                        padding: 25,
                        text:
                            'Professional Information: This includes your resume, job history, educational background, skills, and other information relevant to job applications.',
                        infoTextStyle: infoTextStyle,
                        textmm:
                            'ပရော်ဖက်ရှင်နယ် အချက်အလက်: သင့်၏ အထူးပြုလက်မှတ်၊ အလုပ်သမားသမား၏ အတွေ့အကြုံ၊ ပညာရေးနောက်ခံ၊ ကျွမ်းကျင်မှုများ၊ နှင့် အလုပ်လျှောက်လွှာများနှင့် ဆိုင်သော အခြားသောအချက်အလက်များ',
                        infoTextStylemm: infoTextStyleMn,
                        paddingmm: 25,
                      ),
                      const BulletInfo(
                        padding: 25,
                        infoTextStyle: infoTextStyle,
                        text:
                            'Verification Information: This includes your passport number, work permit details, and photos of your passport and work permit.',
                        textmm:
                            'အတည်ပြုချက်အချက်အလက်: သင့်၏ ပတ်စ်ပို့အမှတ်၊ အလုပ်ခွင်တင်ခွင့် အချက်အလက်များနှင့် သင့်ပတ်စ်ပို့၊ အလုပ်ခွင်တင်ခွင့်ပုံများ',
                        infoTextStylemm: infoTextStyleMn,
                        paddingmm: 15,
                      ),
                      const BulletInfo(
                        padding: 25,
                        infoTextStyle: infoTextStyle,
                        text:
                            'Usage Data: This includes information about how you access and use our Services, including your IP address, browser type, device information, pages visited, and the date and time of your visit.',
                        textmm:
                            'အသုံးပြုမှု အချက်အလက်: သင်၏ IP လိပ်စာ၊ ဘရောက်ဇာပရိုဂရမ်အမျိုးအစား၊ ပစ္စည်းအချက်အလက်များ၊ ဝန်ဆောင်မှုများကို သင်သည်ဘယ်ပေ့ကြောင့် ဝင်ရောက်သုံးစွဲခဲ့ကြောင်း၊ နှင့် သင့် အချိန်နှင့်ရက်စွဲ',
                        infoTextStylemm: infoTextStyleMn,
                        paddingmm: 25,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      languageProvider.lan == 'English'
                          ? const Text(
                              '2. How We Use Your Information',
                              style: labelTextStyle,
                            )
                          : const Text(
                              '၂။ ကျွန်ုပ်တို့သင်၏ အချက်အလက်များကို ဘယ်လိုအသုံးပြုမလဲ',
                              style: labelTextStyleMm,
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      languageProvider.lan == 'English'
                          ? const Text(
                              'We may use the information we collect from you for various purposes, including:',
                              style: infoTextStyle,
                            )
                          : const Text(
                              'ကျွန်ုပ်တို့သည် သင်၏ အချက်အလက်များကို အမျိုးမျိုးသော ရည်ရွယ်ချက်များအတွက် အသုံးပြုနိုင်ပါသည်။ အထူးသဖြင့်-',
                              style: infoTextStyleMn,
                            ),
                      const BulletInfo(
                        padding: 0,
                        infoTextStyle: infoTextStyle,
                        text: 'To provide, operate, and maintain our Services.',
                        textmm:
                            'ဝန်ဆောင်မှုများကို ပေးခြင်း၊ အလုပ်ဆောင်ရွက်ခြင်း၊ နှင့် ပြုပြင်ထိန်းသိမ်းခြင်း',
                        infoTextStylemm: infoTextStyleMn,
                        paddingmm: 10,
                      ),
                      const BulletInfo(
                        padding: 0,
                        infoTextStyle: infoTextStyle,
                        text:
                            'To improve, personalize, and expand our Services',
                        textmm:
                            'ဝန်ဆောင်မှုများကို ကောင်းမွန်စွာ ပြုစုခြင်း၊ ကိုယ်တိုင်ပုဂ္ဂိုလ်မုန်တည်ခြင်း',
                        infoTextStylemm: infoTextStyleMn,
                        paddingmm: 10,
                      ),
                      const BulletInfo(
                        infoTextStyle: infoTextStyle,
                        text:
                            'To process your registration and manage your account.',
                        padding: 0,
                        textmm: 'သင့်အကောင့်ကို စီမံခန့်ခွဲ၍ မှတ်ပုံတင်ခြင်း',
                        infoTextStylemm: infoTextStyleMn,
                        paddingmm: 0,
                      ),
                      const BulletInfo(
                        infoTextStyle: infoTextStyle,
                        text:
                            'To facilitate communication between job seekers and employers.',
                        padding: 0,
                        textmm:
                            'လုပ်ရှာဖွေရေးသူများနှင့် အလုပ်ရှာဖွေရေးများကြား အကျိုးတစ်ခုတည်း ဖြစ်စေရန်',
                        infoTextStylemm: infoTextStyleMn,
                        paddingmm: 10,
                      ),
                      const BulletInfo(
                        infoTextStyle: infoTextStyle,
                        text:
                            'To send you updates, notifications, and other information related to your use of the Services.',
                        padding: 0,
                        textmm:
                            'သင့်အား အချက်အလက်များ၊ သတင်းအချက်အလက်များနှင့် အခြားကြားဖြတ်သတင်းအချက်အလက်များ ပို့ရန်',
                        infoTextStylemm: infoTextStyleMn,
                        paddingmm: 15,
                      ),
                      const BulletInfo(
                        infoTextStyle: infoTextStyle,
                        text:
                            'To prevent fraudulent activity and ensure the security of our Services.',
                        padding: 0,
                        textmm:
                            'တရားလှုပ်ရှားမှုကို ကာကွယ်ရန်နှင့် ဝန်ဆောင်မှုများ၏ လုံခြုံရေးကို သေချာစေသည်',
                        infoTextStylemm: infoTextStyleMn,
                        paddingmm: 15,
                      ),
                      const BulletInfo(
                        infoTextStyle: infoTextStyle,
                        text:
                            'To comply with legal obligations and protect our legal rights.',
                        padding: 0,
                        textmm:
                            'ဥပဒေအရ တာဝန်များနှင့် ဥပဒေရေးရာ အခွင့်အရေးများကို ကာကွယ်ရမည့် အခွင့်အလမ်းများ',
                        infoTextStylemm: infoTextStyleMn,
                        paddingmm: 15,
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
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

class BulletInfo extends StatelessWidget {
  const BulletInfo({
    super.key,
    required this.infoTextStyle,
    required this.text,
    required this.padding,
    required this.infoTextStylemm,
    required this.textmm,
    required this.paddingmm,
  });

  final String text;
  final TextStyle infoTextStyle;
  final double padding;

  final String textmm;
  final TextStyle infoTextStylemm;
  final double paddingmm;

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return ListTile(
      minTileHeight: 10,
      horizontalTitleGap: 0,
      minLeadingWidth: 10,
      minVerticalPadding: 0,
      leading: Padding(
        padding: EdgeInsets.only(
            bottom: languageProvider.lan == 'English' ? padding : paddingmm),
        child: const Icon(
          Icons.circle,
          size: 3,
        ),
      ),
      title: languageProvider.lan == 'English'
          ? Text(
              text,
              style: infoTextStyle,
            )
          : Text(
              textmm,
              style: infoTextStylemm,
            ),
    );
  }
}
