import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/reusable_bulletpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:sabai_app/components/tc_dialog.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/services/language_provider.dart';

class JobDetailsPage extends StatefulWidget {
  const JobDetailsPage({super.key});

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F1F2),
        title: const Text(
          'Job Details',
          style: appBarTitleStyleEng,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xffFF3997),
        ),
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(1.0), // Height of the bottom border
          child: Container(
            color: Colors.grey.shade300, // Border color
            height: 1.0, // Border thickness
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Barista',
                style: TextStyle(
                  fontSize: 19.53,
                  fontFamily: 'Bricolage-M',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: 343,
                  height: 228,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Sabai Job Partner Tag
                      Container(
                        width: 116,
                        height: 21,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFEBF6),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8),
                              topLeft: Radius.circular(8)),
                        ),
                        child: Row(
                          children: [
                            const Image(
                              image: AssetImage('images/status.png'),
                              width: 12,
                              height: 12,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            languageProvider.lan == 'English'
                                ? const Text(
                                    'Sabai Job Partner',
                                    style: TextStyle(
                                        fontFamily: 'Bricolage-R',
                                        fontSize: 10,
                                        color: Color(0xFF6C757D)),
                                  )
                                : RichText(
                                    text: const TextSpan(
                                      text: 'Sabai Job  ',
                                      style: TextStyle(
                                        fontFamily: 'Bricolage-R',
                                        fontSize: 10,
                                        color: Color(0xFF6C757D),
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'မိတ်ဖက်',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Walone-B',
                                            color: Color(0xFF6C757D),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Offered by',
                                  style: TextStyle(
                                    color: Color(0xFF6C757D),
                                    fontFamily: 'Bricolage-R',
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'The Walt Disney Company',
                                  style: TextStyle(
                                    color: Color(0xFF4C5258),
                                    fontFamily: 'Bricolage-M',
                                    fontSize: 12.5,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                languageProvider.lan == 'English'
                                    ? const Text(
                                        'Salary',
                                        style: TextStyle(
                                          color: Color(0xFF6C757D),
                                          fontFamily: 'Bricolage-R',
                                          fontSize: 10,
                                        ),
                                      )
                                    : const Text(
                                        'လစာ',
                                        style: TextStyle(
                                          fontFamily: 'Walone-R',
                                          fontSize: 10,
                                          color: Color(0xff6C757D),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 5,
                                ),
                                languageProvider.lan == 'English'
                                    ? const Text(
                                        '18000 ~ 28000 THB',
                                        style: TextStyle(
                                          color: Color(0xFF4C5258),
                                          fontFamily: 'Bricolage-M',
                                          fontSize: 12.5,
                                        ),
                                      )
                                    : const Text(
                                        '၁၈၀၀၀ ~ ၂၈၀၀၀ ဘတ်',
                                        style: TextStyle(
                                          fontFamily: 'Walone-B',
                                          fontSize: 11,
                                          color: Color(0xff4C5258),
                                        ),
                                      ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                languageProvider.lan == 'English'
                                    ? const Text(
                                        'Safety',
                                        style: TextStyle(
                                          color: Color(0xFF6C757D),
                                          fontFamily: 'Bricolage-R',
                                          fontSize: 10,
                                        ),
                                      )
                                    : const Text(
                                        'စိတ်ချရမှု',
                                        style: TextStyle(
                                          fontFamily: 'Walone-R',
                                          fontSize: 10,
                                          color: Color(0xff6C757D),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFEAF6EC),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                  ),
                                  width: 65,
                                  height: 21,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.info_outline,
                                        size: 13,
                                        color: Color(0xFF28A745),
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      languageProvider.lan == 'English'
                                          ? const Text(
                                              'Level - 3',
                                              style: TextStyle(
                                                fontSize: 10,
                                              ),
                                            )
                                          : const Text(
                                              'အဆင့် - ၃',
                                              style: TextStyle(
                                                fontFamily: 'Walone-B',
                                                fontSize: 10,
                                                color: Colors.black,
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                languageProvider.lan == 'English'
                                    ? const Text(
                                        'Location',
                                        style: TextStyle(
                                          color: Color(0xFF6C757D),
                                          fontFamily: 'Bricolage-R',
                                          fontSize: 10,
                                        ),
                                      )
                                    : const Text(
                                        'တည်နေရာ',
                                        style: TextStyle(
                                          fontFamily: 'Walone-R',
                                          fontSize: 10,
                                          color: Color(0xff6C757D),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text('Bangkok',
                                    style: TextStyle(
                                      color: Color(0xFF4C5258),
                                      fontFamily: 'Bricolage-M',
                                      fontSize: 12.5,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              languageProvider.lan == 'English'
                  ? const Text(
                      'Job Summary',
                      style: TextStyle(
                        fontSize: 15.63,
                        fontFamily: 'Bricolage-M',
                        color: Color(0xFF363B3F),
                      ),
                    )
                  : const Text(
                      'အလုပ်အကျဉ်း',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Walone-B',
                        color: Color(0xFF363B3F),
                      ),
                    ),
              const SizedBox(
                height: 12,
              ),
              languageProvider.lan == 'English'
                  ? const Text(
                      'A Barista is responsible for preparing and serving a variety of coffee and tea beverages, ensuring high-quality customer service, and maintaining a clean and organized work environment.',
                      style: TextStyle(
                        fontFamily: 'Bricolage-R',
                        color: Color(0xFF4C5258),
                        fontSize: 12.5,
                      ),
                    )
                  : const Text(
                      'ဘရစ်စတာသည် ကော်ဖီနှင့် လက်ဖက်ရည်အမျိုးမျိုးကို ပြင်ဆင်၍ ဝယ်ယူသူများအား ဝန်ဆောင်မှုအရည်အသွေးမြင့်မားမှုကို အာမခံပေးပြီး၊ အလုပ်ခွင်ကို သန့်ရှင်းပြီး စီမံခန့်ခွဲထားသောနေရာတစ်ခုအဖြစ် ထိန်းသိမ်းရမည်။',
                      style: TextStyle(
                        fontFamily: 'Walone-B',
                        color: Color(0xFF4C5258),
                        fontSize: 11,
                      ),
                    ),
              const SizedBox(
                height: 16,
              ),
              languageProvider.lan == 'English'
                  ? const Text(
                      'Responsibilities',
                      style: TextStyle(
                        fontSize: 15.63,
                        fontFamily: 'Bricolage-M',
                        color: Color(0xFF363B3F),
                      ),
                    )
                  : const Text(
                      'အဓိကတာဝန်များ',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Walone-B',
                        color: Color(0xFF363B3F),
                      ),
                    ),
              const SizedBox(
                height: 12,
              ),
              languageProvider.lan == 'English'
                  ? const ReusableBulletPoints(
                      content:
                          'Prepare and serve a variety of coffee and tea beverages, following standardized recipes.')
                  : const ReusableBulletPoints(
                      content:
                          'ကော်ဖီနှင့် လက်ဖက်ရည်အမျိုးမျိုးကို ပြင်ဆင်၍ ဝန်ဆောင်မှုများ ပြုလုပ်ရန်၊ သတ်မှတ်ထားသောချက်ပြုတ်နည်းများအတိုင်း။'),
              languageProvider.lan == 'English'
                  ? const ReusableBulletPoints(
                      content:
                          ' Take customer orders and provide product recommendations.')
                  : const ReusableBulletPoints(
                      content:
                          ' ဝယ်ယူသူများ၏အော်ဒါများကို လက်ခံပြီး ထုတ်ကုန်အကြံပြုချက်များ ပေးရန်။'),
              languageProvider.lan == 'English'
                  ? const ReusableBulletPoints(
                      content:
                          'Operate coffee-making equipment, including espresso machines, grinders, and brewing devices.')
                  : const ReusableBulletPoints(
                      content:
                          'ကော်ဖီပြုတ်စက်များ၊ အက်စ်ပရက်ဆိုးစက်များ၊ ဂရိုင်ဒါများနှင့် တီပြုတ်စက်များကို ပြုလုပ်ရန်။'),
              languageProvider.lan == 'English'
                  ? const ReusableBulletPoints(
                      content:
                          'Handle customer transactions, including cash and credit card payments.')
                  : const ReusableBulletPoints(
                      content:
                          'ဝယ်ယူသူငွေပေးချေမှုများ၊ ငွေသားနှင့် ခရက်ဒစ်ကဒ်ပေးချေမှုများကို ဆောင်ရွက်ရန်။'),
              languageProvider.lan == 'English'
                  ? const ReusableBulletPoints(
                      content:
                          'Maintain a clean and organized work environment, including regular cleaning of equipment and customer areas.')
                  : const ReusableBulletPoints(
                      content:
                          'အလုပ်ခွင်ကို သန့်ရှင်းပြီး စီမံခန့်ခွဲထားရန်၊ စက်ပစ္စည်းများနှင့် ဝယ်ယူသူများနေရာများကို ပုံမှန် သန့်ရှင်းရန်။'),
              languageProvider.lan == 'English'
                  ? const ReusableBulletPoints(
                      content:
                          'Follow food safety and sanitation guidelines to ensure a safe and hygienic workspace.')
                  : const ReusableBulletPoints(
                      content:
                          'အစားအစာလုံခြုံရေးနှင့် သန့်ရှင်းရေးဆိုင်ရာ လမ်းညွှန်ချက်များကို လိုက်နာ၍ လုံခြုံပြီး ကျန်းမာသန့်ရှင်းသော အလုပ်ခွင်ကို အာမခံရန်။'),
              const SizedBox(
                height: 16,
              ),
              languageProvider.lan == 'English'
                  ? const Text(
                      'Qualifications',
                      style: TextStyle(
                        fontSize: 15.63,
                        fontFamily: 'Bricolage-M',
                        color: Color(0xFF363B3F),
                      ),
                    )
                  : const Text(
                      'လိုအပ်သောအရည်အချင်းများ',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Walone-B',
                        color: Color(0xFF363B3F),
                      ),
                    ),
              const SizedBox(
                height: 12,
              ),
              languageProvider.lan == 'English'
                  ? const ReusableBulletPoints(
                      content:
                          'Excellent communication and interpersonal skills.')
                  : const ReusableBulletPoints(
                      content:
                          'အရည်အချင်းပြည့်မီသော ဆက်ဆံရေးနှင့် ဆက်သွယ်ခြင်းကျွမ်းကျင်မှုများ။'),
              languageProvider.lan == 'English'
                  ? const ReusableBulletPoints(
                      content:
                          'Being Fluent in Thai language and English language ')
                  : const ReusableBulletPoints(
                      content:
                          'ထိုင်းဘာသာနှင့် အင်္ဂလိပ်ဘာသာ ကျွမ်းကျင်စွာ ပြောဆိုနိုင်ခြင်း။'),
              languageProvider.lan == 'English'
                  ? const ReusableBulletPoints(
                      content:
                          'Passion for coffee and a willingness to learn about different brewing methods.')
                  : const ReusableBulletPoints(
                      content:
                          'ကော်ဖီနှင့် အရသာကို စိတ်အားထက်သန်ပြီး၊ သင်ယူရန် အဆင်ပြေမှုရှိခြင်း။'),
              languageProvider.lan == 'English'
                  ? const ReusableBulletPoints(
                      content:
                          'Ability to work efficiently in a fast-paced environment.')
                  : const ReusableBulletPoints(
                      content: 'အလျင်အမြန်အလုပ်လုပ်နိုင်စွမ်းရှိခြင်း။'),
              languageProvider.lan == 'English'
                  ? const ReusableBulletPoints(
                      content:
                          'Prior experience as a barista or in a customer service role is preferred but not required.')
                  : const ReusableBulletPoints(
                      content:
                          'ဘာရစ်စတာအနေနှင့် သို့မဟုတ် ဝန်ဆောင်မှုအရည်အသွေးဆိုင်ရာ အတွေ့အကြုံရှိသူများအား အကောင်းဆုံး ဝန်ထမ်းတစ်ဦးအဖြစ် ရှိရန်။'),
              languageProvider.lan == 'English'
                  ? const ReusableBulletPoints(
                      content:
                          'Attention to detail and commitment to maintaining high-quality standards.')
                  : const ReusableBulletPoints(
                      content:
                          'အချက်အလက်တိကျစွာ လိုက်နာခြင်းနှင့် အရည်အသွေးမြင့်အဆင့်များကို ထိန်းသိမ်းရန် အကျိုးရှိမှုရှိခြင်း။'),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                width: 343,
                height: 142,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFFE2E3E5),
                      width: 2.0,
                    ),
                    bottom: BorderSide(
                      color: Color(0xFFE2E3E5),
                      width: 2.0,
                    ),
                    left: BorderSide(
                      color: Color(0xFFE2E3E5),
                      width: 2.0,
                    ),
                    right: BorderSide(
                      color: Color(0xFFE2E3E5),
                      width: 2.0,
                    ),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        languageProvider.lan == 'English'
                            ? const Text(
                                'Contributed by',
                                style: TextStyle(
                                  color: Color(0xFF6C757D),
                                  fontFamily: 'Bricolage-R',
                                  fontSize: 10,
                                ),
                              )
                            : const Text(
                                'အလုပ်တင်ပေးသူ',
                                style: TextStyle(
                                  color: Color(0xFF6C757D),
                                  fontFamily: 'Walone-B',
                                  fontSize: 10,
                                ),
                              ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFE2E3E5),
                              width: 2.0,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                          ),
                          width: languageProvider.lan == 'English' ? 78 : 100,
                          height: 25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Image(
                                image: AssetImage('images/rose.png'),
                                width: 12,
                                height: 15.26,
                              ),
                              languageProvider.lan == 'English'
                                  ? const Text(
                                      'Say Thanks',
                                      style: TextStyle(
                                        fontFamily: 'Bricolage-R',
                                        fontSize: 10,
                                        color: Color(0xFFFF4DA1),
                                      ),
                                    )
                                  : const Text(
                                      'ကျေးဇူးတင်ပါသည် ',
                                      style: TextStyle(
                                        fontFamily: 'Walone-B',
                                        fontSize: 10,
                                        color: Color(0xFFFF4DA1),
                                      ),
                                    )
                            ],
                          ),
                        )
                      ],
                    ),
                    const Row(
                      children: [
                        Image(
                          image: AssetImage('images/Lili.png'),
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'LiLi',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontFamily: 'Bricolage-R',
                            color: Color(0xFF6C757D),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 311,
                      child: Divider(),
                    ),
                    Row(
                      children: [
                        languageProvider.lan == 'English'
                            ? const Text(
                                'Interested by',
                                style: TextStyle(
                                  color: Color(0xFF6C757D),
                                  fontFamily: 'Bricolage-R',
                                  fontSize: 10,
                                ),
                              )
                            : const Text(
                                'သင့်လို ယခုအလုပ်ကိုစိတ်ဝင်စားသူများ',
                                style: TextStyle(
                                  color: Color(0xFF6C757D),
                                  fontFamily: 'Walone-B',
                                  fontSize: 10,
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                              left: 0,
                              child: Image(
                                image: AssetImage('images/avatar1.png'),
                                width: 24,
                                height: 24,
                              )),
                          Positioned(
                              left: 12,
                              child: Image(
                                image: AssetImage('images/avatar2.png'),
                                width: 24,
                                height: 24,
                              )),
                          Positioned(
                              left: 24,
                              child: Image(
                                image: AssetImage('images/avatar3.png'),
                                width: 24,
                                height: 24,
                              )),
                          Positioned(
                              left: 36,
                              child: Image(
                                image: AssetImage('images/avatar4.png'),
                                width: 24,
                                height: 24,
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 287,
              height: 42,
              child: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => const TAndCDialog());
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xffFF3997),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Set the border radius
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    languageProvider.lan == 'English'
                        ? const Text(
                            'Apply Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Bricolage-B',
                              fontSize: 15.63,
                            ),
                          )
                        : const Text(
                            'လျှောက်ထားရန်',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Walone-B',
                              fontSize: 14,
                            ),
                          ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Icon(
                      CupertinoIcons.arrow_right,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 40,
              height: 42,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 230, 233, 235),
                        width: 1.5,
                      )),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => const TAndCDialog());
                },
                child: const Image(
                  image: AssetImage('images/share_icon.png'),
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
