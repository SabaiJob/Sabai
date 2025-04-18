import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/reusable_content_holder.dart';
import 'package:sabai_app/components/reusable_label.dart';
import 'package:sabai_app/components/reusable_textformfield.dart';
import 'package:sabai_app/components/reusable_title_holder.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/services/language_provider.dart';

class LogInFormPage extends StatelessWidget {
  // Key for validation
  final GlobalKey<FormState> formKey;

  // Full Name
  final TextEditingController fullNameController;

  // Phone Number
  final TextEditingController phoneNumberController;

  //for email
  final TextEditingController emailController;

  const LogInFormPage(
      {super.key,
      required this.formKey,
      required this.fullNameController,
      required this.phoneNumberController,
      required this.emailController,
      });

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Form(
            key: formKey,
            child: Column(
              children: [
                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: ReusableTitleHolder(
                      title: languageProvider.lan == 'English'
                          ? 'Log in to Sabai Job'
                          : 'အကောင့်က၀င်ရောက်ရန်',
                    ),
                  ),
                ),

                // Subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: ReusableContentHolder(
                        content: languageProvider.lan == 'English'
                            ? 'Log in to find jobs, show your skills, and connect with employers easily!'
                            : 'သင့်အကောင့်ကို၀င်ရောက်ဖို့ ဒီအချက်အလက်တွေကိုဖြည့်ပါ'),
                  ),
                ),

                // Full Name
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 8),
                //   child: ReusableLabelHolder(
                //     labelName:
                //         languageProvider.lan == 'English' ? 'Full Name' : 'အမည်',
                //     textStyle: languageProvider.lan == 'English'
                //         ? labelStyleEng
                //         : labelStyleMm,
                //     isStarred: true,
                //   ),
                // ),
                // // Full Name TextFormField
                // ReusableTextformfield(
                //     keyboardType: TextInputType.name,
                //     textEditingController: fullNameController,
                //     validating: (value) {
                //       if (value == null || value.isEmpty) {
                //         return languageProvider.lan == 'English'
                //             ? "Full Name is required"
                //             : "အမည်အပြည့်အစုံထည့်ရန်လိုအပ်သည်";
                //       }
                //       return null;
                //     },
                //     hint: languageProvider.lan == 'English'
                //         ? 'Enter your full name'
                //         : 'သင့်အမည် ထည့်ပါ'),

                // Phone Number
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: ReusableLabelHolder(
                    labelName:
                        languageProvider.lan == 'English' ? 'Email' : 'Email',
                    textStyle: languageProvider.lan == 'English'
                        ? labelStyleEng
                        : labelStyleMm,
                    isStarred: true,
                  ),
                ),
                // Phone Number TextFormField
                // ReusableTextformfield(
                //   formatter: [FilteringTextInputFormatter.digitsOnly],
                //   keyboardType: TextInputType.phone,
                //   textEditingController: phoneNumberController,
                //   validating: (value) {
                //     if (value == null || value.isEmpty) {
                //       return languageProvider.lan == 'English'
                //           ? "Phone Number is required"
                //           : "ဖုန်းနံပါတ်ထည့်ရန်လိုအပ်သည်";
                //     }
                //     return null;
                //   },
                //   hint: '0662134567',
                // ),

                ReusableTextformfield(
                  //formatter: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.emailAddress,
                  textEditingController: emailController,
                  validating: (value) {
                    if (value == null || value.isEmpty) {
                      return languageProvider.lan == 'English'
                          ? "Email is required"
                          : "Email ထည့်ရန်လိုအပ်သည်";
                    }
                    final emailRegex = RegExp(
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                    if (!emailRegex.hasMatch(value)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a valid email address'),
                          ),
                        );
                        return 'Please enter a valid email address';
                      }
                    return null;
                  },
                  hint: 'email',
                ),
              ],
            )),
      ),
    );
  }
}
