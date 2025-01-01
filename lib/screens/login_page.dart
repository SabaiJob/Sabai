import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/reusable_content_holder.dart';
import 'package:sabai_app/components/reusable_label.dart';
import 'package:sabai_app/components/reusable_textformfield.dart';
import 'package:sabai_app/components/reusable_title_holder.dart';
import 'package:sabai_app/screens/bottom_navi_pages/job_listing_page.dart';
import 'package:sabai_app/screens/navigation_homepage.dart';
import 'package:sabai_app/screens/otp_verification_page.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:sabai_app/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xffF7F7F7),
        title: languageProvider.lan == 'English'
            ? const Text(
                'Log In',
                style: appBarTitleStyleEng,
              )
            : const Text(
                '၀င်ရောက်ရန်',
                style: TextStyle(
                  fontFamily: "Bricolage-M",
                  fontSize: 19.53,
                ),
              ),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 30),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: ReusableTitleHolder(
                      title: languageProvider.lan == 'English'
                          ? 'User Registration'
                          : 'အကောင့်က၀င်ရောက်ရန်',
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: ReusableContentHolder(
                        content: languageProvider.lan == 'English'
                            ? 'Lorem ipsum dolor sit amet consectetur. Ut vel nvitae sed quam maecenas cursus pharetra.'
                            : 'သင့်အကောင့်ကို၀င်ရောက်ဖို့ ဒီအချက်အလက်တွေကိုဖြည့်ပါ'),
                  ),
                ),

                // Full Name
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ReusableLabelHolder(
                    labelName: languageProvider.lan == 'English'
                        ? 'Full Name'
                        : 'အမည်',
                    textStyle: languageProvider.lan == 'English'
                        ? labelStyleEng
                        : labelStyleMm,
                    isStarred: true,
                  ),
                ),

                ReusableTextformfield(
                    keyboardType: TextInputType.name,
                    textEditingController: _fullNameController,
                    validating: (value) {
                      if (value == null || value.isEmpty) {
                        return languageProvider.lan == 'English'
                            ? "Full Name is required"
                            : "အမည်အပြည့်အစုံထည့်ရန်လိုအပ်သည်";
                      }
                      return null;
                    },
                    hint: languageProvider.lan == 'English'
                        ? 'Enter your full name'
                        : 'သင့်အမည် ထည့်ပါ'),

                // Phone Number
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ReusableLabelHolder(
                    labelName: languageProvider.lan == 'English'
                        ? 'Phone Number'
                        : 'ဖုန်းနံပါတ်',
                    textStyle: languageProvider.lan == 'English'
                        ? labelStyleEng
                        : labelStyleMm,
                    isStarred: true,
                  ),
                ),

                ReusableTextformfield(
                  formatter: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.phone,
                  textEditingController: _phoneNumberController,
                  validating: (value) {
                    if (value == null || value.isEmpty) {
                      return languageProvider.lan == 'English'
                          ? "Phone Number is required"
                          : "ဖုန်းနံပါတ်ထည့်ရန်လိုအပ်သည်";
                    }
                    return null;
                  },
                  hint: '+66 2134567',
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        Column(
          children: [
            TextButton(
                style: TextButton.styleFrom(
                fixedSize: const Size(375, 42),
                backgroundColor: const Color(0xffFF3997),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8), // Set the border radius
                ),
              ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OtpVerificationPage(
                          navWidget: NavigationHomepage(
                            showButtonSheet: false,
                          ),
                          signUp: false,
                        ),
                      ),
                    );

                    // showDialog(
                    //   context: context,
                    //   barrierDismissible:
                    //       false, // Prevent dismissal by tapping outside
                    //   builder: (context) {
                    //     return const Dialog(
                    //       backgroundColor: Colors.white,
                    //       child: SizedBox(
                    //         width: 170,
                    //         height: 200,
                    //         child: Column(
                    //           children: [
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             SizedBox(
                    //               height: 110,
                    //               width: 110,
                    //               child: Stack(
                    //                 alignment: Alignment.center,
                    //                 children: [
                    //                   SizedBox(
                    //                     height:
                    //                         70, // Outer circle size
                    //                     width: 70,
                    //                     child:
                    //                         CircularProgressIndicator(
                    //                       color: Color(0xffFF3997),
                    //                       strokeWidth:
                    //                           4.0, // Outer circle thickness
                    //                     ),
                    //                   ),
                    //                   SizedBox(
                    //                     height:
                    //                         30, // Inner circle size
                    //                     width: 30,
                    //                     child:
                    //                         CircularProgressIndicator(
                    //                       color: Color(0xffFF3997),
                    //                       strokeWidth:
                    //                           4.0, // Inner circle thickness
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               height: 35,
                    //             ),
                    //             Text(
                    //               'Loggin...',
                    //               style: TextStyle(
                    //                 fontSize: 12.5,
                    //                 fontFamily: 'Bricolage-R',
                    //                 color: Color(0xff41464B),
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // );

                    // Future.delayed(
                    //   const Duration(seconds: 3),
                    //   () {
                    //     Navigator.of(context).pop();
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) =>
                    //             const NavigationHomepage(
                    //           showButtonSheet: false,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // );
                  } 
                  // else {
                  //   // form validation failed
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //         content: languageProvider.lan == 'English'
                  //             ? const Text(
                  //                 "Please complete all the required fields")
                  //             : const Text(
                  //                 "လိုအပ်သောအကွက်များအားလုံးကို ဖြည့်စွက်ပါ။")),
                  //   );
                  // }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    languageProvider.lan == 'English'
                        ? const Text(
                            'Log In',
                            style: TextStyle(
                              fontFamily: 'Bricolage-B',
                              fontSize: 15.63,
                              color: Colors.white,
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
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      CupertinoIcons.arrow_right,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            
          ],
        )
      ],
    );
  }
}
