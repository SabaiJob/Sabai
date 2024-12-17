import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/reusable_content_holder.dart';
import 'package:sabai_app/components/reusable_textformfield.dart';
import 'package:sabai_app/screens/homepage.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:sabai_app/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
        backgroundColor: const Color(0xffF7F7F7),
        appBar: AppBar(
          backgroundColor: const Color(0xffF7F7F7),
          title: languageProvider.lan == 'English'
              ? const Text(
                  'Log In',
                  style: appBarTitleStyleEng,
                )
              : const Text(
                  '၀င်ရောက်ရန်',
                  style: TextStyle(
                    fontFamily: "Bricolage-M",
                    fontSize: 19.53,
                  ),
                ),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    languageProvider.lan == 'English'
                        ? const Text(
                            'User Register',
                            style: appBarTitleStyleEng,
                          )
                        : const Text(
                            'အကောင့်က၀င်ရောက်ရန်',
                            style: appBarTitleStyleMn,
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReusableContentHolder(
                        content: languageProvider.lan == 'English'
                            ? 'Lorem ipsum dolor sit amet consectetur. Ut vel'
                                '\nnvitae sed quam maecenas cursus pharetra.'
                            : 'သင့်အကောင့်ကို၀င်ရောက်ဖို့ ဒီအချက်အလက်တွေကိုဖြည့်ပါ'),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
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
                                    color: Colors.red,
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
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ReusableTextformfield(
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
                    RichText(
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
                    const SizedBox(
                      height: 10,
                    ),
                    ReusableTextformfield(
                        textEditingController: _phoneNumberController,
                        validating: (value) {
                          if (value == null || value.isEmpty) {
                            return languageProvider.lan == 'English'
                                ? "Phone Number is required"
                                : "ဖုန်းနံပါတ်ထည့်ရန်လိုအပ်သည်";
                          }
                          return null;
                        },
                        hint: '+66 2134567'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 45),
                child: Container(
                  width: 365,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          barrierDismissible:
                              false, // Prevent dismissal by tapping outside
                          builder: (context) {
                            return const Dialog(
                              backgroundColor: Colors.white,
                              child: SizedBox(
                                width: 170,
                                height: 200,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 110,
                                      width: 110,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SizedBox(
                                            height: 70, // Outer circle size
                                            width: 70,
                                            child: CircularProgressIndicator(
                                              color: Color(0xffFF3997),
                                              strokeWidth:
                                                  4.0, // Outer circle thickness
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30, // Inner circle size
                                            width: 30,
                                            child: CircularProgressIndicator(
                                              color: Color(0xffFF3997),
                                              strokeWidth:
                                                  4.0, // Inner circle thickness
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 35,
                                    ),
                                    Text(
                                      'Loggin...',
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        fontFamily: 'Bricolage-R',
                                        color: Color(0xff41464B),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                        Future.delayed(
                          const Duration(seconds: 3),
                          () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Homepage(),
                              ),
                            );
                          },
                        );
                      } else {
                        // form validation failed
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: languageProvider.lan == 'English'
                                  ? const Text(
                                      "Please completed all the required fields")
                                  : const Text(
                                      "လိုအပ်သောအကွက်များအားလုံးကို ဖြည့်စွက်ပါ။")),
                        );
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
                                'Log In',
                                style: GoogleFonts.bricolageGrotesque(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.63,
                                  ),
                                ),
                              )
                            : Text(
                                '၀င်ရောက်ရန်',
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
                ),
              ),
            ],
          ),
        ));
  }
}
