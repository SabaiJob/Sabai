import 'package:flutter/material.dart';
import 'package:sabai_app/components/reusable_content_holder.dart';
import 'package:sabai_app/components/reusable_dropdown.dart';
import 'package:sabai_app/components/reusable_radio_button.dart';
import 'package:sabai_app/components/reusable_title_holder.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/verification_page.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import '../services/language_provider.dart';
import 'package:provider/provider.dart';

class UserProfileSetupPage extends StatefulWidget {
  const UserProfileSetupPage({super.key});

  @override
  State<UserProfileSetupPage> createState() => _UserProfileSetupPageState();
}

class _UserProfileSetupPageState extends State<UserProfileSetupPage> {
  final List<String> districtItems = [
    'Bang Khen',
    'Mueang Chiang Mai',
    'Mueang Chiang Rai'
  ];
  String? selectedDistrict;
  final List<String> cityItems = ['Bangkok', 'Chiang Mai', 'Chiang Rai'];
  String? selectedCity;
  final List<String> durationItems = ['Months', 'Years'];
  final List<String> durationItemsMM = ['လ', 'နှစ်'];
  String? selectedDuration = 'Years';
  String? selectedDurationMM = 'နှစ်';
  String? selectedOptionPp;
  String? selectedOptionWp;

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          child: Column(
            children: [
              // StepProgressIndicator
              Container(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: const StepProgressIndicator(
                  roundedEdges: Radius.circular(10),
                  padding: 0.0,
                  totalSteps: 3,
                  currentStep: 1,
                  selectedColor: Color(0xFFFF3997),
                  unselectedColor: Color.fromARGB(100, 76, 82, 88),
                  size: 8.0,
                ),
              ),

              Container(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ReusableTitleHolder(
                      title: languageProvider.lan == 'English'
                          ? 'Complete Your Profile'
                          : 'ပရိုဖိုင်ကို ပြီးပြည့်စုံစွာ ပြုလုပ်ပါ'),
                ),
              ),

              Container(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ReusableContentHolder(
                      content: languageProvider.lan == 'English'
                          ? 'We need a bit more information to finalize'
                              '\nyour profile. This ensure your account is'
                              '\nsecure and verified.'
                          : 'သင့်ပရိုဖိုင်ကို လုံခြုံစေဖို့ အတည်ပြုရန် အခြားအချက်အလက်'
                              '\nအနည်းငယ် လိုအပ်ပါသည်။'),
                ),
              ),

              //Select District
              Container(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: languageProvider.lan == 'English'
                        ? const TextSpan(
                            text: 'Select District',
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
                  dropdownItems: districtItems,
                  selectedItem: selectedDistrict,
                  cusHeight: 36,
                  cusWidth: 400,
                  whenOnChanged: (value) {
                    setState(() {
                      selectedDistrict = value;
                    });
                  },
                  hintText: languageProvider.lan == 'English'
                      ? 'Select District'
                      : 'ခရိုင် ရွေးချယ်ပါ'),

              //Select City
              Container(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: languageProvider.lan == 'English'
                        ? const TextSpan(
                            text: 'Select City',
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
                            text: 'မြို့',
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
              // Select City Dropdown
              ReusableDropdown(
                  dropdownItems: cityItems,
                  selectedItem: selectedCity,
                  cusHeight: 36,
                  cusWidth: 400,
                  whenOnChanged: (value) {
                    setState(() {
                      selectedCity = value;
                    });
                  },
                  hintText: languageProvider.lan == 'English'
                      ? 'Select City'
                      : 'မြို့ ရွေးချယ်ပါ '),

              //Years in Thailand
              Container(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 240,
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
                  ReusableDropdown(
                    dropdownItems: languageProvider.lan == "English"
                        ? durationItems
                        : durationItemsMM,
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
              // Thai Proficiency
              Container(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
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
              // Thai Language Proficiency
              const SizedBox(
                width: 400,
                height: 36,
                child: TextField(
                  style: TextStyle(
                    fontFamily: 'Bricolage-R',
                    fontWeight: FontWeight.w100,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
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
                    hintText: ("will be provided later"),
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

              //Do you have passport Y/N question
              Container(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
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
              // answer choice yes/no
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
                    rButtonName:
                        languageProvider.lan == 'English' ? 'Yes' : 'ရှိ',
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
                    rButtonName:
                        languageProvider.lan == 'English' ? 'No' : 'မရှိ',
                  ),
                ],
              ),
              //Passport Number Textfield only appear when the user chose yes
              if (selectedOptionPp == 'Yes') ...[
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
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
                          contentPadding: const EdgeInsets.only(
                              top: 1, bottom: 1, left: 10),
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

              // Do you have work permit YES/NO question ?
              Container(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
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
              // DO you have work permit Y/N Radio Button
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
                    rButtonName:
                        languageProvider.lan == 'English' ? 'Yes' : 'ရှိ',
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
                    rButtonName:
                        languageProvider.lan == 'English' ? 'No' : 'မရှိ',
                  ),
                ],
              ),

              // for some space
              const SizedBox(
                height: 30,
              ),

              // Continue Button
              Container(
                width: 400,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VerificationPage(),
                      ),
                    );
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
                          ? Text(
                              'Continue',
                              style: GoogleFonts.bricolageGrotesque(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.63,
                                ),
                              ),
                            )
                          : Text(
                              'ဆက်လက်ရန်',
                              style: GoogleFonts.bricolageGrotesque(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
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
          ),
        ),
      ),
    );
  }
}
