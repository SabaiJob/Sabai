import 'package:flutter/material.dart';
import 'package:sabai_app/screens/bottom_navi_pages/save_jobs.dart';
import 'package:sabai_app/screens/pricing_plan.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    List<String> languages = ['English', 'Myanmar'];
    List<bool> isSelected =
        languages.map((lang) => lang == languageProvider.lan).toList();
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
                  "Profile",
                  style: appBarTitleStyleEng,
                )
              : const Text(
                  'ပရိုဖိုင်',
                  style: appBarTitleStyleMn,
                ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color(0xFFFF3997),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFFFFEBF6),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFFED7EA),
                              width: 3,
                            )),
                        padding: const EdgeInsets.all(3),
                        child: const Icon(
                          Icons.edit,
                          color: Color(0xFFFF3997),
                          size: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Cameron Williamson',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Bricolage-B',
                      fontSize: 12.5,
                    )),
                const SizedBox(
                  height: 5,
                ),
            
                Text(
                    languageProvider.lan == 'English'
                        ? '+66 45789032'
                        : '+၆၆ ၆၇၂၈၁၉၃၂',
                    style: languageProvider.lan == 'English'
                        ? const TextStyle(
                            color: Color(0xFF6C757D),
                            fontFamily: 'Bricolage-R',
                            fontSize: 10,
                          )
                        : const TextStyle(
                            color: Color(0xFF6C757D),
                            fontFamily: 'Walone-B',
                            fontSize: 10,
                          )),
                const SizedBox(
                  height: 20,
                ),
            
                // Box 1
                Container(
                  width: double.infinity,
                  height: 75,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0F1F2),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'images/give_heart.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  languageProvider.lan == 'English'
                                      ? 'My Contributions'
                                      : 'ကျွန်တော့်ကူညီမှုများ',
                                  style: languageProvider.lan == 'English'
                                      ? const TextStyle(
                                          color: Color(0xFF565E64),
                                          fontFamily: 'Bricolage-R',
                                          fontSize: 10,
                                        )
                                      : const TextStyle(
                                          color: Color(0xFF565E64),
                                          fontFamily: 'Walone-B',
                                          fontSize: 10,
                                        ),
                                ),
                                Text(
                                  languageProvider.lan == 'English'
                                      ? '8 Posts'
                                      : '၈ ပိုစ့်',
                                  style: languageProvider.lan == 'English'
                                      ? const TextStyle(
                                          color: Color(0xFF2B2F32),
                                          fontFamily: 'Bricolage-B',
                                          fontSize: 10,
                                        )
                                      : const TextStyle(
                                          color: Color(0xFF2B2F32),
                                          fontFamily: 'Walone-B',
                                          fontSize: 10,
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 43,
                        color: const Color(0xFFE2E3E5),
                      ),
                      SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            languageProvider.lan == 'English'
                                ? RichText(
                                    text: const TextSpan(children: [
                                      TextSpan(
                                          text: 'Got ',
                                          style: TextStyle(
                                            color: Color(0xFF565E64),
                                            fontFamily: 'Bricolage-R',
                                            fontSize: 10,
                                          )),
                                      TextSpan(
                                          text: '46 ',
                                          style: TextStyle(
                                            color: Color(0xFF2B2F32),
                                            fontFamily: 'Bricolage-B',
                                            fontSize: 10,
                                          )),
                                      TextSpan(
                                          text: 'roses',
                                          style: TextStyle(
                                            color: Color(0xFF565E64),
                                            fontFamily: 'Bricolage-R',
                                            fontSize: 10,
                                          )),
                                    ]),
                                  )
                                : RichText(
                                    text: const TextSpan(children: [
                                      TextSpan(
                                          text: 'နှင်းဆီ ',
                                          style: TextStyle(
                                            color: Color(0xFF565E64),
                                            fontFamily: 'Walone-R',
                                            fontSize: 10,
                                          )),
                                      TextSpan(
                                          text: '၄၆ပွင့် ',
                                          style: TextStyle(
                                            color: Color(0xFF2B2F32),
                                            fontFamily: 'Walone-B',
                                            fontSize: 10,
                                          )),
                                      TextSpan(
                                          text: 'ရခဲ့ပြီ',
                                          style: TextStyle(
                                            color: Color(0xFF565E64),
                                            fontFamily: 'Walone-R',
                                            fontSize: 10,
                                          )),
                                    ]),
                                  ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
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
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
            
                const SizedBox(height: 16),
            
                // Box 2
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0F1F2),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    children: [
                      // saved jobs
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15),
                        leading: const Icon(
                          CupertinoIcons.heart,
                          size: 23,
                          color: Color(0xFFFF3997),
                        ),
                        title: Text(
                          languageProvider.lan == 'English'
                              ? 'Saved Jobs'
                              : 'သိမ်းထားသည့်အလုပ်များ',
                          style: languageProvider.lan == 'English'
                              ? const TextStyle(
                                  fontFamily: 'Bricolage-M',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                )
                              : const TextStyle(
                                  fontFamily: 'Walone-B',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                ),
                        ),
                        trailing: const Icon(CupertinoIcons.right_chevron,
                            size: 23, color: Color(0xFFFF3997)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SaveJobs()));
                        },
                      ),
                      const SizedBox(
                        width: 311,
                        child: Divider(
                          color: Color(0xFFE2E3E5),
                        ),
                      ),
                      // Rewards
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15),
                        leading: const Icon(
                          CupertinoIcons.gift,
                          size: 23,
                          color: Color(0xFFFF3997),
                        ),
                        title: Text(
                          languageProvider.lan == 'English'
                              ? 'Rewards'
                              : 'ဆုများ',
                          style: languageProvider.lan == 'English'
                              ? const TextStyle(
                                  fontFamily: 'Bricolage-M',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                )
                              : const TextStyle(
                                  fontFamily: 'Walone-B',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                ),
                        ),
                        trailing: const Icon(CupertinoIcons.right_chevron,
                            size: 23, color: Color(0xFFFF3997)),
                      ),
                    ],
                  ),
                ),
            
                const SizedBox(height: 16),
            
                // Box 3
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0F1F2),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Pricing Plan
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15),
                        leading: const Icon(
                          CupertinoIcons.money_dollar_circle,
                          size: 23,
                          color: Color(0xFFFF3997),
                        ),
                        title: Text(
                          languageProvider.lan == 'English'
                              ? 'Pricing Plan'
                              : 'အကောင့်အမျိုးစား',
                          style: languageProvider.lan == 'English'
                              ? const TextStyle(
                                  fontFamily: 'Bricolage-M',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                )
                              : const TextStyle(
                                  fontFamily: 'Walone-B',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                ),
                        ),
                        trailing: Container(
                          width: 45,
                          height: 15,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEAF6EC),
                            border: Border(
                              top: BorderSide(
                                width: 1.0,
                                color: Color(0xFFD3D6D8),
                              ),
                              left: BorderSide(
                                width: 1.0,
                                color: Color(0xFFD3D6D8),
                              ),
                              bottom: BorderSide(
                                width: 1.0,
                                color: Color(0xFFD3D6D8),
                              ),
                              right: BorderSide(
                                width: 1.0,
                                color: Color(0xFFD3D6D8),
                              ),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF28A745),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                languageProvider.lan == 'English'
                                    ? 'Free'
                                    : 'အခမဲ့',
                                style: languageProvider.lan == 'English'
                                    ? const TextStyle(
                                        fontFamily: 'Bricolage-R',
                                        fontSize: 9,
                                      )
                                    : const TextStyle(
                                        fontFamily: 'Walone-B',
                                        fontSize: 10,
                                      ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PricingPlan()));
                        },
                      ),
                      const SizedBox(
                        width: 311,
                        child: Divider(
                          color: Color(0xFFE2E3E5),
                        ),
                      ),
                      // Language
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15),
                        leading: const Icon(
                          CupertinoIcons.globe,
                          size: 23,
                          color: Color(0xFFFF3997),
                        ),
                        title: Text(
                          languageProvider.lan == 'English'
                              ? 'Language'
                              : 'ဘာသာစကား',
                          style: languageProvider.lan == 'English'
                              ? const TextStyle(
                                  fontFamily: 'Bricolage-M',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                )
                              : const TextStyle(
                                  fontFamily: 'Walone-B',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                ),
                        ),
                        trailing: ToggleButtons(
                          constraints: const BoxConstraints(
                            maxWidth: double.infinity,
                            minWidth: 25,
                            minHeight: 20,
                            maxHeight: double.infinity,
                          ),
                          fillColor: const Color(0xFFFF3997),
                          isSelected: isSelected,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          color: Colors.black,
                          onPressed: (int index) {
                            languageProvider.setLan(languages[index]);
                          },
                          children: [
                            Image.asset(
                              'icons/uk.png',
                              width: 15,
                              height: 15,
                            ),
                            Image.asset(
                              'icons/myanmar.png',
                              width: 15,
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            
                const SizedBox(height: 16),
            
                // Box 4
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0F1F2),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Help & Support
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15),
                        leading: const Icon(
                          CupertinoIcons.question_circle,
                          size: 23,
                          color: Color(0xFFFF3997),
                        ),
                        title: Text(
                            languageProvider.lan == 'English'
                                ? 'Help & Support'
                                : 'အကူညီ',
                            style: languageProvider.lan == 'English'
                                ? const TextStyle(
                                    fontFamily: 'Bricolage-M',
                                    fontSize: 10,
                                    color: Color(0xFF2B2F32),
                                  )
                                : const TextStyle(
                                    fontFamily: 'Walone-B',
                                    fontSize: 10,
                                    color: Color(0xFF2B2F32),
                                  )),
                        trailing: const Icon(CupertinoIcons.right_chevron,
                            size: 23, color: Color(0xFFFF3997)),
                      ),
            
                      const SizedBox(
                        width: 311,
                        child: Divider(
                          color: Color(0xFFE2E3E5),
                        ),
                      ),
            
                      // Terms and Conditions
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15),
                        leading: const Icon(
                          CupertinoIcons.doc_text,
                          size: 23,
                          color: Color(0xFFFF3997),
                        ),
                        title: Text(
                          languageProvider.lan == 'English'
                              ? 'Terms and Conditions'
                              : 'ထုတ်ပြန်ချက်နှင့် ရေးရာမူဝါဒ',
                          style: languageProvider.lan == 'English'
                              ? const TextStyle(
                                  fontFamily: 'Bricolage-M',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                )
                              : const TextStyle(
                                  fontFamily: 'Walone-B',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                ),
                        ),
                        trailing: const Icon(CupertinoIcons.right_chevron,
                            size: 23, color: Color(0xFFFF3997)),
                      ),
            
                      const SizedBox(
                        width: 311,
                        child: Divider(
                          color: Color(0xFFE2E3E5),
                        ),
                      ),
            
                      // Privacy Policy
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15),
                        leading: const Icon(
                          CupertinoIcons.checkmark_shield,
                          size: 23,
                          color: Color(0xFFFF3997),
                        ),
                        title: Text(
                          languageProvider.lan == 'English'
                              ? 'Privacy Policy'
                              : 'ကိုယ်ရေးအချက်အလက် မူဝါဒ',
                          style: languageProvider.lan == 'English'
                              ? const TextStyle(
                                  fontFamily: 'Bricolage-M',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                )
                              : const TextStyle(
                                  fontFamily: 'Walone-B',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                ),
                        ),
                        trailing: const Icon(CupertinoIcons.right_chevron,
                            size: 23, color: Color(0xFFFF3997)),
                      ),
            
                      const SizedBox(
                        width: 311,
                        child: Divider(
                          color: Color(0xFFE2E3E5),
                        ),
                      ),
            
                      // about sabai jobs
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15),
                        leading: const Icon(
                          CupertinoIcons.info,
                          size: 23,
                          color: Color(0xFFFF3997),
                        ),
                        title: Text(
                          languageProvider.lan == 'English'
                              ? 'About Sabai Jobs'
                              : 'Sabai Jobs အကြောင်း',
                          style: languageProvider.lan == 'English'
                              ? const TextStyle(
                                  fontFamily: 'Bricolage-M',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                )
                              : const TextStyle(
                                  fontFamily: 'Walone-B',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                ),
                        ),
                        trailing: const Icon(CupertinoIcons.right_chevron,
                            size: 23, color: Color(0xFFFF3997)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    fixedSize: const Size(double.infinity,52),
                    backgroundColor: const Color(0xFFF0F1F2),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Set the border radius
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.logout,
                        color: Color(0xFFFF3997),
                        size: 23,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      languageProvider.lan == 'English'
                          ? const Text(
                              'Log Out',
                              style: TextStyle(
                                fontFamily: 'Bricolage-M',
                                fontSize: 10,
                                color: Color(0xFF2B2F32),
                              ),
                            )
                          : const Text(
                              'အကောင့်မှထွက်မည်',
                              style: TextStyle(
                                fontFamily: 'Walone-B',
                                fontSize: 10,
                                color: Color(0xFF2B2F32),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
