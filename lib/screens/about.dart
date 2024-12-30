import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../services/language_provider.dart';

class About extends StatelessWidget {
  const About({super.key});

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
        title: const Text(
          'About Sabai Job',
          style: appBarTitleStyleEng,
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
                'images/about.png',
                width: 89,
                height: 132,
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
                              'Out Mission',
                              style: labelTextStyle,
                            )
                          : const Text(
                              'ကျွန်ုပ်တို့၏ ရည်ရွယ်ချက်',
                              style: labelTextStyleMm,
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      languageProvider.lan == 'English'
                          ? const Text(
                              'At Sabai Jobs, our mission is to connect blue-collar job seekers in Thailand with reliable and rewarding employment opportunities. We strive to bridge the gap between employers and job seekers by providing a user-friendly platform that makes job searching and hiring efficient, transparent, and accessible for everyone.',
                              style: infoTextStyle,
                            )
                          : const Text(
                              'ကျွန်ုပ်တို့၏ တာဝန် Sabai Jobs တွင် ကျွန်ုပ်တို့၏ တာဝန်မှာ ထိုင်းနိုင်ငံတွင် လုပ်ငန်းရှင်လက်မှတ်ပြုထားသော သန့်ရှင်းပြီး အကျိုးပြုသော အလုပ်အကိုင် အခွင့်အလမ်းများနှင့် မျှဝေသော အလုပ်ရှာဖွေရေး platform တစ်ခုကို ဖန်တီးခြင်းဖြင့် အလုပ်ရှင်များနှင့် အလုပ်ရှာဖွေသူများအကြား ရှားပါးသော အခွင့်အလမ်းများကို ပေါင်းစပ်ပေးခြင်း ဖြစ်ပါသည်။',
                              style: infoTextStyleMn,
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      languageProvider.lan == 'English'
                          ? const Text(
                              'Who we are',
                              style: labelTextStyle,
                            )
                          : const Text(
                              'ကျွန်ုပ်တို့မှာ ဘာလဲ',
                              style: labelTextStyleMm,
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      languageProvider.lan == 'English'
                          ? const Text(
                              'Sabai Jobs is a dedicated job portal focused on the blue-collar job market in Thailand. We understand the unique challenges faced by both job seekers and employers in this sector, and we are committed to addressing these challenges through innovative solutions and a customer-centric approach.',
                              style: infoTextStyle,
                            )
                          : const Text(
                              'Sabai Jobs သည် ထိုင်းနိုင်ငံ၏ ဘလူးကောလာအလုပ်ဈေးကွက်ကို အာရုံစိုက်ထားသည့် အလုပ်ရှာဖွေရေး portal တစ်ခုဖြစ်ပါသည်။ ကျွန်ုပ်တို့သည် အလုပ်ရှာဖွေသူများနှင့် အလုပ်ရှင်များနှစ်ပါးအတွက် ကြုံတွေ့ရသော ထူးခြားသော အခက်အခဲများကို နားလည်ပြီး ဤအခက်အခဲများကို အဆင့်မြင့်သော ဖြေရှင်းနည်းများနှင့် ဖောက်သည်အကဲခတ်ထားသော နည်းလမ်းများဖြင့် ဖြေရှင်းရန် သတိပေးပါသည်။',
                              style: infoTextStyleMn,
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      languageProvider.lan == 'English'
                          ? const Text(
                              'What we offer',
                              style: labelTextStyle,
                            )
                          : const Text(
                              'အလုပ်ရှာဖွေသူများအတွက်',
                              style: labelTextStyleMm,
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      languageProvider.lan == 'English'
                          ? const Text(
                              'For Job Seekers',
                              style: infoTextStyle,
                            )
                          : const SizedBox(),
                      const BulletInfo(
                        padding: 40,
                        infoTextStyle: infoTextStyle,
                        text:
                            'Easy Registration: Our simple and straightforward registration process helps you get started quickly. Provide your basic information, upload necessary documents, and set up your profile in just a few steps.',
                        inforTextStyleMm: infoTextStyleMn,
                        paddingMm: 40,
                        textmm:
                            'လွယ်ကူသော စာရင်းသွင်းခြင်း: ကျွန်ုပ်တို့၏ လွယ်ကူပြီး တိကျသော စာရင်းသွင်းခြင်းလုပ်ငန်းစဉ်သည် သင်၏ အလုပ်ရှာဖွေရေးကို လျှင်မြန်စွာ စတင်နိုင်စေပါသည်။ သင်၏ အခြေခံအချက်အလက်များကို ထည့်သွင်းပြီး လိုအပ်သော စာရွက်စာတမ်းများကို တင်ပေးပြီး ပရိုဖိုင်ကို ဖွဲ့စည်းလိုက်ပါ။',
                      ),
                      const BulletInfo(
                        padding: 25,
                        text:
                            'Job Listings: Access a wide range of job opportunities across various industries, including construction, manufacturing, logistics, hospitality, and more.',
                        infoTextStyle: infoTextStyle,
                        inforTextStyleMm: infoTextStyleMn,
                        paddingMm: 25,
                        textmm:
                            'အလုပ်အကိုင်စာရင်းများ: ဆောက်လုပ်ရေး၊ ထုတ်လုပ်ရေး၊ သယ်ယူပို့ဆောင်ရေး၊ ဖျော်ဖြေမှုစရင်းများနှင့် အခြားစက်မှုလုပ်ငန်းများတွင် အလုပ်အကိုင်အခွင့်အလမ်းများ ရရှိနိုင်ပါသည်။',
                      ),
                      const BulletInfo(
                        padding: 25,
                        infoTextStyle: infoTextStyle,
                        text:
                            'Profile Setup: Create a detailed profile highlighting your skills, experience, and preferences to attract potential employers.',
                        inforTextStyleMm: infoTextStyleMn,
                        paddingMm: 25,
                        textmm:
                            'ပရိုဖိုင်း setup: သင်၏ ကျွမ်းကျင်မှုများ၊ အတွေ့အကြုံများနှင့် ကြိုက်နှစ်သက်မှုများကို ဖော်ပြထားသော ပရိုဖိုင်းကို ဖွဲ့စည်းပါ၊ ထိုကွောင့် အလုပ်ရှင်များ၏ အားသာချက်ကို ဆွဲဆောင်နိုင်ပါသည်။',
                      ),
                      const BulletInfo(
                        padding: 25,
                        infoTextStyle: infoTextStyle,
                        text:
                            'Application Tracking: Keep track of your job applications and get updates on their status directly through our platform.',
                        inforTextStyleMm: infoTextStyleMn,
                        paddingMm: 25,
                        textmm:
                            'လျှောက်လွှာသိမ်းဆည်းခြင်း: သင်၏ အလုပ်လျှောက်လွှာများကို အလွယ်တကူစစ်ဆေး၍ မည်သည့်အနေအထားတွင်ရှိကြောင်း လက်ရှိအခြေအနေကို သိရှိနိုင်ပါသည်။',
                      ),
                      const BulletInfo(
                        infoTextStyle: infoTextStyle,
                        text:
                            'Support and Guidance: Receive support and guidance through every step of your job search, from creating your profile to preparing for interviews.',
                        padding: 25,
                        inforTextStyleMm: infoTextStyleMn,
                        paddingMm: 15,
                        textmm:
                            'ပံ့ပိုးမှုနှင့် လမ်းညွှန်မှု: ပရိုဖိုင်းဖွဲ့စည်းခြင်းမှစ၍ အင်တာဗျူး ပြင်ဆင်မှုအထိ သင်၏ အလုပ်ရှာဖွေရေးအတွက် အကြံဉာဏ်နှင့် ပံ့ပိုးမှုရရှိပါသည်။',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'For Employers',
                        style: infoTextStyle,
                      ),
                      const BulletInfo(
                        infoTextStyle: infoTextStyle,
                        text:
                            'Efficient Hiring: Post job listings and reach a large pool of qualified candidates quickly and easily.',
                        padding: 10,
                        inforTextStyleMm: infoTextStyleMn,
                        paddingMm: 25,
                        textmm: '',
                      ),
                      const BulletInfo(
                        infoTextStyle: infoTextStyle,
                        text:
                            'Candidate Profiles: Access detailed profiles of job seekers to find the best match for your job requirements.',
                        padding: 15,
                        inforTextStyleMm: infoTextStyleMn,
                        paddingMm: 25,
                        textmm: '',
                      ),
                      const BulletInfo(
                        infoTextStyle: infoTextStyle,
                        text:
                            'Application Management: Manage and track applications seamlessly through our intuitive dashboard.',
                        padding: 15,
                        inforTextStyleMm: infoTextStyleMn,
                        paddingMm: 25,
                        textmm: '',
                      ),
                      const BulletInfo(
                        infoTextStyle: infoTextStyle,
                        text:
                            'Verification Services: Utilize our verification services to ensure the authenticity of candidates\' documents and credentials.',
                        padding: 25,
                        inforTextStyleMm: infoTextStyleMn,
                        paddingMm: 25,
                        textmm: '',
                      ),
                      const BulletInfo(
                        infoTextStyle: infoTextStyle,
                        text:
                            'Customer Support: Get assistance from our dedicated customer support team to address any queries or issues you may encounter.',
                        padding: 25,
                        inforTextStyleMm: infoTextStyleMn,
                        paddingMm: 25,
                        textmm: '',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
    required this.textmm,
    required this.inforTextStyleMm,
    required this.paddingMm,
  });

  final String text;
  final TextStyle infoTextStyle;
  final double padding;
  final String textmm;
  final TextStyle inforTextStyleMm;
  final double paddingMm;

  @override
  Widget build(BuildContext context) {
    var langaugeProvider = Provider.of<LanguageProvider>(context);
    return ListTile(
      minTileHeight: 10,
      horizontalTitleGap: 0,
      minLeadingWidth: 10,
      minVerticalPadding: 0,
      leading: Padding(
        padding: EdgeInsets.only(
          bottom: langaugeProvider.lan == 'English' ? padding : paddingMm,
        ),
        child: const Icon(
          Icons.circle,
          size: 3,
        ),
      ),
      title: langaugeProvider.lan == 'English'
          ? Text(
              text,
              style: infoTextStyle,
            )
          : Text(
              textmm,
              style: inforTextStyleMm,
            ),
    );
  }
}
