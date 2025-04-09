import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/reusable_content_holder.dart';
import 'package:sabai_app/components/reusable_label.dart';
import 'package:sabai_app/components/reusable_textformfield.dart';
import 'package:sabai_app/components/reusable_title_holder.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/services/language_provider.dart';

class InitialRegistrationPage extends StatelessWidget {
  // Key for validation
  final GlobalKey<FormState> formKey;

  // Full Name
  final TextEditingController fullNameController;

  // Phone Number
  final TextEditingController phoneNumberController;

  //email
  final TextEditingController emailController;

  const InitialRegistrationPage({
    super.key,
    required this.formKey,
    required this.fullNameController,
    required this.phoneNumberController,
    required this.emailController,
    //required this.emailController
  });

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // title
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: ReusableTitleHolder(
                      title: languageProvider.lan == 'English'
                          ? 'Tell Us About Yourself'
                          : 'ကိုယ်ရေးကိုယ်တာအချက်လက်',
                    ),
                  ),
                ),
                // subtitle
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: ReusableContentHolder(
                        content: languageProvider.lan == 'English'
                            ? 'Please provide your basic information to get started. This helps us tailor job opportunities just for you.'
                            : 'အကောင့်အသစ်ပြုလုပ်ရန် သင့်ကိုယ်ရေးကိုယ်တာအချက်လက်များကိုထည့်သွင်းပေးပါ။ သင့်တင့်သော အလုပ်အကိုင်အခွင့်အလမ်းများကို ရှာဖွေဖို့ ဒီအချက်အလက်တွေက အရမ်းအရေးကြီးပါတယ်။'),
                  ),
                ),
                // Full Name Label
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ReusableLabelHolder(
                    labelName: languageProvider.lan == 'English'
                        ? 'Full Name'
                        : 'အမည်',
                    textStyle: languageProvider.lan == 'English'
                        ? labelStyleEng
                        : labelStyleMm,
                    isStarred: true,
                  ),
                ),
                // Full Name Textform Field
                ReusableTextformfield(
                    keyboardType: TextInputType.name,
                    textEditingController: fullNameController,
                    validating: (value) {
                      if (value == null || value.isEmpty) {
                        return languageProvider.lan == 'English'
                            ? "Full Name is required"
                            : "အမည်အပြည့်အစုံထည့်ရန်လိုအပ်သည်";
                      }
                      return null;
                    },
                    hint: languageProvider.lan == 'English'
                        ? 'Enter your full name'
                        : 'သင့်အမည် ထည့်ပါ'),

                // Phone Number Title
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ReusableLabelHolder(
                    labelName: languageProvider.lan == 'English'
                        ? 'Phone Number'
                        : 'ဖုန်းနံပါတ်',
                    textStyle: languageProvider.lan == 'English'
                        ? labelStyleEng
                        : labelStyleMm,
                    isStarred: true,
                  ),
                ),
                //Phone Number TextFormField
                ReusableTextformfield(
                  formatter: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.phone,
                  textEditingController: phoneNumberController,
                  validating: (value) {
                    if (value == null || value.isEmpty) {
                      return languageProvider.lan == 'English'
                          ? "Phone Number is required"
                          : "ဖုန်းနံပါတ်ထည့်ရန်လိုအပ်သည်";
                    }
                    return null;
                  },
                  hint: '0662134567',
                ),
                //for email
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ReusableLabelHolder(
                    labelName:
                        languageProvider.lan == 'English' ? 'Email' : 'Email',
                    textStyle: languageProvider.lan == 'English'
                        ? labelStyleEng
                        : labelStyleMm,
                    isStarred: true,
                  ),
                ),
                //for email text field
                ReusableTextformfield(
                  keyboardType: TextInputType.emailAddress,
                    textEditingController: emailController,
                    validating: (value) {
                      if (value == null || value.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Email is required"),
                          ),
                        );
                        return languageProvider.lan == 'English'
                            ? "Email is required"
                            : "Email is required";
                      }
                      // Basic email regex
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
                    hint: 'Enter your email')
              ],
            ),
          ),
        ));
  }
}
