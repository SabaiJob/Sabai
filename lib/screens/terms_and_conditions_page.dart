import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/constants.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

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
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey.shade300,
              height: 1.0,
            )),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: languageProvider.lan == 'English'
            ? const Text(
                "Terms and Conditions",
                style: appBarTitleStyleEng,
              )
            : const Text(
                'ထုတ်ပြန်ချက်နှင့် ရေးရာမူဝါဒ',
                style: appBarTitleStyleMn,
              ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xFFFF3997),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 139,
                    height: 139,
                    decoration: const BoxDecoration(
                        color: Color(0xFFf9edc2),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        border: Border(
                          top: BorderSide(
                            color: Color(0xFFFFC107),
                            width: 2,
                          ),
                          bottom: BorderSide(
                            color: Color(0xFFFFC107),
                            width: 2,
                          ),
                          left: BorderSide(
                            color: Color(0xFFFFC107),
                            width: 2,
                          ),
                          right: BorderSide(
                            color: Color(0xFFFFC107),
                            width: 2,
                          ),
                        )),
                  ),
                  Positioned(
                      right: -10,
                      bottom: -10,
                      child: Image.asset(
                        'icons/contract.png',
                        width: 160,
                        height: 160,
                      )),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                languageProvider.lan == 'English'
                    ? 'Terms and Conditions'
                    : 'ထုတ်ပြန်ချက်နှင့် ရေးရာမူဝါဒ',
                style: const TextStyle(
                  fontFamily: 'Bricolage-M',
                  fontSize: 15.63,
                  color: Color(0xFF161719),
                ),
              ),
              Text(
                  languageProvider.lan == 'English'
                      ? 'Effective Date: January 31, 24'
                      : 'အကြုံးဝင်သောရက်ဆွဲ: January 31, 24',
                  style: languageProvider.lan == 'English'
                      ? const TextStyle(
                          color: Color(0xFF616971),
                          fontFamily: 'Bricolage-R',
                          fontSize: 12.5,
                        )
                      : const TextStyle(
                          color: Color(0xFF616971),
                          fontFamily: 'Walone-B',
                          fontSize: 11,
                        )),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border(
                        top: BorderSide(
                          color: Color(0xFFF0F1F2),
                          width: 1.5,
                        ),
                        bottom: BorderSide(
                          color: Color(0xFFF0F1F2),
                          width: 1.5,
                        ),
                        right: BorderSide(
                          color: Color(0xFFF0F1F2),
                          width: 1.5,
                        ),
                        left: BorderSide(
                          color: Color(0xFFF0F1F2),
                          width: 1.5,
                        ))),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      languageProvider.lan == 'English'
                    ?
                      'Introduction' : 'နိဒါန်း',
                      style: languageProvider.lan == 'English'
                      ?
                      const TextStyle(
                        fontSize: 12.5,
                        fontFamily: 'Bricolage-M',
                        color: Color(0xFF363B3F),
                      ) :  const TextStyle(
                        fontSize: 11,
                        fontFamily: 'Walone-B',
                        color: Color(0xFF363B3F),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      languageProvider.lan == 'English'
                      ?
                      'Welcome to Sabai Jobs! These Terms and Conditions ("Terms") govern your access to and use of our job portal services ("Services"). By accessing or using our Services, you agree to be bound by these Terms. If you do not agree to these Terms, please do not use our Services.' : 'Sabai Jobs သို့ ကြိုဆိုပါသည်! ဤထုတ်ပြန်ချက်နှင့် ရေးရာမူဝါဒများ ("မူဝါဒ") သည် သင်၏ အလုပ်ရှာဖွေရေး စက်ရုံဝန်ဆောင်မှုများ ("ဝန်ဆောင်မှုများ") သို့ ဝင်ရောက်သုံးစွဲခြင်းနှင့် အသုံးပြုခြင်းကို စီမံခန့်ခွဲပါသည်။ သင်သည် ဤဝန်ဆောင်မှုများကို ဝင်ရောက်သုံးစွဲခြင်းဖြင့် ဤမူဝါဒများကို လက်ခံပြီး သေချာစွာ လိုက်နာရပါမည်။ သင်သည် ဤမူဝါဒများနှင့် သဘောတူပါက အလုပ်များကို ပို့တင်ခြင်းနှင့် သက်ဆိုင်သော ဝန်ဆောင်မှုများကို သုံးစွဲနိုင်ပါသည်။ မသဘောတူပါက ဝန်ဆောင်မှုများကို အသုံးပြုပါက မရပါ။',
                      style: languageProvider.lan == 'English'
                      ?
                      const TextStyle(
                        fontSize: 10,
                        fontFamily: 'Bricolage-R',
                        color: Color(0xFF6C757D),
                      ) : const TextStyle(
                        fontSize: 10,
                        fontFamily: 'Walone_R',
                        color: Color(0xFF6C757D),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      languageProvider.lan == 'English'
                      ?
                      '1. Acceptance of terms' : '၁။ မူဝါဒလက်ခံခြင်း',
                      style: languageProvider.lan == 'English'
                      ?
                      const TextStyle(
                        fontSize: 12.5,
                        fontFamily: 'Bricolage-M',
                        color: Color(0xFF363B3F),
                      ) :const TextStyle(
                        fontSize: 11,
                        fontFamily: 'Walone-B',
                        color: Color(0xFF363B3F),
                      ) ,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                       languageProvider.lan == 'English'
                      ?
                      'By registering for and/or using the Services, you accept and agree to be bound by these Terms. If you are using the Services on behalf of a company or other legal entity, you represent that you have the authority to bind such entity to these Terms.' : 'သင်သည် ဝန်ဆောင်မှုများကို မှတ်ပုံတင်ခြင်းနှင့်/သို့မဟုတ် အသုံးပြုခြင်းဖြင့် ဤမူဝါဒများကို လက်ခံပြီး လိုက်နာရန် သဘောတူပါသည်။ သင်သည် ကုမ္ပဏီတစ်ခု သို့မဟုတ် တရားဝင်အဖွဲ့အစည်းတစ်ခု၏ ကိုယ်စားလှယ်အဖြစ် ဝန်ဆောင်မှုများကို အသုံးပြုပါက၊ သင်သည် အဖွဲ့အစည်းကို ဤမူဝါဒများနှင့် ဆိုင်ရာတာဝန်များကို လိုက်နာရန် အာဏာရှိကြောင်း ကိုယ်စားပြုသည်ဟု ထင်မြင်နိုင်ပါသည်။',
                      style: languageProvider.lan == 'English'
                      ?
                      const TextStyle(
                        fontSize: 10,
                        fontFamily: 'Bricolage-R',
                        color: Color(0xFF6C757D),
                      ) : const TextStyle(
                        fontSize: 10,
                        fontFamily: 'Walone_R',
                        color: Color(0xFF6C757D),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      languageProvider.lan == 'English'
                      ?
                      '2. User Registration' : '၂။ အသုံးပြုသူမှတ်ပုံတင်ခြင်း',
                      style: languageProvider.lan == 'English'
                      ?
                      const TextStyle(
                        fontSize: 12.5,
                        fontFamily: 'Bricolage-M',
                        color: Color(0xFF363B3F),
                      ) :const TextStyle(
                        fontSize: 11,
                        fontFamily: 'Walone-B',
                        color: Color(0xFF363B3F),
                      ) ,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      languageProvider.lan == 'English'
                      ?
                      'To access certain features of the Services, you must register for an account. When registering, you agree to provide accurate, current, and complete information and to update such information as necessary to keep it accurate, current, and complete. You are responsible for maintaining the confidentiality of your account login information and for all activities that occur under your account.' : 'ဝန်ဆောင်မှုများ၏ အချို့သော လုပ်ဆောင်ချက်များကို ဝင်ရောက်ရန် သင်သည် အကောင့်တစ်ခုကို မှတ်ပုံတင်ရန် လိုအပ်ပါသည်။ မှတ်ပုံတင်ခြင်းအတွက်၊ သင်သည် တိကျ၊ လက်ရှိနှင့် လုံးဝပြည့်စုံသော အချက်အလက်များပေးရန် သဘောတူပါသည်။ ထိုအချက်အလက်များကို အချိန်နှင့်တပြေးညီ နောက်ထပ်သိပ်တိုးသော အချက်အလက်များနှင့် အတူ အတိအကျပေးရန် တာဝန်ရှိသည်။ သင်၏ အကောင့်လော့ဂင်အချက်အလက်များကို ထိန်းသိမ်းရန်နှင့် သင်၏ အကောင့်အောက်တွင် အကောင့်အသုံးပြုမှုများ၏ တာဝန်ရှိခြင်းကို တာဝန်ယူပါ။',
                      style: languageProvider.lan == 'English'
                      ?
                      const TextStyle(
                        fontSize: 10,
                        fontFamily: 'Bricolage-R',
                        color: Color(0xFF6C757D),
                      ) : const TextStyle(
                        fontSize: 10,
                        fontFamily: 'Walone_R',
                        color: Color(0xFF6C757D),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      languageProvider.lan == 'English'
                      ?
                      '3. Use of Service' : '၃။ ဝန်ဆောင်မှုများအသုံးပြုခြင်း',
                     style: languageProvider.lan == 'English'
                      ?
                      const TextStyle(
                        fontSize: 12.5,
                        fontFamily: 'Bricolage-M',
                        color: Color(0xFF363B3F),
                      ) :const TextStyle(
                        fontSize: 11,
                        fontFamily: 'Walone-B',
                        color: Color(0xFF363B3F),
                      ) ,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      languageProvider.lan == 'English'
                      ?
                      'You agree to use the Services only for lawful purposes and in accordance with these Terms. You agree not to use the Services:': 'သင်သည် ဤဝန်ဆောင်မှုများကို ဥပဒေပြုလုပ်ထားသော ရည်ရွယ်ချက်များအတွက်သာ အသုံးပြုရန် သဘောတူပါသည်။ သင်သည် ဤဝန်ဆောင်မှုများကို အသုံးပြုရန် အောက်ပါကဲ့သို့ မလုပ်ပေးရန် သဘောတူပါသည်။',
                       style: languageProvider.lan == 'English'
                      ?
                      const TextStyle(
                        fontSize: 10,
                        fontFamily: 'Bricolage-R',
                        color: Color(0xFF6C757D),
                      ) : const TextStyle(
                        fontSize: 10,
                        fontFamily: 'Walone_R',
                        color: Color(0xFF6C757D),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const BulletInfo(
                        infoTextStyle: infoTextStyle,
                        text:
                            'To post any job listings or other content that is false, misleading, or otherwise deceptive.',
                        padding: 0,
                        infoTextStylemm: infoTextStyleMn,
                        textmm:
                            'အမှား၊ မမှန်ကန်သော သို့မဟုတ် အခြားသော လိမ္မာမှုမရှိသော အလုပ်ဖော်ပြချက်များ သို့မဟုတ် အကြောင်းအရာများကို ပေါ်ပြူလာသွားရန်',
                        paddingmm: 10),
                         const BulletInfo(
                        infoTextStyle: infoTextStyle,
                        text:
                            'To post any content that is illegal, offensive, defamatory, or otherwise inappropriate.',
                        padding: 0,
                        infoTextStylemm: infoTextStyleMn,
                        textmm:
                            'ဥပဒေအရ မမှန်၊ အပြစ်တင်ခြင်း၊ ဆန့်ကျင်မှုရှိသော သို့မဟုတ် အခြားသော မသင့်တော်သော အကြောင်းအရာများကို ပေါ်ပြူလာသွားရန်',
                        paddingmm: 10),
                         const BulletInfo(
                        infoTextStyle: infoTextStyle,
                        text:
                            'To violate any applicable local, state, national, or international law.',
                        padding: 0,
                        infoTextStylemm: infoTextStyleMn,
                        textmm:
                            'ဒေသခံ၊ ပြည်နယ်၊ အမျိုးသား သို့မဟုတ် အပြည်ပြည်ဆိုင်ရာ ဥပဒေများကို ချိုးဖောက်ရန်',
                        paddingmm: 10),
                        const BulletInfo(
                        infoTextStyle: infoTextStyle,
                        text:
                            'To transmit any viruses, malware, or other harmful software.',
                        padding: 0,
                        infoTextStylemm: infoTextStyleMn,
                        textmm:
                            'ဗိုင်းရပ်စ်များ၊ မော်လ်ဝဲများ သို့မဟုတ် အခြားသော အန္တရာယ်ဖြစ်စေသော ဆော့ဖ်ဝဲများပို့ဆောင်ရန်',
                        paddingmm: 10),
                        const BulletInfo(
                        infoTextStyle: infoTextStyle,
                        text:
                            'To collect or store personal information about other users without their consent.',
                        padding: 0,
                        infoTextStylemm: infoTextStyleMn,
                        textmm:
                            'အခြားအသုံးပြုသူများ၏ ကိုယ်ရေးအချက်အလက်များကို သူတို့၏ အလွှတ်သတ်မှတ်ချက်မရှိဘဲ စုဆောင်းရန်',
                        paddingmm: 10),

                  ],
                ),
              )
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
