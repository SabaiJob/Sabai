import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:sabai_app/components/reusable_content_holder.dart';
import 'package:sabai_app/components/reusable_title_holder.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sabai_app/services/otp_code_timer_provider.dart';
import 'package:sabai_app/services/phone_number_provider.dart';

class OtpCodeVerificationPage extends StatelessWidget {
  final TextEditingController pinCodeController;
  final Function(String) whenOnComplete;
  //final Future<void> requestOtp;
  const OtpCodeVerificationPage({
    super.key,
    required this.pinCodeController,
    required this.whenOnComplete,
    //required this.requestOtp,
  });

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          //title
          Align(
            alignment: Alignment.topLeft,
            child: ReusableTitleHolder(
              title: languageProvider.lan == 'English'
                  ? 'Verify OTP Code'
                  : 'OTP ကုဒ်ကို စစ်ဆေးပါ',
            ),
          ),
          //description
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 32),
            child: SizedBox(
              child: Align(
                alignment: Alignment.topLeft,
                child: Consumer<PhoneNumberProvider>(
                    builder: (context, phoneNumberProvider, child) {
                  return RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                        text: 'We sent an OTP code to ',
                        style: TextStyle(
                          fontFamily: 'Walone-R',
                          fontSize: 14,
                          color: Color(0xFF2B2F32),
                        )),
                    TextSpan(
                        text: phoneNumberProvider.phoneNumber,
                        style: const TextStyle(
                          fontFamily: 'Walone-B',
                          fontSize: 14,
                          color: Color(0xFF000000),
                        )),
                  ]));
                }),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 12, bottom: 32),
          //   child: SizedBox(
          //     child: Align(
          //         alignment: Alignment.topLeft,
          //         child: Consumer<PhoneNumberProvider>(
          //             builder: (context, phoneNumberProvider, child) {
          //           return ReusableContentHolder(
          //               content: languageProvider.lan == "English"
          //                   ? 'We sent a SMS with your OTP code to ${phoneNumberProvider.phoneNumber}'
          //                   : 'ကျွန်ုပ်တို့သည် သင့် OTP ကုဒ်ပါ SMS ကို  ${phoneNumberProvider.phoneNumber} သို့ ပို့ခဲ့ပါပြီ။');
          //         })),
          //   ),
          // ),
          //pincode textfield
          PinCodeTextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: pinCodeController,
            appContext: context,
            length: 6,
            onCompleted: whenOnComplete,
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
          //otp re-request
          Align(
            alignment: Alignment.topLeft,
            child: Consumer<OtpCodeTimerProvider>(
              builder: (context, otpTimer, child) {
                return Row(
                  children: [
                    const Text(
                      'Having trouble?',
                      style: otpCodeRequestTextStyle,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    otpTimer.isTimerActive
                        ? RichText(
                            text: TextSpan(children: [
                            const TextSpan(
                                text: 'Request a new OTP in ',
                                style: otpCodeTimerTextStyle),
                            TextSpan(
                                text:
                                    '00:${otpTimer.remainingTime.toString().padLeft(2, '0')}.',
                                style: otpCodeTimer1TextStyle)
                          ]))
                        : GestureDetector(
                            onTap: otpTimer.isTimerActive
                                ? null
                                : () async {
                                    //await requestOtp;
                                    otpTimer.resetTimer();
                                    print("Resending OTP...");
                                  },
                            child: const Text(
                              'Request a new OTP',
                              style: otpCodeReRequestTextStyle,
                            ),
                          ),
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
