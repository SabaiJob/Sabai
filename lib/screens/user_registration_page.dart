// NEW USER REGISTRATION PAGE

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sabai_app/components/reusable_content_holder.dart';
import 'package:sabai_app/components/reusable_datepicker.dart';
import 'package:sabai_app/components/reusable_dropdown.dart';
import 'package:sabai_app/components/reusable_label.dart';
import 'package:sabai_app/components/reusable_radio_button.dart';
import 'package:sabai_app/components/reusable_textformfield.dart';
import 'package:sabai_app/components/reusable_title_holder.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/data/sabai_app_data.dart';
import '../services/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class UserRegistrationPage extends StatefulWidget {
  const UserRegistrationPage({super.key});

  @override
  State<UserRegistrationPage> createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage> {
  SabaiAppData sabaiAppData = SabaiAppData();
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  int _currentPage = 0;

  String? _selectedGender;
  bool isGenderError = false;
  String genderErrorMessage = '';

  bool isBirthdayError = false;
  String birthdayErrorMessage = '';
  DateTime? _selectedDate;

  

  String? _selectedProvince;

  String? selectedDuration = 'Years';
  String? selectedDurationMM = 'နှစ်';

  String? _selectedLanguageLevel;

  String? selectedOptionPp;
  String? selectedOptionWp;

  void _handleDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      isBirthdayError = false;
    });
    //print('Selected Date: $date');
  }

  // Navigate to OTP Page
  void _navToOTPPage() {
    setState(() {
      // Check for errors
      isGenderError = _selectedGender == null;
      isBirthdayError = _selectedDate == null;

      // Assign error messages based on validation
      genderErrorMessage = isGenderError ? "   Gender is required" : '';
      birthdayErrorMessage = isBirthdayError ? "   Birthday is required" : '';
    });

    // Proceed only if the form is valid and there are no errors
    bool isFormValid = _formKey.currentState!.validate();
    bool noErrors = !isGenderError && !isBirthdayError;

    if (isFormValid && noErrors) {
      if (_currentPage < 3) {
        //To remove later !!!!!
        print('Your Full Name: ${_fullNameController.text}');
        print('Your Gender: ${_selectedGender}');
        print('Your Birthday: ${_selectedDate}');
        print('Your Phone Number: ${_phoneNumberController.text}');
        print('Your email address: ${_emailController.text}');
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentPage++;
        });
      } else {
        // Perform the final submission or navigation
        print("Form submitted");
      }
    }
  }

  // Navigate to Profile SetUp Page
  void _navToSetUp(String value) {
    if (value == sabaiAppData.fixedPinNumber) {
      if (_currentPage < 3) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentPage++;
        });
      }
    } else {
      print('Wrong Pin Code');
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey.shade300,
              height: 1.0,
            )),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: StepProgressIndicator(
                roundedEdges: Radius.circular(10),
                padding: 0.0,
                totalSteps: totalSteps,
                currentStep: 0,
                selectedColor: Color(0xFFFF3997),
                unselectedColor: Color.fromARGB(100, 76, 82, 88),
                size: 8.0,
              ),
            ),
            Expanded(
                child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildRegistrationPage(),
                _buildOTPVerificationPage(),
                _buildSetUpPage(),
              ],
            ))
          ],
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_currentPage > 0)
              TextButton(
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  setState(() {
                    _currentPage--;
                  });
                },
                child: const Text("Back"),
              ),
            TextButton(
              onPressed: _navToOTPPage,
              style: TextButton.styleFrom(
                fixedSize: const Size(120, 42),
                backgroundColor: const Color(0xffFF3997),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                _currentPage < 1 ? "Next" : "Submit",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildRegistrationPage() {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
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
                textEditingController: _fullNameController,
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
                  color: isGenderError ? Colors.red : Colors.white,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: ReusableDropdown(
                dropdownItems: languageProvider.lan == 'English'
                    ? sabaiAppData.genderItemsInEng
                    : sabaiAppData.genderItemsInMm,
                selectedItem: _selectedGender,
                cusHeight: 36,
                cusWidth: 400,
                whenOnChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                    isGenderError = false;
                  });
                },
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
                  color: isGenderError ? Colors.red : Colors.white,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: ReusableDatePicker(
                  choosenLanguage: languageProvider.lan == 'English'
                      ? ('Select Date')
                      : ('နေ့စွဲ ရွေးချယ်ပါ'),
                  onDateSelected: _handleDateSelected),
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
              textEditingController: _phoneNumberController,
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
                controller: _emailController,
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

  // OTP Verification Page
  Widget _buildOTPVerificationPage() {
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
            appContext: context,
            length: 6,
            onCompleted: _navToSetUp,
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

  // Profile Set Up Page
  Widget _buildSetUpPage() {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Align(
              alignment: Alignment.topLeft,
              child: ReusableContentHolder(
                  content: languageProvider.lan == 'English'
                      ? 'We need a bit more information to finalize'
                          '\nyour profile. This ensure your account is'
                          '\nsecure and verified.'
                      : 'သင့်ပရိုဖိုင်ကို လုံခြုံစေဖို့ အတည်ပြုရန် အခြားအချက်အလက် အနည်းငယ် လိုအပ်ပါသည်။'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: languageProvider.lan == 'English'
                    ? const TextSpan(
                        text: 'Select Province',
                        style: TextStyle(
                          fontFamily: 'Bricolage-M',
                          fontSize: 15.63,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      )
                    : const TextSpan(
                        text: 'ခရိုင်',
                        style: TextStyle(
                          fontFamily: 'Walone-B',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          // Select District Dropdown
          ReusableDropdown(
              dropdownItems: sabaiAppData.provinceItemsInEng,
              selectedItem: _selectedProvince,
              cusHeight: 36,
              cusWidth: 400,
              whenOnChanged: (value) {
                setState(() {
                  _selectedProvince = value;
                });
              },
              hintText: languageProvider.lan == 'English'
                  ? 'Select Province'
                  : 'ခရိုင် ရွေးချယ်ပါ'),
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 12),
            child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: languageProvider.lan == 'English'
                    ? const TextSpan(
                        text: 'Years in Thailand',
                        style: TextStyle(
                          fontFamily: 'Bricolage-M',
                          fontSize: 15.63,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      )
                    : const TextSpan(
                        text: 'ထိုင်းနိုင်ငံတွင် နေထိုင်သည့်နှစ်',
                        style: TextStyle(
                          fontFamily: 'Walone-B',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: SizedBox(
                  height: 36,
                  child: TextField(
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
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00ffffff),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      focusedBorder: OutlineInputBorder(
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
                          EdgeInsets.only(top: 1, bottom: 1, left: 10),
                      hintStyle: TextStyle(
                        color: Color(0xFF7B838A),
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
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
                    ? selectedDuration
                    : selectedDurationMM,
                cusHeight: 36,
                cusWidth: 96,
                whenOnChanged: (value) {
                  setState(() {
                    selectedDuration = value;
                  });
                },
                hintText: selectedDuration,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 12),
            child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: languageProvider.lan == 'English'
                    ? const TextSpan(
                        text: 'Thai Language Proficiency',
                        style: TextStyle(
                          fontFamily: 'Bricolage-M',
                          fontSize: 15.63,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      )
                    : const TextSpan(
                        text: 'ထိုင်းဘာသာအရည်ချင်း',
                        style: TextStyle(
                          fontFamily: 'Walone-B',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          ReusableDropdown(
              dropdownItems: sabaiAppData.languageLevelsInEng,
              selectedItem: _selectedLanguageLevel,
              cusHeight: 36,
              cusWidth: 400,
              whenOnChanged: (value) {
                setState(() {
                  _selectedLanguageLevel = value;
                });
              },
              hintText: languageProvider.lan == 'English'
                  ? 'Select your Thai proficiency'
                  : 'ခရိုင် ရွေးချယ်ပါ'),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 12),
            child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: languageProvider.lan == 'English'
                    ? const TextSpan(
                        text: 'Do you have passport ?',
                        style: TextStyle(
                          fontFamily: 'Bricolage-M',
                          fontSize: 15.63,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      )
                    : const TextSpan(
                        text: 'နိုင်ငံကူးလက်မှတ်ရှိသလား',
                        style: TextStyle(
                          fontFamily: 'Walone-B',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ReusableRadioButton(
                rButtonValue: 'Yes',
                rButtonSelectedValue: selectedOptionPp,
                rButtonChoosen: (value) {
                  setState(() {
                    selectedOptionPp = value;
                  });
                },
                rButtonName: languageProvider.lan == 'English' ? 'Yes' : 'ရှိ',
              ),
              const SizedBox(
                width: 20,
              ),
              ReusableRadioButton(
                rButtonValue: 'No',
                rButtonSelectedValue: selectedOptionPp,
                rButtonChoosen: (value) {
                  setState(() {
                    selectedOptionPp = value;
                  });
                },
                rButtonName: languageProvider.lan == 'English' ? 'No' : 'မရှိ',
              ),
            ],
          ),
          if (selectedOptionPp == 'Yes') ...[
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 12),
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
                    style: const TextStyle(
                      fontFamily: 'Bricolage-R',
                      fontWeight: FontWeight.w100,
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
                          ? ("Enter your passport number")
                          : 'သင့်နိုင်ငံကူးလက်မှတ်နံပါတ် ထည့်ပါ',
                      contentPadding:
                          const EdgeInsets.only(top: 1, bottom: 1, left: 10),
                      hintStyle: const TextStyle(
                        color: Color(0xFF7B838A),
                        fontSize: 14,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 12),
            child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: languageProvider.lan == 'English'
                    ? const TextSpan(
                        text: 'Do you have work permit ?',
                        style: TextStyle(
                          fontFamily: 'Bricolage-M',
                          fontSize: 15.63,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      )
                    : const TextSpan(
                        text: 'အလုပ်သမား ဗီဇာရှိပါသလား ?',
                        style: TextStyle(
                          fontFamily: 'Walone-B',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ReusableRadioButton(
                rButtonValue: 'Yes',
                rButtonSelectedValue: selectedOptionWp,
                rButtonChoosen: (value) {
                  setState(() {
                    selectedOptionWp = value;
                  });
                },
                rButtonName: languageProvider.lan == 'English' ? 'Yes' : 'ရှိ',
              ),
              const SizedBox(
                width: 20,
              ),
              ReusableRadioButton(
                rButtonValue: 'No',
                rButtonSelectedValue: selectedOptionWp,
                rButtonChoosen: (value) {
                  setState(() {
                    selectedOptionWp = value;
                  });
                },
                rButtonName: languageProvider.lan == 'English' ? 'No' : 'မရှိ',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
