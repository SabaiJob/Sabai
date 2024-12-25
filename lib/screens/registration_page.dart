import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sabai_app/components/reusable_content_holder.dart';
import 'package:sabai_app/components/reusable_datepicker.dart';
import 'package:sabai_app/components/reusable_dropdown.dart';
import 'package:sabai_app/components/reusable_label.dart';
import 'package:sabai_app/components/reusable_textformfield.dart';
import 'package:sabai_app/components/reusable_title_holder.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/otp_verification_page.dart';
import 'package:sabai_app/screens/user_profile_setup_page.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../services/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final List<String> _genderItemsEng = ['male', 'female', 'others'];
  final List<String> _genderItemsMm = ['ကျား', 'မ', 'အခြား'];
  String? _selectedGender;
  DateTime? _selectedDate;
  bool isGenderError = false;
  bool isBirthdayError = false;
  String genderErrorMessage = '';
  String birthdayErrorMessage = '';

  void _handleDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      isBirthdayError = false;
    });
    print('Selected Date: $date'); // Do something with the selected date
  }
  

  // Form Key and Controllers
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
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
      body: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 30),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // progress indicator bar
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: const StepProgressIndicator(
                    roundedEdges: Radius.circular(10),
                    padding: 0.0,
                    totalSteps: 3,
                    currentStep: 0,
                    selectedColor: Color(0xFFFF3997),
                    unselectedColor: Color.fromARGB(100, 76, 82, 88),
                    size: 8.0,
                  ),
                ),

                // title
                Container(
                   padding: const EdgeInsets.symmetric(vertical: 8),
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
                Container(
                   padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: ReusableContentHolder(
                        content: languageProvider.lan == 'English'
                            ? 'Please provide your basic information to get started. This helps us tailor job opportunities just for you.'
                            : 'အကောင့်အသစ်ပြုလုပ်ရန် သင့်ကိုယ်ရေးကိုယ်တာအချက်လက်များကိုထည့်သွင်းပေးပါ။ သင့်တင့်သော အလုပ်အကိုင်အခွင့်အလမ်းများကို ရှာဖွေဖို့ ဒီအချက်အလက်တွေက အရမ်းအရေးကြီးပါတယ်။'),
                  ),
                ),

                // Full Name
                Padding(
                   padding: const EdgeInsets.symmetric(vertical: 8),
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

                // Full Name TextFormField
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

                // Gender
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ReusableLabelHolder(
                    labelName:
                        languageProvider.lan == 'English' ? 'Gender' : 'လိင်',
                    textStyle: languageProvider.lan == 'English'
                        ? labelStyleEng
                        : labelStyleMm,
                    isStarred: true,
                  ),
                ),

                // Gender Picker
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
                        ? _genderItemsEng
                        : _genderItemsMm,
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
                        style: languageProvider.lan == 'English' ? const TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontFamily: 'Bricolage-M') : const TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontFamily: 'Walone-R'),
                      ),
                    ),
                  ),

                // Birthday
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 8),
                  child: ReusableLabelHolder(
                    labelName: languageProvider.lan == 'English'
                        ? 'Birthday'
                        : 'မွေးနေ့',
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
                        style: languageProvider.lan == 'English' ? const TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontFamily: 'Bricolage-M') : const TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontFamily: 'Walone-R'),
                      ),
                    ),
                  ),

                // Phone Number
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 8),
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

                // Email Address
                Padding(
                  padding: const EdgeInsets.only(top: 5,bottom: 8),
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
        ),
      ),
      persistentFooterButtons: [
        Column(
          children: [
            Container(
              width: 375,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const OtpVerificationPage(
                  //         navWidget: UserProfileSetupPage(),
                  //         signUp: true,
                  //       ),
                  //     ),
                  //   );
                  // } else {
                  //   // form validation failed
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //     content: languageProvider.lan == 'English'
                  //         ? const Text(
                  //             "Please completed all the required fields")
                  //         : const Text(
                  //             "လိုအပ်သောအကွက်များအားလုံးကို ဖြည့်စွက်ပါ။")));
                  // }
                  setState(() {
                    isGenderError = _selectedGender == null;
                    isBirthdayError = _selectedDate == null;

                    genderErrorMessage =
                        isGenderError ? (languageProvider.lan == 'English'?  "   Gender is required" : "   လိင်အမျိုးအစားရွေးချယ်ရန်လိုအပ်သည်" ): '';
                    birthdayErrorMessage =
                        isBirthdayError ? (languageProvider.lan == 'English' ? "   Birthday is required" : "   မွေးဖွားသည့်နေ့ရွေးချယ်ရန်လိုအပ်သည်") : '';
                  });

                  if (_formKey.currentState!.validate() &&
                      !isGenderError &&
                      !isBirthdayError) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OtpVerificationPage(
                          navWidget: UserProfileSetupPage(),
                          signUp: true,
                        ),
                      ),
                    );
                    print('username: $_fullNameController');
                    print('gender : $_selectedGender');
                    print('DOB : $_selectedDate');
                    print('Phone Number : $_phoneNumberController');
                  } 
                  // else {
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //       content: languageProvider.lan == 'English'
                  //           ? const Text(
                  //               "Please complete all the required fields")
                  //           : const Text(
                  //               "လိုအပ်သောအကွက်များအားလုံးကို ဖြည့်စွက်ပါ။")));
                  // }
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xffFF3997),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Set the border radius
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    languageProvider.lan == 'English'
                        ? const Text(
                            'Continue',
                            style: TextStyle(
                              fontFamily: 'Bricolage-B',
                              fontSize: 15.63,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'ဆက်လက်ရန်',
                            style: TextStyle(
                              fontFamily: 'Walone-B',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      CupertinoIcons.arrow_right,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }
}
