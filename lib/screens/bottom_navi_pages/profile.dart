import 'package:flutter/material.dart';
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
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
                const Text('Cameron Williamson'),
                const SizedBox(
                  height: 5,
                ),
                const Text('+66 45789032'),
                const SizedBox(
                  height: 20,
                ),
            
                // Box 1
                Container(
                  width: 343,
                  height: 75,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0F1F2),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
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
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('My Contributions'),
                                Text('8 Posts'),
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
                      Container(
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Got 46 roses'),
                           Stack(
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
                  width: 343,
                  height: 104,
                  decoration: const BoxDecoration(
                   color: Color(0xFFF0F1F2),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Saved Jobs
                      GestureDetector(
                        child: const SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.heart, color: Color(0xFFFF3997),),
                              SizedBox(width: 10),
                              Text('Saved Jobs'),
                              SizedBox(width: 150),
                              Icon(CupertinoIcons.right_chevron, color: Color(0xFFFF3997)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 311,
                        child: Divider(
                          color:  Color(0xFFE2E3E5),
                        ),
                      ),
                      GestureDetector(
                        // Rewards
                        child: const SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.gift, color: Color(0xFFFF3997),),
                              SizedBox(width: 10),
                              Text('Rewards   '),
                              SizedBox(width: 150),
                              Icon(CupertinoIcons.right_chevron, color: Color(0xFFFF3997)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            
                const SizedBox(height: 16),
            
                // Box 3
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  width: 343,
                  height: 104,
                  decoration: const BoxDecoration(
                   color: Color(0xFFF0F1F2),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Pricing Plan
                      GestureDetector(
                        child: const SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.money_dollar_circle, color: Color(0xFFFF3997),),
                              SizedBox(width: 10),
                              Text('Pricing Plan'),
                              SizedBox(width: 150),
                              Icon(CupertinoIcons.right_chevron, color: Color(0xFFFF3997)),
                            ],
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const PricingPlan()));
                        },
                      ),
                      const SizedBox(
                        width: 311,
                        child: Divider(
                          color:  Color(0xFFE2E3E5),
                        ),
                      ),
                      GestureDetector(
                        // Language
                        child: const SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.globe, color: Color(0xFFFF3997),),
                              SizedBox(width: 10),
                              Text('Language  '),
                              SizedBox(width: 150),
                              Icon(CupertinoIcons.right_chevron, color: Color(0xFFFF3997)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            
                const SizedBox(height: 16),
            
                // Box 4
                 Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  width: 343,
                  height: 208,
                  decoration: const BoxDecoration(
                   color: Color(0xFFF0F1F2),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Help & Support
                      GestureDetector(
                        child: const SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.question_circle, color: Color(0xFFFF3997),),
                              SizedBox(width: 10),
                              Text('Help & Support'),
                              SizedBox(width: 150),
                              Icon(CupertinoIcons.right_chevron, color: Color(0xFFFF3997)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 311,
                        child: Divider(
                          color:  Color(0xFFE2E3E5),
                        ),
                      ),
                      GestureDetector(
                        // Terms and Conditions
                        child: const SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.doc_text, color: Color(0xFFFF3997),),
                              SizedBox(width: 10),
                              Text('Terms and Conditions'),
                              //here
                              SizedBox(width: 100),
                              Icon(CupertinoIcons.right_chevron, color: Color(0xFFFF3997)),
                            ],
                          ),
                        ),
                      ),
                        const SizedBox(
                        width: 311,
                        child: Divider(
                          color:  Color(0xFFE2E3E5),
                        ),
                      ),
                      GestureDetector(
                        // Privacy Policy
                        child: const SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.checkmark_shield, color: Color(0xFFFF3997),),
                              SizedBox(width: 10),
                              Text('Privacy Policy'),
                              SizedBox(width: 150),
                              Icon(CupertinoIcons.right_chevron, color: Color(0xFFFF3997)),
                            ],
                          ),
                        ),
                      ),
                        const SizedBox(
                        width: 311,
                        child: Divider(
                          color:  Color(0xFFE2E3E5),
                        ),
                      ),
                      GestureDetector(
                        // About Sabai Jobs
                        child: const SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.info, color: Color(0xFFFF3997),),
                              SizedBox(width: 10),
                              Text('About Sabai Jobs'),
                              //here
                              SizedBox(width: 100),
                              Icon(CupertinoIcons.right_chevron, color: Color(0xFFFF3997)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextButton(
                onPressed: () {
                },
                style: TextButton.styleFrom(
                  fixedSize: const Size(343, 52),
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
                    ),
                    const SizedBox(
                      width: 10,
                    ),

                    languageProvider.lan == 'English'
                        ? const Text(
                            'Log Out',
                            style: TextStyle(
                              fontFamily: 'Bricolage-B',
                              fontSize: 15.63,
                              color: Colors.black54,
                            ),
                          )
                        : const Text(
                            'ဆက်လက်ရန်',
                            style: TextStyle(
                              fontFamily: 'Walone-B',
                              fontSize: 14,
                              color: Colors.white,
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

