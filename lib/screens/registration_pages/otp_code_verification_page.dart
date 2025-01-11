import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:sabai_app/components/reusable_content_holder.dart';
import 'package:sabai_app/components/reusable_title_holder.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpCodeVerificationPage extends StatelessWidget {
  final TextEditingController pinCodeController;
  final Function(String) whenOnComplete;
  const OtpCodeVerificationPage({super.key, required this.pinCodeController, required this.whenOnComplete});

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
          Align(
            alignment: Alignment.topLeft,
            child: ReusableContentHolder(
              content: languageProvider.lan == 'English'
                  ? 'Having trouble? Request a new OTP.'
                  : 'ပြဿနာရှိနေပါသလား? OTP ကုဒ်အသစ်ကိုပြန်တောင်းရန်\n00:27.',
            ),
          ),
        ],
      ),
    );
  }
}