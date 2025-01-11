import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/reusable_content_holder.dart';
import 'package:sabai_app/components/reusable_datepicker.dart';
import 'package:sabai_app/components/reusable_dropdown.dart';
import 'package:sabai_app/components/reusable_label.dart';
import 'package:sabai_app/components/reusable_textformfield.dart';
import 'package:sabai_app/components/reusable_title_holder.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/data/sabai_app_data.dart';
import 'package:sabai_app/services/language_provider.dart';

class RegistrationUserInfoPage extends StatelessWidget {
  // Key for validation
  final GlobalKey<FormState> formKey;

  // Full Name
  final TextEditingController fullNameController;

  // Phone Number
  final TextEditingController phoneNumberController;

  // Email
  final TextEditingController emailController;

  // Gender
  final String? selectedGender;
  final bool isGenderError;
  final String genderErrorMessage;
  final Function(String? value) onGenderChanged;

  // Birthday
  final DateTime? selectedDate;
  final bool isBirthdayError;
  final String birthdayErrorMessage;
  final Function(DateTime date) handleDateSelected;

  

  const RegistrationUserInfoPage({
    super.key,
    required this.formKey,
    required this.fullNameController,
    required this.phoneNumberController,
    required this.emailController,
    required this.selectedGender,
    required this.isGenderError,
    required this.genderErrorMessage,
    required this.selectedDate,
    required this.isBirthdayError,
    required this.birthdayErrorMessage,
    required this.handleDateSelected,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    SabaiAppData sabaiAppData = SabaiAppData();

    return SingleChildScrollView(
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

            // Full Name Title
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ReusableLabelHolder(
                labelName:
                    languageProvider.lan == 'English' ? 'Full Name' : 'အမည်',
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

            // Gender Title
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ReusableLabelHolder(
                labelName:
                    languageProvider.lan == 'English' ? 'Gender' : 'လိင်',
                textStyle: languageProvider.lan == 'English'
                    ? labelStyleEng
                    : labelStyleMm,
                isStarred: true,
              ),
            ),

            // Gender Dropdown
            Container(
              width: 400,
              height: 36,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isGenderError ? Colors.red : Colors.transparent,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: ReusableDropdown(
                dropdownItems: languageProvider.lan == 'English'
                    ? sabaiAppData.genderItemsInEng
                    : sabaiAppData.genderItemsInMm,
                selectedItem: selectedGender,
                cusHeight: 36,
                cusWidth: 400,
                whenOnChanged: onGenderChanged,
                // whenOnChanged: (value) {
                //   setState(() {
                //     _selectedGender = value;
                //     isGenderError = false;
                //   });
                // },
                hintText: languageProvider.lan == 'English'
                    ? 'Select One'
                    : 'တစ်ခုရွေးချယ်ပါ',
              ),
            ),
            if (isGenderError)
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Text(
                    genderErrorMessage,
                    style: languageProvider.lan == 'English'
                        ? const TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontFamily: 'Bricolage-M')
                        : const TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontFamily: 'Walone-R'),
                  ),
                ),
              ),
            // Birthday Title
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 12),
              child: ReusableLabelHolder(
                labelName:
                    languageProvider.lan == 'English' ? 'Birthday' : 'မွေးနေ့',
                textStyle: languageProvider.lan == 'English'
                    ? labelStyleEng
                    : labelStyleMm,
                isStarred: true,
              ),
            ),
            //Birthday Picker
            Container(
              width: 400,
              height: 36,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isGenderError ? Colors.red : Colors.transparent,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: ReusableDatePicker(
                  choosenLanguage: languageProvider.lan == 'English'
                      ? ('Select Date')
                      : ('နေ့စွဲ ရွေးချယ်ပါ'),
                  onDateSelected: handleDateSelected),
            ),
            if (isBirthdayError)
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    birthdayErrorMessage,
                    style: languageProvider.lan == 'English'
                        ? const TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontFamily: 'Bricolage-M')
                        : const TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontFamily: 'Walone-R'),
                  ),
                ),
              ),
            // Phone Number Title
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 12),
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
              hint: '+66 2134567',
            ),
            // Email Title
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ReusableLabelHolder(
                labelName: languageProvider.lan == 'English'
                    ? 'Email Address'
                    : 'အီးမေးလ် လိပ်စာ',
                textStyle: languageProvider.lan == 'English'
                    ? labelStyleEng
                    : labelStyleMm,
                isStarred: false,
              ),
            ),

            // Email Address TextField
            SizedBox(
              width: 400,
              height: 36,
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: languageProvider.lan == 'English'
                    ? const TextStyle(
                        fontFamily: 'Bricolage-R',
                        fontSize: 14,
                      )
                    : const TextStyle(
                        fontFamily: 'Walone-R',
                        fontSize: 14,
                      ),
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00ffffff),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00ffffff),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: languageProvider.lan == 'English'
                      ? ("Enter your email address")
                      : ('သင့်အီးမေးလ် လိပ်စာ ထည့်ပါ'),
                  hintStyle: const TextStyle(
                    color: Color(0xFF7B838A),
                    fontSize: 14,
                  ),
                  contentPadding:
                      const EdgeInsets.only(top: 1, bottom: 1, left: 10),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
