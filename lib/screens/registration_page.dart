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
  final List<String> genderItems = ['male', 'female', 'others'];
  String? selectedGender;
  // Form Key and Controllers
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFFF0F1F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Create Profile", style: aBTitlteStyle),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 30),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // progress indicator bar
                Container(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
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
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: ReusableTitleHolder(title: 'Tell Us About Yourself',),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: ReusableContentHolder(content: 'Please provide your basic information to get\nstarted. This helps us tailor job opportunities\njust for you.'),
                  ),
                ),
                // Full Name
                Container(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: const TextSpan(
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
                      ),
                    ),
                  ),
                ),
                
                // Full Name TextFormField
                ReusableTextformfield(textEditingController: _fullNameController, 
                validating: (value){
                  if(value == null || value.isEmpty){
                        return "Full Name is required";
                      }
                      return null;
                }, 
                hint: 'Enter your full name'),
            
                // Gender
                Container(
                  padding: EdgeInsets.only(top: 1, bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: const TextSpan(
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
                      ),
                    ),
                  ),
                ),
                // Gender Picker
                ReusableDropdown(dropdownItems: genderItems, selectedItem: selectedGender, cusHeight: 36,cusWidth: 400, whenOnChanged: (value){
                  setState(() {
                    selectedGender = value;
                  });
                }, hintText: 'Select One'),
            
                //Birthday 
                Container(
                  padding: EdgeInsets.only(top: 22, bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: const TextSpan(
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
                      ),
                    ),
                  ),
                ),
                //Birthday Date Picker
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
                    decoration:  InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFFFFF),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFFFFF),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: ("Select Date"),
                      contentPadding: EdgeInsets.only(top: 1, bottom: 1, left: 10),
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
                // Phone Number
                Container(
                  padding: EdgeInsets.only(top: 22, bottom: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: const TextSpan(
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
                      ),
                    ),
                  ),
                ),
                
                
                //Phone Number TextFormField
               ReusableTextformfield(textEditingController: _phoneNumberController,
                validating: (value){
                  if(value == null || value.isEmpty){
                        return "Phone Number is required";
                      }
                      return null;
                }, 
                hint: '+66 2134567'),
                // Email Address
                Container(
                  padding: EdgeInsets.only(top: 1, bottom: 12),
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Email Address",  style: TextStyle(
                          fontFamily: 'Bricolage-M',
                          fontSize: 15.63,
                          color: Colors.black,
                        ),),
                  ),
                ),
                // Email Address TextField
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
                    decoration:  InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFFFFF),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFFFFF),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: ("Enter your email address"),
                      hintStyle: TextStyle(
                        color: Color(0xFF7B838A),
                        fontSize: 14,
                      ),
                      contentPadding: EdgeInsets.only(top: 1, bottom: 1, left: 10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
            
                // for some space
                SizedBox(
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
                              if(_formKey.currentState!.validate()){
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const OtpVerificationPage(),
                                ),
                              );
                              } else{
                                // form validation failed
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content:Text("Please completed all the required fields")));
                              }
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xffFF3997),
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