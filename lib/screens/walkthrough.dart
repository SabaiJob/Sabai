import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/change_language_dropdown_button.dart';
import 'package:sabai_app/screens/login_page.dart';
import 'package:sabai_app/screens/registration_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../services/language_provider.dart';

class Walkthrough extends StatefulWidget {
  const Walkthrough({super.key});

  @override
  State<Walkthrough> createState() => _WalkthroughState();
}

final _controller = PageController();

class _WalkthroughState extends State<Walkthrough> {
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
                // Dropdown at the top
                const Padding(
                  padding: EdgeInsets.only(top: 60, left: 25),
                  child: Align(alignment: Alignment.topLeft, child: DropDown()),
                ),
                const SizedBox(
                  height: 50,
                ),
                // PageView with page indicator
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        languageProvider.lan == 'English'
                            ? const Text(
                                'Welcome to',
                                style: TextStyle(
                                  fontFamily: 'Bricolage-M',
                                  fontSize: 24.41,
                                ),
                              )
                            : const Text(
                                'Sabai Jobs',
                                style: TextStyle(
                                  fontFamily: 'Bricolage-B',
                                  fontSize: 30.52,
                                  color: Color(0xffFF3997),
                                ),
                              ),
                        const SizedBox(
                          width: 10,
                        ),
                        languageProvider.lan == 'English'
                            ? const Text(
                                'Sabai Jobs',
                                style: TextStyle(
                                  fontFamily: 'Bricolage-B',
                                  fontSize: 30.52,
                                  color: Color(0xffFF3997),
                                ),
                              )
                            : const Text(
                                'မှကြိုဆိုပါတယ်',
                                style: TextStyle(
                                  fontFamily: 'Walone-B',
                                  fontSize: 24.41,
                                ),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      child: PageView(
                        controller: _controller,
                        children: [
                          Center(
                            child: languageProvider.lan == 'English'
                                ? Text(
                                    'Finding a Job Made Easy',
                                    style: GoogleFonts.bricolageGrotesque(
                                      textStyle:
                                          const TextStyle(fontSize: 15.6),
                                    ),
                                  )
                                : const Text(
                                    'အလုပ်အကိုင်ရှာဖွေမှုကို လွယ်ကူစေတယ်',
                                    style: TextStyle(
                                      fontFamily: 'Walone-R',
                                      fontSize: 14,
                                    ),
                                  ),
                          ),
                          Center(
                            child: languageProvider.lan == 'English'
                                ? Text(
                                    'Offering Safe, Hassle-Free Jobs',
                                    style: GoogleFonts.bricolageGrotesque(
                                      textStyle:
                                          const TextStyle(fontSize: 15.6),
                                    ),
                                  )
                                : const Text(
                                    'လုံခြုံ အဆင်ပြေတဲ့ အလုပ်အကိုင်တွေရှိတယ်',
                                    style: TextStyle(
                                      fontFamily: 'Walone-R',
                                      fontSize: 14,
                                    ),
                                  ),
                          ),
                          Center(
                            child: languageProvider.lan == 'English'
                                ? Text(
                                    'Shielding You from Scammers',
                                    style: GoogleFonts.bricolageGrotesque(
                                      textStyle:
                                          const TextStyle(fontSize: 15.6),
                                    ),
                                  )
                                : const Text(
                                    'အလိမ်အညာအလုပ်များကို သေချာစီစစ်ထားတယ်',
                                    style: TextStyle(
                                      fontFamily: 'Walone-R',
                                      fontSize: 14,
                                    ),
                                  ),
                          ),
                          Center(
                            child: languageProvider.lan == 'English'
                                ? Text(
                                    'Enjoy Job Hunting with Us',
                                    style: GoogleFonts.bricolageGrotesque(
                                      textStyle: const TextStyle(fontSize: 14),
                                    ),
                                  )
                                : const Text(
                                    'အလုပ်အကိုင််ရှာဖွေမှုကို Sabai job နဲ့ပျော်ရွှင်စွာ ပြုလုပ်လိုက်ပါ',
                                    style: TextStyle(
                                      fontFamily: 'Walone-R',
                                      fontSize: 14,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
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
                Column(
                  children: [
                    languageProvider.lan == 'English'
                        ? RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'By registering, you accept our ',
                              style: GoogleFonts.bricolageGrotesque(
                                textStyle: const TextStyle(
                                  fontSize: 12.5,
                                  color: Color(0xff4C5258),
                                ),
                              ),
                              children: [
                                TextSpan(
                                  text: 'Terms and Conditions of \nUse ',
                                  style: GoogleFonts.bricolageGrotesque(
                                    textStyle: const TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff4C5258),
                                    ),
                                  ),
                                ),
                                const TextSpan(
                                  text: 'and our ',
                                ),
                                TextSpan(
                                  text: 'Privacy Policy.',
                                  style: GoogleFonts.bricolageGrotesque(
                                    textStyle: const TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff4C5258),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                                text:
                                    'စာရင်းသွင်းခြင်းဖြင့် သင့်အနေနှင့် ကျွန်ုပ်တို့၏',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xff4C5258),
                                  fontFamily: 'Walone-R',
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        'အသုံးပြုမှုစည်းမျဉ်းများနှင့်\nကိုယ်ရေးအချက်အလက်မူဝါဒ',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff4C5258),
                                      fontFamily: 'Walone-R',
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'ကို လက်ခံသည်ဟု ယူဆပါသည်',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xff4C5258),
                                      fontFamily: 'Walone-R',
                                    ),
                                  ),
                                ]),
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 343,
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegistrationPage(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xffFF3997),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8), // Set the border radius
                          ),
                        ),
                        child: languageProvider.lan == 'English'
                            ? Text(
                                'Get Started',
                                style: GoogleFonts.bricolageGrotesque(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.63,
                                  ),
                                ),
                              )
                            : const Text(
                                'အကောင့်အသစ်ပြုလုပ်ရန်',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Walone-B',
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Container(
                      width: 343,
                      height: 42,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffFF3997),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8), // Set the border radius
                          ),
                        ),
                        child: languageProvider.lan == "English"
                            ? Text(
                                'Log In',
                                style: GoogleFonts.bricolageGrotesque(
                                  textStyle: const TextStyle(
                                    color: Color(0xffFF3997),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.63,
                                  ),
                                ),
                              )
                            : const Text(
                                '၀င်ရောက်ရန်',
                                style: TextStyle(
                                  color: Color(0xffFF3997),
                                  fontSize: 14,
                                  fontFamily: 'Walone-B',
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
