import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import '../services/language_provider.dart';
import 'package:provider/provider.dart';

class UserProfileSetupPage extends StatefulWidget {
  const UserProfileSetupPage({super.key});

  @override
  State<UserProfileSetupPage> createState() => _UserProfileSetupPageState();
}

class _UserProfileSetupPageState extends State<UserProfileSetupPage> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Create Profile'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // StepProgressIndicator
              Container(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
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
                    child: Text("We need a bit more information to finalize\n your profile. This ensure your account is secure and verified.", style: GoogleFonts.bricolageGrotesque(textStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.63,
                      color: Color(0xFF08210E),
                    )),),
                  ),
                ),
          
                //Select District
                Container(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Select District *", style: GoogleFonts.bricolageGrotesque(textStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.63,
                      color: Colors.black,
                    )),),
                  ),
                ),
                // Select District Dropdown
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
                      hintText: ("Select District"),
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
          
                //Select City
                Container(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Select City *", style: GoogleFonts.bricolageGrotesque(textStyle: const TextStyle(
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
                      hintText: ("Select City"),
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
          
                // Passport Number
                Container(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Passport Number *", style: GoogleFonts.bricolageGrotesque(textStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.63,
                      color: Colors.black,
                    )),),
                  ),
                ),
                // Passport Number TextField
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
                      hintText: ("Enter your passport number"),
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
          
                // Passport Photo
                Container(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Passport Photo *", style: GoogleFonts.bricolageGrotesque(textStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.63,
                      color: Colors.black,
                    )),),
                  ),
                ),
                // Passport Photo Picker
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
                      hintText: ("Click to Upload"),
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
          
                //Y/N question
                Container(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Do you have work permit *", style: GoogleFonts.bricolageGrotesque(textStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.63,
                      color: Colors.black,
                    )),),
                  ),
                ),
                // answer choice yes/no
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
          
                //work permit photo
                Container(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Work Permit *", style: GoogleFonts.bricolageGrotesque(textStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.63,
                      color: Colors.black,
                    )),),
                  ),
                ),
                // Work Permit photo picker
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
                      hintText: ("Click to Upload"),
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

              // Your Photo
              Container(
                padding: EdgeInsets.only(top: 12, bottom: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Your photo *", style: GoogleFonts.bricolageGrotesque(textStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.63,
                    color: Colors.black,
                  )),),
                ),
              ),
              // Your photo picker
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
                    hintText: ("Scan Face"),
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

              // for some space 
              SizedBox(
                height: 30,
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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const OtpVerificationPage(),
                            //   ),
                            // );
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