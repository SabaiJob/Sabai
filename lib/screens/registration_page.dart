import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabai_app/components/reusable_content_holder.dart';
import 'package:sabai_app/components/reusable_dropdown.dart';
import 'package:sabai_app/components/reusable_textformfield.dart';
import 'package:sabai_app/components/reusable_title_holder.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/otp_verification_page.dart';
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
  final List<String> genderItemsEng = ['male', 'female', 'others'];
  final List<String> genderItemsMm = ['ကျား','မ', 'အခြား'];
  String? selectedGender;
  // Form Key and Controllers
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // progress indicator bar
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
                          ? 'Tell Us About Yourself'
                          : 'ကိုယ်ရေးကိုယ်တာအချက်လက်',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: ReusableContentHolder(
                        content: languageProvider.lan == 'English'
                            ? 'Please provide your basic information to get'
                                '\nstarted. This helps us tailor job opportunities'
                                '\njust for you.'
                            : 'အကောင့်အသစ်ပြုလုပ်ရန်သင့်ကိုယ်ရေးကိုယ်တာအချက်လက်'
                                '\nများကိုထည့်သွင်းပေးပါ။'
                                '\nသင့်တင့်သော အလုပ်အကိုင်အခွင့်အလမ်းများကို ရှာဖွေဖို့'
                                '\nဒီအချက်အလက်တွေက အရမ်းအရေးကြီးပါတယ်။'),
                  ),
                ),
                // Full Name
                Container(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: languageProvider.lan == 'English'
                          ? const TextSpan(
                              text: 'Full Name',
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
                              text: 'အမည်',
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

                // Full Name TextFormField
                ReusableTextformfield(
                    textEditingController: _fullNameController,
                    validating: (value) {
                      if (value == null || value.isEmpty) {
                        return "Full Name is required";
                      }
                      return null;
                    },
                    hint: languageProvider.lan == 'English'
                        ? 'Enter your full name'
                        : 'သင့်အမည် ထည့်ပါ'),

                // Gender
                Container(
                  padding: const EdgeInsets.only(top: 1, bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: languageProvider.lan == 'English'
                          ? const TextSpan(
                              text: 'Gender ',
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
                              text: 'လိင် ',
                              style: TextStyle(
                                fontFamily: 'Walone-B',
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                    color: Colors.pink,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                // Gender Picker
                ReusableDropdown(
                    dropdownItems: languageProvider.lan == 'English' 
                    ? genderItemsEng : genderItemsMm,
                    selectedItem: selectedGender,
                    cusHeight: 36,
                    cusWidth: 400,
                    whenOnChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                    hintText: languageProvider.lan == 'English'
                        ? 'Select One'
                        : 'တစ်ခုရွေးချယ်ပါ'),

                //Birthday
                Container(
                  padding: const EdgeInsets.only(top: 22, bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: languageProvider.lan == 'English'
                          ? const TextSpan(
                              text: 'Birthday',
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
                              text: 'မွေးနေ့',
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
                //Birthday Date Picker
                SizedBox(
                  width: 400,
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
                          ? ("Select Date")
                          : ("နေ့စွဲ ရွေးချယ်ပါ"),
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
                // Phone Number
                Container(
                  padding: const EdgeInsets.only(top: 22, bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: languageProvider.lan == 'English'
                          ? const TextSpan(
                              text: 'Phone Number',
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
                              text: 'ဖုန်းနံပါတ်',
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

                //Phone Number TextFormField
                ReusableTextformfield(
                    textEditingController: _phoneNumberController,
                    validating: (value) {
                      if (value == null || value.isEmpty) {
                        return "Phone Number is required";
                      }
                      return null;
                    },
                    hint: '+66 2134567'),
                // Email Address
                Container(
                  padding: const EdgeInsets.only(top: 1, bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: languageProvider.lan == 'English'
                        ? const Text(
                            "Email Address",
                            style: TextStyle(
                              fontFamily: 'Bricolage-M',
                              fontSize: 15.63,
                              color: Colors.black,
                            ),
                          )
                        : const Text(
                            "အီးမေးလ် လိပ်စာ",
                            style: TextStyle(
                              fontFamily: 'Walone-B',
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                  ),
                ),
                // Email Address TextField
                SizedBox(
                  width: 400,
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

                // for some space
                const SizedBox(
                  height: 50,
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
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OtpVerificationPage(),
                          ),
                        );
                      } else {
                        // form validation failed
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Please completed all the required fields")));
                      }
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
      ),
    );
  }
}
