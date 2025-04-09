import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/reusable_container.dart';
import 'package:sabai_app/components/reusable_content_holder.dart';
import 'package:sabai_app/components/reusable_dropdown.dart';
import 'package:sabai_app/components/reusable_label.dart';
import 'package:sabai_app/components/reusable_radiobutton_listtiles.dart';
import 'package:sabai_app/components/reusable_title_holder.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:sabai_app/data/sabai_app_data.dart';

class CompleteUserInfoPage extends StatelessWidget {
  // Gender
  final String? selectedGender;
  final bool isGenderError;
  final String genderErrorMessage;
  final Function(String? value) onGenderChanged;

  // Thai Language Level
  final bool? isLanguageLevelError;
  final String? selectedLanguageLevel;
  final Function(String?)? whenLanguageLevelOnChanged;
  final String? languageLevelErrorMessage;

  //Age
  final String selectedAge;
  final Function(String?) whenAgeOnChange;
  final bool isAgeError;
  final String ageErrorMessage;

  //Status
  final String selectedStatus;
  final Function(String?) whenStatusOnChange;
  final bool isStatusError;
  final String statusErrorMessage;

  //email
  final TextEditingController emailController;

  const CompleteUserInfoPage(
      {super.key,
      required this.isLanguageLevelError,
      required this.selectedLanguageLevel,
      required this.whenLanguageLevelOnChanged,
      required this.languageLevelErrorMessage,
      required this.selectedGender,
      required this.genderErrorMessage,
      required this.isGenderError,
      required this.onGenderChanged,
      required this.selectedAge,
      required this.whenAgeOnChange,
      required this.selectedStatus,
      required this.whenStatusOnChange,
      required this.emailController,
      required this.isAgeError,
      required this.ageErrorMessage,
      required this.isStatusError,
      required this.statusErrorMessage
      });

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    SabaiAppData sabaiAppData = SabaiAppData();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Align(
              alignment: Alignment.topLeft,
              child: ReusableTitleHolder(
                  title: languageProvider.lan == 'English'
                      ? 'Help Us Tailor Jobs for You'
                      : 'ပရိုဖိုင်ကို ပြီးပြည့်စုံစွာ ပြုလုပ်ပါ'),
            ),
          ),
          //subtitle
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Align(
              alignment: Alignment.topLeft,
              child: ReusableContentHolder(
                  content: languageProvider.lan == 'English'
                      ? 'Share your gender, age range, and work status to get job matches that fit you best.'
                      : 'သင့်ပရိုဖိုင်ကို လုံခြုံစေဖို့ အတည်ပြုရန် အခြားအချက်အလက် အနည်းငယ် လိုအပ်ပါသည်။'),
            ),
          ),

          // Gender Label
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ReusableLabelHolder(
              labelName: languageProvider.lan == 'English' ? 'Gender' : 'လိင်',
              textStyle: languageProvider.lan == 'English'
                  ? labelStyleEng
                  : labelStyleMm,
              isStarred: true,
            ),
          ),
          //Gender Dropdown
          ReusableContainer(
            hasError: isGenderError,
            childWidget: ReusableDropdown(
              dropdownItems: languageProvider.lan == 'English'
                  ? sabaiAppData.genderItemsInEng
                  : sabaiAppData.genderItemsInMm,
              selectedItem: selectedGender,
              cusHeight: 36,
              cusWidth: 400,
              whenOnChanged: onGenderChanged,
              hintText: languageProvider.lan == 'English'
                  ? 'Select One'
                  : 'တစ်ခုရွေးချယ်ပါ',
            ),
          ),
          //when gender is empty
          if (isGenderError)
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Text(
                  genderErrorMessage,
                  style: languageProvider.lan == 'English'
                      ? errorTextStyleEng
                      : errorTextStyleMm,
                ),
              ),
            ),

          // Age Label
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: ReusableLabelHolder(
              labelName: languageProvider.lan == 'English' ? 'Age ?' : 'အသက်',
              textStyle: languageProvider.lan == 'English'
                  ? labelStyleEng
                  : labelStyleMm,
              isStarred: true,
            ),
          ),
          //when age is empty
          if (isAgeError)
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Text(
                  ageErrorMessage,
                  style: languageProvider.lan == 'English'
                      ? errorTextStyleEng
                      : errorTextStyleMm,
                ),
              ),
            ),

          ReusableRadiobuttonListtiles(
              title: '18-20',
              value: '18-20',
              selectedOption: selectedAge,
              onChanged: whenAgeOnChange),
          ReusableRadiobuttonListtiles(
              title: '21-30',
              value: '21-30',
              selectedOption: selectedAge,
              onChanged: whenAgeOnChange),
          ReusableRadiobuttonListtiles(
              title: '31-40',
              value: '31-40',
              selectedOption: selectedAge,
              onChanged: whenAgeOnChange),
          ReusableRadiobuttonListtiles(
              title: '41-50',
              value: '41-50',
              selectedOption: selectedAge,
              onChanged: whenAgeOnChange),

          //thai language proficiency label
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 12),
            child: ReusableLabelHolder(
                labelName: languageProvider.lan == 'English'
                    ? 'Thai Language Proficiency'
                    : 'ထိုင်းဘာသာအရည်ချင်း',
                textStyle: languageProvider.lan == 'English'
                    ? labelStyleEng
                    : labelStyleMm,
                isStarred: true),
          ),
          //thai language proficiency dropdown
          ReusableContainer(
            hasError: isLanguageLevelError!,
            childWidget: ReusableDropdown(
                dropdownItems: sabaiAppData.languageLevelsInEng,
                selectedItem: selectedLanguageLevel,
                cusHeight: 36,
                cusWidth: 400,
                whenOnChanged: whenLanguageLevelOnChanged!,
                hintText: languageProvider.lan == 'English'
                    ? 'Select your Thai proficiency'
                    : 'ထိုင်းဘာသာအရည်အချင်း'),
          ),
          //if the thai language proficiency dropdown is empty
          if (isLanguageLevelError!)
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Text(
                  languageLevelErrorMessage!,
                  style: languageProvider.lan == 'English'
                      ? errorTextStyleEng
                      : errorTextStyleMm,
                ),
              ),
            ),

          //Status
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ReusableLabelHolder(
                labelName: languageProvider.lan == 'English'
                    ? 'What kind of status do you have ?'
                    : 'ထိုင်းဘာသာအရည်ချင်း',
                textStyle: languageProvider.lan == 'English'
                    ? labelStyleEng
                    : labelStyleMm,
                isStarred: true),
          ),
          //when status is empty
          if (isStatusError)
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Text(
                  statusErrorMessage,
                  style: languageProvider.lan == 'English'
                      ? errorTextStyleEng
                      : errorTextStyleMm,
                ),
              ),
            ),
          ReusableRadiobuttonListtiles(
              title: 'Passport',
              value: 'Passport',
              selectedOption: selectedStatus,
              onChanged: whenStatusOnChange),
          ReusableRadiobuttonListtiles(
              title: 'Work Permit (Pink Card)',
              value: 'Work Permit (Pink Card)',
              selectedOption: selectedStatus,
              onChanged: whenStatusOnChange),
          ReusableRadiobuttonListtiles(
              title: 'Certificate of Identification',
              value: 'Certificate of Identification',
              selectedOption: selectedStatus,
              onChanged: whenStatusOnChange),
          ReusableRadiobuttonListtiles(
              title: 'Still Applying',
              value: 'Still Applying',
              selectedOption: selectedStatus,
              onChanged: whenStatusOnChange),

          // Email Title
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 12),
          //   child: ReusableLabelHolder(
          //     labelName: languageProvider.lan == 'English'
          //         ? 'Email Address (Optional)'
          //         : 'အီးမေးလ် လိပ်စာ',
          //     textStyle: languageProvider.lan == 'English'
          //         ? labelStyleEng
          //         : labelStyleMm,
          //     isStarred: false,
          //   ),
          // ),
          //Email Address TextField
          // SizedBox(
          //   width: 400,
          //   height: 36,
          //   child: TextField(
          //     controller: emailController,
          //     keyboardType: TextInputType.emailAddress,
          //     style: languageProvider.lan == 'English'
          //         ? textfieldTextStyleEng
          //         : textfieldTextStyleMm,
          //     textAlign: TextAlign.start,
          //     decoration: InputDecoration(
          //       enabledBorder: enableBorderStyle,
          //       focusedBorder: focusedBorderStyle,
          //       filled: true,
          //       fillColor: Colors.white,
          //       hintText: languageProvider.lan == 'English'
          //           ? ("Enter your email address")
          //           : ('သင့်အီးမေးလ် လိပ်စာ ထည့်ပါ'),
          //       hintStyle: languageProvider.lan == 'English'
          //           ? textfieldHintTextStyleEng
          //           : textfieldHintTextStyleMm,
          //       contentPadding:
          //           const EdgeInsets.only(top: 1, bottom: 1, left: 10),
          //       border: const OutlineInputBorder(
          //         borderSide: BorderSide.none,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
