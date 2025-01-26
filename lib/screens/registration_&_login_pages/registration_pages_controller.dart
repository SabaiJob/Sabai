import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sabai_app/components/reusable_double_circle_loading_component.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/data/sabai_app_data.dart';
import 'package:sabai_app/screens/registration_&_login_pages/otp_code_verification_page.dart';
import 'package:sabai_app/screens/registration_&_login_pages/complete_user_registration_page.dart';
import 'package:sabai_app/screens/registration_&_login_pages/initial_registration_page.dart';
import 'package:sabai_app/screens/registration_&_login_pages/select_job_category_page.dart';
import 'package:sabai_app/screens/success_page.dart';
import 'package:sabai_app/services/job_provider.dart';
import 'package:sabai_app/services/phone_number_provider.dart';
import '../../services/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrationPagesController extends StatefulWidget {
  const RegistrationPagesController({super.key});

  @override
  State<RegistrationPagesController> createState() =>
      _RegistrationPagesControllerState();
}

class _RegistrationPagesControllerState
    extends State<RegistrationPagesController> {
  SabaiAppData sabaiAppData = SabaiAppData();
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _passportController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();

  //register user
  Future<void> registerUser() async {
    const String url =
        'https://sabai-job-backend-k9wda.ondigitalocean.app/api/auth/register/';

    String selectedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);

    final Map<String, dynamic> requestBody = {
      "phone": _phoneNumberController.text,
      "full_name": _fullNameController.text,
      "email": _emailController.text,
      "date_of_birth": selectedDate,
      "gender": _selectedGender,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 201) {
        //OTP request
        requestOTP();
        setState(() {
          _currentPage++;
          _progressStep++;
        });
      } else {
        // Handle errors
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registration failed: ${response.body}'),
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
    const String url =
        'https://sabai-job-backend-k9wda.ondigitalocean.app/api/auth/otp/request/';

    final Map<String, dynamic> requestBody = {
      "phone": _phoneNumberController.text,
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

  int _currentPage = 0;

  String? _selectedGender;
  bool _isGenderError = false;
  String _genderErrorMessage = '';

  bool _isBirthdayError = false;
  String _birthdayErrorMessage = '';
  DateTime? _selectedDate;

  String? _selectedProvince;
  bool _isProvinceError = false;
  String? _provinceErrorMessage = '';

  String? _selectedDurationEng = 'Years';
  String? _selectedDurationMM = 'နှစ်';
  bool _isDurationError = false;
  String? _durationErrorMessage = '';

  String? _selectedLanguageLevel;
  bool _isLanguageLevelError = false;
  String? _languageLevelErrorMessage = '';

  String? _selectedOptionPp;
  bool _isSelectedOptionPpError = false;
  String? _pPErrorMessage = '';

  String? _selectedOptionWp;
  bool _isSelectedOptionWpError = false;
  String? _wPErrorMessage = '';

  bool? _isPassportFieldError = false;
  String? _passportFieldErrorMessage = '';

  int _progressStep = 0;

  void _handleDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      _isBirthdayError = false;
    });
    //print('Selected Date: $date');
  }

  // User Registration
  void _handleUserRegistration(PhoneNumberProvider phoneNumberProvider) {
    if (_currentPage == _pageController.initialPage) {
      _isGenderError = _selectedGender == null;
      _isBirthdayError = _selectedDate == null;
      setState(() {
        _genderErrorMessage = _isGenderError ? " Gender is required " : '';
        _birthdayErrorMessage =
            _isBirthdayError ? ' Birthday is required ' : '';
      });
      bool isFormValid = _formKey.currentState!.validate();
      bool noErrors = !_isGenderError && !_isBirthdayError;
      if (isFormValid && noErrors) {
        print('Your Full Name: ${_fullNameController.text}');
        print('Your Gender: ${_selectedGender}');
        print('Your Birthday: ${_selectedDate}');
        print('Your Phone Number: ${_phoneNumberController.text}');
        print('Your email address: ${_emailController.text}');
        phoneNumberProvider
            .setPhoneNumber(_phoneNumberController.text.toString().trim());
        // Move to the next page
        // _pageController.nextPage(
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.easeInOut,
        // );
        registerUser();
      }
    }
  }

  // Profile Set Up (additional info)
  void _handleProfileSetUp() {
    if (_currentPage == 2) {
      _isProvinceError = _selectedProvince == null;
      _isLanguageLevelError = _selectedLanguageLevel == null;
      _isDurationError = _yearsController.text.trim().isEmpty;
      _isSelectedOptionPpError = _selectedOptionPp == null;
      _isSelectedOptionWpError = _selectedOptionWp == null;
      _isPassportFieldError =
          _selectedOptionPp == 'Yes' && _passportController.text.trim().isEmpty;

      setState(() {
        _provinceErrorMessage =
            _isProvinceError ? ' Province is required ' : '';
        _durationErrorMessage =
            _isDurationError ? ' Timeline is required ' : '';
        _languageLevelErrorMessage =
            _isLanguageLevelError ? ' Language Level is required ' : '';
        _pPErrorMessage =
            _isSelectedOptionPpError ? ' You need to answer this ' : '';
        _wPErrorMessage =
            _isSelectedOptionWpError ? ' You need to answer this ' : '';
        _passportFieldErrorMessage = _isPassportFieldError!
            ? ' You need to fill your passport number '
            : '';
      });
      bool noErrors = !_isProvinceError &&
          !_isLanguageLevelError &&
          !_isDurationError &&
          !_isSelectedOptionPpError &&
          !_isSelectedOptionWpError &&
          !_isPassportFieldError!;
      if (noErrors) {
        print('Your Province : ${_selectedProvince}');
        print(
            'Duration in Timeline : ${_yearsController.text} ${_selectedDurationEng}');
        print('Your Thai Language Proficiency : ${_selectedLanguageLevel}');
        print('Do you have passport ? Y/N : ${_selectedOptionPp}');
        print('Your passport number: ${_passportController.text}');
        print('Do you have work permit ? Y/N ${_selectedOptionWp}');
        print(
            'Congratulations! You have completed all the required fields for the registration');
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() {
          _progressStep++;
          _currentPage++;
        });
      } else {
        print('You need to complete all fields');
      }
    }
  }

  // OTP Code Verification
  void _handleOTPVerificationPage(
      String enteredPinCode, JobProvider jobProvider) async {
    if (_currentPage == 1) {
      String enteredPinCode = _pinCodeController.text.trim();

      //modified part
      // if (enteredPinCode == sabaiAppData.fixedPinNumber) {
      //   jobProvider.setGuest(false);
      //   _pageController.nextPage(
      //     duration: const Duration(milliseconds: 300),
      //     curve: Curves.easeInOut,
      //   );
      //   setState(() {
      //     _currentPage++;
      //     _progressStep++;
      //   });
      // }

      const String url =
          'https://sabai-job-backend-k9wda.ondigitalocean.app/api/auth/otp/confirm/register/';

      final Map<String, dynamic> requestBody = {
        "phone": _phoneNumberController.text,
        "otp": enteredPinCode,
      };

      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(requestBody),
        );

        if (response.statusCode == 200) {
          jobProvider.setGuest(false);
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          setState(() {
            _currentPage++;
            _progressStep++;
          });
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('OTP confirmation failed: ${response.body}'),
              ),
            );
          }
          print(response.body);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
            ),
          );
        }
        print(e);
      }
    }
  }

  // Create Profile
  void _handleCreateProfile(LanguageProvider languageProvider) {
    bool isAnyJobCategorySelected = sabaiAppData.jobCategoryInEng
        .any((category) => category['selected'] == true);
    if (!isAnyJobCategorySelected) {
      print('Error: Please select at least one job category.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select at least one job category.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    } else {
      setState(() {
        var selectedJobCategories = sabaiAppData.jobCategoryInEng
            .where((category) => category['selected'] == true)
            .map((category) => category['name'])
            .toList();
        print('did you choose something? Y/N ${isAnyJobCategorySelected}');
        print('Selected Categories: ${selectedJobCategories}');
        _progressStep++;
        showDoubleCircleLoadingBox(context, languageProvider.lan);
        Future.delayed(
          const Duration(seconds: 3),
          () {
            if (!mounted) return;
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SuccessPage(),
              ),
            );
          },
        );
      });
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
            // fixed progress indicator
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: StepProgressIndicator(
                roundedEdges: const Radius.circular(10),
                padding: 0.0,
                totalSteps: totalSteps,
                currentStep: _progressStep,
                selectedColor: const Color(0xFFFF3997),
                unselectedColor: const Color.fromARGB(100, 76, 82, 88),
                size: 8.0,
              ),
            ),
            // Page View
            Expanded(
                child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                InitialRegistrationPage(
                    formKey: _formKey,
                    fullNameController: _fullNameController,
                    phoneNumberController: _phoneNumberController,
                    emailController: _emailController,
                    selectedGender: _selectedGender,
                    isGenderError: _isGenderError,
                    genderErrorMessage: _genderErrorMessage,
                    selectedDate: _selectedDate,
                    isBirthdayError: _isBirthdayError,
                    birthdayErrorMessage: _birthdayErrorMessage,
                    handleDateSelected: _handleDateSelected,
                    onGenderChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                        _isGenderError = false;
                      });
                    }),
                OtpCodeVerificationPage(
                    pinCodeController: _pinCodeController,
                    whenOnComplete: (value) {
                      _handleOTPVerificationPage(value, jobProvider);
                    }),
                CompleteUserInfoPage(
                    isProvinceError: _isProvinceError,
                    selectedProvince: _selectedProvince,
                    whenProvinceOnChanged: (value) {
                      setState(() {
                        _selectedProvince = value;
                        _isProvinceError = false;
                      });
                    },
                    provinceErrorMessage: _provinceErrorMessage!,
                    yearsController: _yearsController,
                    whenYearsOnChanged: (value) {
                      setState(() {
                        _isDurationError = false;
                      });
                    },
                    isDurationError: _isDurationError,
                    selectedDurationInEng: _selectedDurationEng!,
                    selectedDurationInMm: _selectedDurationMM!,
                    whenDurationOnChanged: (value) {
                      setState(() {
                        _selectedDurationEng = value;
                      });
                    },
                    durationErrorMessage: _durationErrorMessage!,
                    isLanguageLevelError: _isLanguageLevelError,
                    selectedLanguageLevel: _selectedLanguageLevel,
                    whenLanguageLevelOnChanged: (value) {
                      setState(() {
                        _selectedLanguageLevel = value;
                        _isLanguageLevelError = false;
                      });
                    },
                    languageLevelErrorMessage: _languageLevelErrorMessage!,
                    isSelectedOptionPpError: _isSelectedOptionPpError,
                    pPErrorMessage: _pPErrorMessage!,
                    selectedOptionPp: _selectedOptionPp,
                    whenPpRadioButtonOnChoosen: (value) {
                      setState(() {
                        _selectedOptionPp = value;
                        _isSelectedOptionPpError = false;
                      });
                    },
                    passportController: _passportController,
                    whenPassportOnChanged: (value) {
                      setState(() {
                        _isPassportFieldError = false;
                      });
                    },
                    isPassportFieldError: _isPassportFieldError!,
                    passportFieldErrorMessage: _passportFieldErrorMessage!,
                    isSelectedOptionWpError: _isSelectedOptionWpError,
                    selectedOptionWp: _selectedOptionWp,
                    wPErrorMessage: _wPErrorMessage!,
                    whenWpRadioButtonOnChoosen: (value) {
                      setState(() {
                        _selectedOptionWp = value;
                        _isSelectedOptionWpError = false;
                      });
                    }),
                SelectJobCategoryPage(
                  jobCategoryLength: sabaiAppData.jobCategoryInEng.length,
                  jobCategoryList: sabaiAppData.jobCategoryInEng,
                  whenOnChanged: (value, index) {
                    setState(() {
                      sabaiAppData.jobCategoryInEng[index!]['selected'] =
                          value!;
                    });
                  },
                ),
              ],
            ))
          ],
        ),
      ),
      //fixed continue button across the pages
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: ((_currentPage == _pageController.initialPage ||
              _currentPage == 2 ||
              _currentPage == 3))
          ? [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      if (_currentPage == _pageController.initialPage) {
                        _handleUserRegistration(phoneNumberProvider);
                      } else if (_currentPage == 2) {
                        _handleProfileSetUp();
                      } else {
                        _handleCreateProfile(languageProvider);
                      }
                    },
                    style: TextButton.styleFrom(
                      fixedSize: const Size(343, 42),
                      backgroundColor: const Color(0xffFF3997),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        languageProvider.lan == 'English'
                            ? Text(
                                _currentPage == 3
                                    ? 'Create Profile '
                                    : 'Continue',
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
              )
            ]
          : null,
    );
  }
}

//back button
// if (_currentPage > 0)
//   TextButton(
//     onPressed: () {
//       _pageController.previousPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//       setState(() {
//         _currentPage--;
//       });
//     },
//     child: const Text("Back"),
//   ),
