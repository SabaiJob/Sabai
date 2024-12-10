import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabai_app/constants.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Create Profile', style: GoogleFonts.bricolageGrotesque(textStyle: appBarTitleStyle),),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 30),
        child: Column(
          children: [
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
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Verify OTP Code", style: GoogleFonts.bricolageGrotesque(textStyle: title1Style),),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 12, bottom:32),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("We sent a SMS with your OTP code to\n +66 2134567", style: GoogleFonts.bricolageGrotesque(textStyle: title2Style),),
              ),
            ),
            PinCodeTextField(appContext: context, length: 6,
            pinTheme: PinTheme(),),
            Container(
              padding: const EdgeInsets.only(top: 32, bottom: 12),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Having trouble? Request a new OTP.", style: GoogleFonts.bricolageGrotesque(textStyle: title2Style),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}