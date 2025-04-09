import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/data/sabai_app_data.dart';
import 'package:sabai_app/screens/navigation_homepage.dart';
import 'package:sabai_app/screens/auth_pages/log_in_form_page.dart';
import 'package:sabai_app/screens/auth_pages/otp_code_verification_page.dart';
import 'package:sabai_app/screens/auth_pages/token_service.dart';
import 'package:sabai_app/services/job_provider.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:sabai_app/services/phone_number_provider.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  final TextEditingController _emailController = TextEditingController();

  //user login
  Future<void> userLogin() async {
    const String url = 'https://api.sabaijob.com/api/auth/login/';

    final Map<String, dynamic> requestBody = {
      //'full_name': _fullNameController.text,
      //'phone': _phoneNumberController.text,
      'email' : _emailController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        requestOTP();
        setState(() {
          _currentPage++;
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login failed: ${response.body}'),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
          ),
        );
      }
    }
  }

  //request OTP
  Future<void> requestOTP() async {
    // const String url =
    //     'https://sabai-job-backend-k9wda.ondigitalocean.app/api/auth/otp/request/';
    const String url = 'https://api.sabaijob.com/api/auth/otp/request/';

    final Map<String, dynamic> requestBody = {
      //"phone": _phoneNumberController.text,
      "email" : _emailController.text,
    };

    try {
      final otpReqResponse = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (otpReqResponse.statusCode == 200) {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        // Handle errors
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('OTP request failed: ${otpReqResponse.body}'),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  // User Log In
  void _handleUserLogin(PhoneNumberProvider phoneNumberProvider) {
    bool isFormValid = _formKey.currentState!.validate();
    if (isFormValid) {
      print('Your full name: ${_fullNameController.text}');
      print('Your Phone Number: ${_phoneNumberController.text}');
      phoneNumberProvider
          .setEmail(_emailController.text.toString().trim());
      // _pageController.nextPage(
      //     duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      // setState(() {
      //   _currentPage++;
      // });
      userLogin();
    }
  }

  // OTP Code Verification
  void _handleOTPVerificationPage(
      String enteredPinCode, JobProvider jobProvider) async {
    if (_currentPage == 1) {
      String enteredPinCode = _pinCodeController.text.trim();
      // if (enteredPinCode == sabaiAppData.fixedPinNumber) {
      //   jobProvider.setGuest(false);
      //   Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => const NavigationHomepage(
      //                 showButtonSheet: false,
      //               )));
      // }
      // const String url =
      //     'https://sabai-job-backend-k9wda.ondigitalocean.app/api/auth/otp/confirm/login/';
      const String url = 'https://api.sabaijob.com/api/auth/otp/confirm/login/';

      final Map<String, dynamic> requestBody = {
        //"phone": _phoneNumberController.text,
        'email' : _emailController.text,
        "otp": enteredPinCode,
      };

      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(requestBody),
        );

        if (response.statusCode == 200 && response.statusCode < 300) {
          jobProvider.setGuest(false);
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const NavigationHomepage(
          //       showButtonSheet: false,
          //     ),
          //   ),
          // );
          final responseData = json.decode(response.body);
          final token = responseData['token'];
          print(token);
          await TokenService.saveToken(token);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const NavigationHomepage(
                showButtonSheet: false,
              ),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('OTP confirmation failed: ${response.body}'),
              ),
            );
          }
          print(response.body);
          print(response.statusCode);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var jobProvider = Provider.of<JobProvider>(context);
    var phoneNumberProvider = Provider.of<PhoneNumberProvider>(context);
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
                    phoneNumberController: _phoneNumberController,
                    emailController: _emailController,
                    ),
                OtpCodeVerificationPage(
                    pinCodeController: _pinCodeController,
                    //requestOtp: requestOTP(),
                    whenOnComplete: (value) {
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
                    onPressed: () {
                      _handleUserLogin(phoneNumberProvider);
                    },
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
                                style: textButtonTextStyleEng,
                              )
                            : const Text(
                                'ဆက်လက်ရန်',
                                style: textButtonTextStyleMm,
                              ),
                        const SizedBox(
                          width: 10,
                        ),
                        rightArrowIcon,
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
