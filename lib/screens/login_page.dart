import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/reusable_content_holder.dart';
import 'package:sabai_app/screens/homepage.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:sabai_app/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
        backgroundColor: Color(0xffF7F7F7),
        appBar: AppBar(
          backgroundColor: Color(0xffF7F7F7),
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'User Register',
                    style: appBarTitleStyleEng,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ReusableContentHolder(
                      content:
                          'Lorem ipsum dolor sit amet consectetur. Ut vel\nnvitae sed quam maecenas cursus pharetra.'),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: const TextSpan(
                      text: 'Full Name',
                      style: TextStyle(
                        fontFamily: 'Bricolage-M',
                        fontSize: 15.63,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    width: 400,
                    height: 36,
                    child: TextField(
                      style: TextStyle(
                        fontFamily: 'Bricolage-R',
                        fontWeight: FontWeight.w100,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFFFF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFFFF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: ("Enter your full name"),
                        contentPadding:
                            EdgeInsets.only(top: 1, bottom: 1, left: 10),
                        hintStyle: TextStyle(
                          color: Color(0xFF7B838A),
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  RichText(
                    text: const TextSpan(
                      text: 'Phone Number',
                      style: TextStyle(
                        fontFamily: 'Bricolage-M',
                        fontSize: 15.63,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    width: 400,
                    height: 36,
                    child: TextField(
                      style: TextStyle(
                        fontFamily: 'Bricolage-R',
                        fontWeight: FontWeight.w100,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFFFF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFFFF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: ("+66 2134567"),
                        contentPadding:
                            EdgeInsets.only(top: 1, bottom: 1, left: 10),
                        hintStyle: TextStyle(
                          color: Color(0xFF7B838A),
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 45),
              child: Container(
                width: 365,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible:
                          false, // Prevent dismissal by tapping outside
                      builder: (context) {
                        return const Dialog(
                          backgroundColor: Colors.white,
                          child: SizedBox(
                            width: 170,
                            height: 200,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 110,
                                  width: 110,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        height: 70, // Outer circle size
                                        width: 70,
                                        child: CircularProgressIndicator(
                                          color: Color(0xffFF3997),
                                          strokeWidth:
                                              4.0, // Outer circle thickness
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30, // Inner circle size
                                        width: 30,
                                        child: CircularProgressIndicator(
                                          color: Color(0xffFF3997),
                                          strokeWidth:
                                              4.0, // Inner circle thickness
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                ),
                                Text(
                                  'Loggin...',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    fontFamily: 'Bricolage-R',
                                    color: Color(0xff41464B),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );

                    Future.delayed(
                      const Duration(seconds: 3),
                      () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Homepage(),
                          ),
                        );
                      },
                    );
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
                          ? Text(
                              'Log In',
                              style: GoogleFonts.bricolageGrotesque(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.63,
                                ),
                              ),
                            )
                          : Text(
                              '၀င်ရောက်ရန်',
                              style: GoogleFonts.bricolageGrotesque(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
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
              ),
            ),
          ],
        ));
  }
}
