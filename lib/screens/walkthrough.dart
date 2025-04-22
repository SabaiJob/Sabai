import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/change_language_dropdown_button.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/bottom_navi_pages/job_listing_page.dart';
import 'package:sabai_app/screens/auth_pages/log_in_controller_page.dart';
import 'package:sabai_app/screens/auth_pages/registration_pages_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../components/walkthrough_button.dart';
import '../services/language_provider.dart';
import 'dart:async';

class Walkthrough extends StatefulWidget {
  const Walkthrough({super.key});

  @override
  State<Walkthrough> createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  final PageController _controller = PageController();
  Timer? _timer;
  int _currentText = 0;
  bool _forward = true;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        if (_forward) {
          if (_currentText < 3) {
            _currentText++;
          } else {
            _forward = false; // Start moving backward
            _currentText--;
          }
        } else {
          if (_currentText > 0) {
            _currentText--;
          } else {
            _forward = true; // Start moving forward again
            _currentText++;
          }
        }
      });

      _controller.animateToPage(_currentText,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Main content
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Switch Language
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: DropDown(),
                  ),
                ),
                //SizedBox
                const SizedBox(
                  height: 50,
                ),
                //Colum includes Title, Banner, Banner Indicator
                Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    //Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        languageProvider.lan == 'English'
                            ? const Text(
                                'Welcome to',
                                style: walkthroughTitleStyleEng,
                              )
                            : const Text(
                                'Sabai Job',
                                style: sabaiJobStyle,
                              ),
                        //SizedBox
                        const SizedBox(
                          width: 10,
                        ),
                        languageProvider.lan == 'English'
                            ? const Text(
                                'Sabai Job',
                                style: sabaiJobStyle,
                              )
                            : const Text(
                                'မှကြိုဆိုပါတယ်',
                                style: walkthroughTitleStyleMm,
                              ),
                      ],
                    ),
                    // Banner with PageView
                    SizedBox(
                      height: 50,
                      child: PageView(
                        controller: _controller,
                        children: [
                          Center(
                            child: languageProvider.lan == 'English'
                                ? const Text(
                                    'Finding a Job Made Easy',
                                    style: walkthroughIndicatorTextEng,
                                  )
                                : const Text(
                                    'အလုပ်အကိုင်ရှာဖွေမှုကို လွယ်ကူစေတယ်',
                                    style: walkthroughIndicatorTextMm,
                                  ),
                          ),
                          Center(
                            child: languageProvider.lan == 'English'
                                ? const Text(
                                    'Offering Safe, Hassle-Free Jobs',
                                    style: walkthroughIndicatorTextEng,
                                  )
                                : const Text(
                                    'လုံခြုံ အဆင်ပြေတဲ့ အလုပ်အကိုင်တွေရှိတယ်',
                                    style: walkthroughIndicatorTextMm,
                                  ),
                          ),
                          Center(
                            child: languageProvider.lan == 'English'
                                ? const Text(
                                    'Shielding You from Scammers',
                                    style: walkthroughIndicatorTextEng,
                                  )
                                : const Text(
                                    'အလိမ်အညာအလုပ်များကို သေချာစီစစ်ထားတယ်',
                                    style: walkthroughIndicatorTextMm,
                                  ),
                          ),
                          Center(
                            child: languageProvider.lan == 'English'
                                ? const Text(
                                    'Enjoy Job Hunting with Us',
                                    style: walkthroughIndicatorTextEng,
                                  )
                                : const Text(
                                    'အလုပ်အကိုင််ရှာဖွေမှုကို Sabai job နဲ့ပျော်ရွှင်စွာ ပြုလုပ်လိုက်ပါ',
                                    style: walkthroughIndicatorTextMm,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    // Banner Indicator
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 4,
                      effect: const ExpandingDotsEffect(
                        dotHeight: 4,
                        dotWidth: 4,
                        activeDotColor: Color(0xffFF3997),
                      ),
                    ),
                  ],
                ),
                //Colum includes description, Get Sign Up, Log In, Continue as Guest buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      languageProvider.lan == 'English'
                          // description in Eng
                          ? RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                text: 'By registering, you accept our ',
                                style: walkthroughDescriptionEng,
                                children: [
                                  TextSpan(
                                    text: 'Terms and Conditions of \nUse ',
                                    style: walkthroughDescriptionBoldEng,
                                  ),
                                  TextSpan(
                                    text: 'and our ',
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy.',
                                    style: walkthroughDescriptionBoldEng,
                                  ),
                                ],
                              ),
                            )
                          // description in Mm
                          : RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                  text:
                                      'စာရင်းသွင်းခြင်းဖြင့် သင့်အနေနှင့် ကျွန်ုပ်တို့၏',
                                  style: walkthroughDescriptionMm,
                                  children: [
                                    TextSpan(
                                      text:
                                          'အသုံးပြုမှုစည်းမျဉ်းများနှင့်\nကိုယ်ရေးအချက်အလက်မူဝါဒ',
                                      style: walkthroughDescriptionBoldMm,
                                    ),
                                    TextSpan(
                                      text: 'ကို လက်ခံသည်ဟု ယူဆပါသည်',
                                      style: walkthroughDescriptionMm,
                                    ),
                                  ]),
                            ),
                      //SizedBox
                      const SizedBox(
                        height: 15,
                      ),
                      //Sign Up
                      Button(
                        languageProvider: languageProvider,
                        textEng: 'Sign Up',
                        textMm: 'အကောင့်အသစ်ပြုလုပ်ရန်',
                        color: primaryPinkColor,
                        widget: const RegistrationPagesController(),
                        tColor: Colors.white,
                        bColor: primaryPinkColor,
                        isGuest: false,
                      ),
                      //SizedBox
                      const SizedBox(
                        height: 13,
                      ),
                      //Log in
                      Button(
                        languageProvider: languageProvider,
                        textEng: 'Log In',
                        textMm: '၀င်ရောက်ရန်',
                        color: Colors.white,
                        widget: const LogInControllerPage(),
                        tColor: primaryPinkColor,
                        bColor: primaryPinkColor,
                        isGuest: false,
                      ),
                      //SizedBox
                      const SizedBox(
                        height: 13,
                      ),
                      //Continue as Guest
                      Button(
                        languageProvider: languageProvider,
                        textEng: 'Continue as guest',
                        textMm: 'ဧည့်သည်အဖြစ် ဆက်သွားပါ',
                        color: backgroundColor,
                        widget: const JobListingPage(),
                        tColor: primaryPinkColor,
                        bColor: Colors.transparent,
                        isGuest: true,
                      ),
                      //SizedBox
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
