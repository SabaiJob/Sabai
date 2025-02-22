import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/reusable_container.dart';
import 'package:sabai_app/components/reusable_content_holder.dart';
import 'package:sabai_app/components/reusable_dropdown.dart';
import 'package:sabai_app/components/reusable_label.dart';
import 'package:sabai_app/components/reusable_radio_button.dart';
import 'package:sabai_app/components/reusable_title_holder.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:sabai_app/data/sabai_app_data.dart';

class CompleteUserInfoPage extends StatelessWidget {
  // Province
  final bool? isProvinceError;
  final String? selectedProvince;
  final Function(String?)? whenProvinceOnChanged;
  final String? provinceErrorMessage;

  // Years/Duration
  final TextEditingController? yearsController;
  final Function(String)? whenYearsOnChanged;
  final bool isDurationError;
  final String selectedDurationInEng;
  final String selectedDurationInMm;
  final Function(String?)? whenDurationOnChanged;
  final String durationErrorMessage;

  // Thai Language Level
  final bool? isLanguageLevelError;
  final String? selectedLanguageLevel;
  final Function(String?)? whenLanguageLevelOnChanged;
  final String? languageLevelErrorMessage;

  // Passport
  final bool? isSelectedOptionPpError;
  final String? pPErrorMessage;
  final String? selectedOptionPp;
  final Function(String?)? whenPpRadioButtonOnChoosen;
  final TextEditingController? passportController;
  final Function(String)? whenPassportOnChanged;
  final bool? isPassportFieldError;
  final String passportFieldErrorMessage;

  // Work Permit
  final bool? isSelectedOptionWpError;
  final String? selectedOptionWp;
  final String? wPErrorMessage;
  final Function(String?)? whenWpRadioButtonOnChoosen;

  const CompleteUserInfoPage(
      {super.key,
      required this.isProvinceError,
      required this.selectedProvince,
      required this.whenProvinceOnChanged,
      required this.provinceErrorMessage,
      required this.yearsController,
      required this.whenYearsOnChanged,
      required this.isDurationError,
      required this.selectedDurationInEng,
      required this.selectedDurationInMm,
      required this.whenDurationOnChanged,
      required this.durationErrorMessage,
      required this.isLanguageLevelError,
      required this.selectedLanguageLevel,
      required this.whenLanguageLevelOnChanged,
      required this.languageLevelErrorMessage,
      required this.isSelectedOptionPpError,
      required this.pPErrorMessage,
      required this.selectedOptionPp,
      required this.whenPpRadioButtonOnChoosen,
      required this.passportController,
      required this.whenPassportOnChanged,
      required this.isPassportFieldError,
      required this.passportFieldErrorMessage,
      required this.isSelectedOptionWpError,
      required this.selectedOptionWp,
      required this.wPErrorMessage,
      required this.whenWpRadioButtonOnChoosen});

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
                      ? 'Complete Your Profile'
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
                      ? 'We need a bit more information to finalize your profile. This ensure your account is secure and verified.'
                      : 'သင့်ပရိုဖိုင်ကို လုံခြုံစေဖို့ အတည်ပြုရန် အခြားအချက်အလက် အနည်းငယ် လိုအပ်ပါသည်။'),
            ),
          ),
          //province label
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ReusableLabelHolder(
              labelName: languageProvider.lan == 'English'
                  ? 'Select Province'
                  : 'ခရိုင်',
              textStyle: languageProvider.lan == 'English'
                  ? labelStyleEng
                  : labelStyleMm,
              isStarred: true,
            ),
          ),
          //select province dropdown
          ReusableContainer(
            hasError: isProvinceError!,
            childWidget: ReusableDropdown(
                dropdownItems: sabaiAppData.provinceItemsInEng,
                selectedItem: selectedProvince,
                cusHeight: 36,
                cusWidth: 400,
                whenOnChanged: whenProvinceOnChanged!,
                hintText: languageProvider.lan == 'English'
                    ? 'Select Province'
                    : 'ခရိုင် ရွေးချယ်ပါ'),
          ),
          //when the dropdown value is empty
          if (isProvinceError!)
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Text(
                  provinceErrorMessage!,
                  style: languageProvider.lan == 'English'
                      ? errorTextStyleEng
                      : errorTextStyleMm,
                ),
              ),
            ),
          //years in thailand label
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 12),
            child: ReusableLabelHolder(
                labelName: languageProvider.lan == 'English'
                    ? 'Years in Thailand'
                    : 'ထိုင်းနိုင်ငံတွင် နေထိုင်သည့်နှစ်',
                textStyle: languageProvider.lan == 'English'
                    ? labelStyleEng
                    : labelStyleMm,
                isStarred: true),
          ),
          //years in thailand (textfield and dropdown)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: SizedBox(
                  height: 36,
                  child: TextField(
                    controller: yearsController,
                    onChanged: whenYearsOnChanged,
                    style: languageProvider.lan == 'English'
                        ? textfieldHintTextStyleEng
                        : textfieldHintTextStyleMm,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00ffffff),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: ("0"),
                      contentPadding:
                          const EdgeInsets.only(top: 1, bottom: 1, left: 10),
                      hintStyle: const TextStyle(
                        color: Color(0xFF7B838A),
                        fontSize: 14,
                      ),
                      enabledBorder: isDurationError
                          ? enabledErrorBorder
                          : enabledNormalBorder,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              ReusableDropdown(
                dropdownItems: languageProvider.lan == "English"
                    ? sabaiAppData.durationItemsInEng
                    : sabaiAppData.durationItemsInMm,
                selectedItem: languageProvider.lan == "English"
                    ? selectedDurationInEng
                    : selectedDurationInMm,
                cusHeight: 36,
                cusWidth: 96,
                whenOnChanged: whenDurationOnChanged!,
                hintText: selectedDurationInEng,
              ),
            ],
          ),
          //if the years in thailand textfield is empty
          if (yearsController!.text.trim().isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Text(
                durationErrorMessage,
                style: languageProvider.lan == 'English'
                    ? errorTextStyleEng
                    : errorTextStyleMm,
              ),
            ),
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
          //do you have passport Y/N label
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 12),
            child: ReusableLabelHolder(
                labelName: languageProvider.lan == 'English'
                    ? 'Do you have passport ?'
                    : 'နိုင်ငံကူးလက်မှတ်ရှိသလား',
                textStyle: languageProvider.lan == 'English'
                    ? labelStyleEng
                    : labelStyleMm,
                isStarred: true),
          ),
          //if do you have passport Y/N question has empty value
          if (isSelectedOptionPpError!)
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Text(
                  pPErrorMessage!,
                  style: languageProvider.lan == 'English'
                      ? errorTextStyleEng
                      : errorTextStyleMm,
                ),
              ),
            ),
          //Y/N radio button
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ReusableRadioButton(
                rButtonValue: 'Yes',
                rButtonSelectedValue: selectedOptionPp,
                rButtonChoosen: whenPpRadioButtonOnChoosen,
                rButtonName: languageProvider.lan == 'English' ? 'Yes' : 'ရှိ',
              ),
              const SizedBox(
                width: 20,
              ),
              ReusableRadioButton(
                rButtonValue: 'No',
                rButtonSelectedValue: selectedOptionPp,
                rButtonChoosen: whenPpRadioButtonOnChoosen,
                rButtonName: languageProvider.lan == 'English' ? 'No' : 'မရှိ',
              ),
            ],
          ),
          //if the answer is Yes
          if (selectedOptionPp == 'Yes') ...[
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: languageProvider.lan == 'English'
                        ? const Text(
                            "Passport Number",
                            style: TextStyle(
                              fontFamily: 'Bricolage-M',
                              fontSize: 15.63,
                              color: Colors.black,
                            ),
                          )
                        : const Text(
                            "နိုင်ငံကူးလက်မှတ်နံပါတ်",
                            style: TextStyle(
                              fontFamily: 'Walone-B',
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                  ),
                ),
                // Passport Number Textfield
                SizedBox(
                  width: 400,
                  height: 36,
                  child: TextField(
                    controller: passportController,
                    onChanged: whenPassportOnChanged,
                    style: const TextStyle(
                      fontFamily: 'Bricolage-R',
                      fontWeight: FontWeight.w100,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      enabledBorder: isPassportFieldError!
                          ? enabledErrorBorder
                          : enabledNormalBorder,
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
                          ? ("Enter your passport number")
                          : 'သင့်နိုင်ငံကူးလက်မှတ်နံပါတ် ထည့်ပါ',
                      contentPadding:
                          const EdgeInsets.only(top: 1, bottom: 1, left: 10),
                      hintStyle: languageProvider.lan == 'English'
                          ? textfieldHintTextStyleEng
                          : textfieldHintTextStyleMm,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                if (isPassportFieldError!)
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        passportFieldErrorMessage,
                        style: languageProvider.lan == 'English'
                            ? errorTextStyleEng
                            : errorTextStyleMm,
                      ),
                    ),
                  ),
              ],
            )
          ],
          //do you have work permit Y/N label
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 12),
            child: ReusableLabelHolder(
                labelName: languageProvider.lan == 'English'
                    ? 'Do you have work permit ?'
                    : 'အလုပ်သမား ဗီဇာရှိပါသလား ?',
                textStyle: languageProvider.lan == 'English'
                    ? labelStyleEng
                    : labelStyleMm,
                isStarred: true),
          ),
          //if do you have work permit Y/N question has empty value
          if (isSelectedOptionWpError!)
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Text(
                  wPErrorMessage!,
                  style: languageProvider.lan == 'English'
                      ? errorTextStyleEng
                      : errorTextStyleMm,
                ),
              ),
            ),
          //Y/N radio button
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ReusableRadioButton(
                rButtonValue: 'Yes',
                rButtonSelectedValue: selectedOptionWp,
                rButtonChoosen: whenWpRadioButtonOnChoosen,
                rButtonName: languageProvider.lan == 'English' ? 'Yes' : 'ရှိ',
              ),
              const SizedBox(
                width: 20,
              ),
              ReusableRadioButton(
                rButtonValue: 'No',
                rButtonSelectedValue: selectedOptionWp,
                rButtonChoosen: whenWpRadioButtonOnChoosen,
                rButtonName: languageProvider.lan == 'English' ? 'No' : 'မရှိ',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
