import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabai_app/screens/otp_verification_page.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../services/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFFF0F1F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Create Profile", style: GoogleFonts.bricolageGrotesque(textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 19.53,
        )),),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 12, bottom: 12),
                child: const StepProgressIndicator(
                    roundedEdges: Radius.circular(10),
                    padding: 0.0,
                    totalSteps: 3,
                    currentStep: 1,
                    selectedColor: Color(0xFFFF3997),
                    unselectedColor: Color(0xFF4C5258),
                    size: 8.0,
                    ),
              ),
              Container(
                padding: EdgeInsets.only(top: 12, bottom: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Tell Us About Yourself", style: GoogleFonts.bricolageGrotesque(textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.41,
                  )),),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 12, bottom: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Please provide your basic information to get\n started. This helps us tailor job opportunities\n just for you.", style: GoogleFonts.bricolageGrotesque(textStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.63,
                    color: Color(0xFF08210E),
                  )),),
                ),
              ),
              // Full Name
              Container(
                padding: EdgeInsets.only(top: 12, bottom: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Full Name *", style: GoogleFonts.bricolageGrotesque(textStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.63,
                    color: Colors.black,
                  )),),
                ),
              ),
              // Full Name TextField
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
                  decoration:  InputDecoration(
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
                    contentPadding: EdgeInsets.only(top: 1, bottom: 1, left: 10),
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
          
              // Gender
              Container(
                padding: EdgeInsets.only(top: 16, bottom: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Gender *", style: GoogleFonts.bricolageGrotesque(textStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.63,
                    color: Colors.black,
                  )),),
                ),
              ),
              // Gender Picker
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
                  decoration:  InputDecoration(
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
                    hintText: ("Select One"),
                    hintStyle: TextStyle(
                      color: Color(0xFF7B838A),
                      fontSize: 14,
                    ),
                    contentPadding: EdgeInsets.only(top: 1, bottom: 1, left: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
          
              //Birthday 
              Container(
                padding: EdgeInsets.only(top: 16, bottom: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Birthday *", style: GoogleFonts.bricolageGrotesque(textStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.63,
                    color: Colors.black,
                  )),),
                ),
              ),
              //Birthday Date Picker
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
                  decoration:  InputDecoration(
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
                    hintText: ("Select Date"),
                    contentPadding: EdgeInsets.only(top: 1, bottom: 1, left: 10),
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
              // Phone Number
              Container(
                padding: EdgeInsets.only(top: 16, bottom: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Phone Number *", style: GoogleFonts.bricolageGrotesque(textStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.63,
                    color: Colors.black,
                  )),),
                ),
              ),
              // PhoneNumber TextField
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
                  decoration:  InputDecoration(
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
                    hintStyle: TextStyle(
                      color: Color(0xFF7B838A),
                      fontSize: 14,
                    ),
                    contentPadding: EdgeInsets.only(top: 1, bottom: 1, left: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              // Email Address
              Container(
                padding: EdgeInsets.only(top: 16, bottom: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Email Address *", style: GoogleFonts.bricolageGrotesque(textStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.63,
                    color: Colors.black,
                  )),),
                ),
              ),
              // Email Address TextField
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
                  decoration:  InputDecoration(
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
                    hintText: ("Enter your email address"),
                    hintStyle: TextStyle(
                      color: Color(0xFF7B838A),
                      fontSize: 14,
                    ),
                    contentPadding: EdgeInsets.only(top: 1, bottom: 1, left: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
          
              // for some space
              SizedBox(
                height: 50,
              ),
          
              // Continue Button
              Container(
                width: 400,
                height: 42,
                decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OtpVerificationPage(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xffFF3997),
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
                              'Continue',
                              style: GoogleFonts.bricolageGrotesque(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.63,
                                ),
                              ),
                            )
                          : Text(
                              'ဆက်လက်ရန်',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}