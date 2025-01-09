// no longer in
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/reusable_content_holder.dart';
import 'package:sabai_app/components/reusable_title_holder.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/user_profile_setup_page.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationPage extends StatefulWidget {
  final int currentStep;
  final Widget navWidget;
  final bool signUp;
  const OtpVerificationPage(
      {super.key,this.currentStep = 0,required this.navWidget, required this.signUp});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final String fixedPinNumber = "000000"; // fixed OTP pin code for now
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        bottom: PreferredSize(preferredSize: const Size.fromHeight(1.0), child: Container(color: Colors.grey.shade300, height: 1.0,)),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: languageProvider.lan == 'English'
            ? const Text(
                "Create Profile",
                style: appBarTitleStyleEng,
              )
            : const Text(
                'ပရိုဖိုင် ဖန်တီးရန်',
                style: appBarTitleStyleMn,
              ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xFFFF3997),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 30),
          child: Column(
            children: [
              if (widget.signUp) ...[
                Container(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child:  StepProgressIndicator(
                    roundedEdges: const Radius.circular(10),
                    padding: 0.0,
                    totalSteps: totalSteps,
                    currentStep: widget.currentStep,
                    selectedColor: const Color(0xFFFF3997),
                    unselectedColor: const Color.fromARGB(100, 76, 82, 88),
                    size: 8.0,
                  ),
                )
              ],
              Container(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ReusableTitleHolder(
                    title: languageProvider.lan == 'English'
                        ? 'Verify OTP Code'
                        : 'OTP ကုဒ်ကို စစ်ဆေးပါ',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 12, bottom: 32),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ReusableContentHolder(
                      content: languageProvider.lan == "English"
                          ? 'We sent a SMS with your OTP code to\n+66 2134567.'
                          : 'ကျွန်ုပ်တို့သည် သင့် OTP ကုဒ်ပါ SMS ကို +66 2134567 သို့\nပို့ခဲ့ပါပြီ။'),
                ),
              ),
              PinCodeTextField(
                appContext: context,
                length: 6,
                onCompleted: (value) {
                  if (value == fixedPinNumber) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => widget.navWidget));
                  } else {
                    print('wrong pin');
                  }
                },
                enableActiveFill: true,
                pinTheme: PinTheme(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  selectedColor: const Color(0xFFC8C8C8),
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  activeColor: const Color(0xFFC8C8C8),
                  //activeColor: Colors.pink,
                  activeFillColor: Colors.white,
                  errorBorderColor: Colors.black,
                  inactiveColor: const Color(0xFFC8C8C8),
                  inactiveBorderWidth: 2,
                  activeBorderWidth: 3,
                  fieldWidth: 40,
                  fieldHeight: 56,
                  shape: PinCodeFieldShape.box,

                  //activeFillColor: Colors.white,
                  //selectedColor: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 32, bottom: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ReusableContentHolder(
                    content: languageProvider.lan == 'English'
                        ? 'Having trouble? Request a new OTP.'
                        : 'ပြဿနာရှိနေပါသလား? OTP ကုဒ်အသစ်ကိုပြန်တောင်းရန်\n00:27.',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
