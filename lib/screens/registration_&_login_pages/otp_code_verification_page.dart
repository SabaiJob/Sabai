import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:sabai_app/components/reusable_content_holder.dart';
import 'package:sabai_app/components/reusable_title_holder.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sabai_app/services/otp_code_timer_provider.dart';

class OtpCodeVerificationPage extends StatelessWidget {
  final TextEditingController pinCodeController;
  final Function(String) whenOnComplete;
  const OtpCodeVerificationPage(
      {super.key,
      required this.pinCodeController,
      required this.whenOnComplete});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: ReusableTitleHolder(
              title: languageProvider.lan == 'English'
                  ? 'Verify OTP Code'
                  : 'OTP ကုဒ်ကို စစ်ဆေးပါ',
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
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: pinCodeController,
            appContext: context,
            length: 6,
            onCompleted: whenOnComplete,
            // onCompleted: (value) {
            //   _scrollPages();
            // },
            enableActiveFill: true,
            pinTheme: PinTheme(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              selectedColor: const Color(0xFFC8C8C8),
              selectedFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              activeColor: const Color(0xFFC8C8C8),
              activeFillColor: Colors.white,
              errorBorderColor: Colors.black,
              inactiveColor: const Color(0xFFC8C8C8),
              inactiveBorderWidth: 2,
              activeBorderWidth: 3,
              fieldWidth: 40,
              fieldHeight: 56,
              shape: PinCodeFieldShape.box,
            ),
          ),
          // Align(
          //   alignment: Alignment.topLeft,
          //   child: ReusableContentHolder(
          //     content: languageProvider.lan == 'English'
          //         ? 'Having trouble? Request a new OTP.'
          //         : 'ပြဿနာရှိနေပါသလား? OTP ကုဒ်အသစ်ကိုပြန်တောင်းရန်\n00:27.',
          //   ),
          // ),

          Align(
            alignment: Alignment.topLeft,
            child: Consumer<OtpCodeTimerProvider>(
              builder: (context, otpTimer, child) {
                return Row(
                  children: [
                    const Text(
                      'Having trouble?',
                      style: TextStyle(
                        fontSize: 15.63,
                        fontFamily: 'Bricolage-R',
                        color: Color(0xFF6C757D),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    otpTimer.isTimerActive
                        ? Text(
                            'Request a new OTP in 00:${otpTimer.remainingTime.toString().padLeft(2, '0')}.',
                            style: const TextStyle(
                              color: Color(0xFF6C757D),
                              fontFamily: 'Bricolage-R',
                              fontSize: 15.63,
                            ),
                          )
                        : GestureDetector(
                            onTap: otpTimer.isTimerActive
                                ? null
                                : () {
                                    otpTimer.resetTimer();
                                    print("Resending OTP...");
                                  },
                            child: const Text(
                              'Request a new OTP',
                              style: TextStyle(
                                fontFamily: 'Bricolage-SMB',
                                fontSize: 15.63,
                                color: Color(0xFFFF3997),
                              ),
                            ),
                          ),
                    // Text(
                    //   otpTimer.isTimerActive
                    //       ? 'Having trouble? Request a new OTP in 00:${otpTimer.remainingTime.toString().padLeft(2, '0')}.'
                    //       : 'Having trouble? Request a new OTP.',
                    //   style: const TextStyle(fontSize: 16),
                    // ),
                    // const SizedBox(height: 10),
                    // GestureDetector(
                    //   onTap: otpTimer.isTimerActive
                    //       ? null
                    //       : () {
                    //           otpTimer.resetTimer();
                    //           // Add logic to resend OTP here
                    //           print("Resending OTP...");
                    //         },
                    //   child: Text(
                    //     'Request a new OTP.',
                    //     style: TextStyle(
                    //       color: otpTimer.isTimerActive
                    //           ? Colors.grey
                    //           : Colors.blue,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
