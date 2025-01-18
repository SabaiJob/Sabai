import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/data/sabai_app_data.dart';
import 'package:sabai_app/screens/navigation_homepage.dart';
import 'package:sabai_app/screens/registration_&_login_pages/log_in_form_page.dart';
import 'package:sabai_app/screens/registration_&_login_pages/otp_code_verification_page.dart';
import 'package:sabai_app/services/job_provider.dart';
import 'package:sabai_app/services/language_provider.dart';
import '../../constants.dart';

class LogInControllerPage extends StatefulWidget {
  const LogInControllerPage({super.key});

  @override
  State<LogInControllerPage> createState() => _LogInControllerPageState();
}

class _LogInControllerPageState extends State<LogInControllerPage> {
  SabaiAppData sabaiAppData = SabaiAppData();
  int _currentPage = 0;
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  // User Log In
  void _handleUserLogin() {
    bool isFormValid = _formKey.currentState!.validate();
    if (isFormValid) {
      print('Your full name: ${_fullNameController.text}');
      print('Your Phone Number: ${_phoneNumberController.text}');
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() {
        _currentPage++;
      });
    }
  }

  // OTP Code Verification
  void _handleOTPVerificationPage(String enteredPinCode, JobProvider jobProvider) {
    if (_currentPage == 1) {
      String enteredPinCode = _pinCodeController.text.trim();
      if (enteredPinCode == sabaiAppData.fixedPinNumber) {
        jobProvider.setGuest(false);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const NavigationHomepage(showButtonSheet: false,)));
        // _pageController.nextPage(
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.easeInOut,
        // );
        // setState(() {
        //   _currentPage++;
        // });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var jobProvider = Provider.of<JobProvider>(context);
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
                "Log In",
                style: appBarTitleStyleEng,
              )
            : const Text(
                '၀င်ရောက်ရန်',
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
          children: [
            Expanded(
                child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                LogInFormPage(
                    formKey: _formKey,
                    fullNameController: _fullNameController,
                    phoneNumberController: _phoneNumberController),
                OtpCodeVerificationPage(
                    pinCodeController: _pinCodeController,
                    whenOnComplete: (value){
                      _handleOTPVerificationPage(value, jobProvider);
                    })
              ],
            ))
          ],
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: (_currentPage == _pageController.initialPage)
          ? [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _handleUserLogin,
                    style: TextButton.styleFrom(
                      fixedSize: const Size(343, 42),
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
                                'Log In',
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
                ],
              ),
            ]
          : null,
    );
  }
}
