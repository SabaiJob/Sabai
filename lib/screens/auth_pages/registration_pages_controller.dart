import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sabai_app/components/custom_progress_bar.dart';
import 'package:sabai_app/components/reusable_double_circle_loading_component.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/data/sabai_app_data.dart';
import 'package:sabai_app/screens/auth_pages/api_service.dart';
import 'package:sabai_app/screens/auth_pages/auth_controller.dart';
import 'package:sabai_app/screens/auth_pages/otp_code_verification_page.dart';
import 'package:sabai_app/screens/auth_pages/complete_user_registration_page.dart';
import 'package:sabai_app/screens/auth_pages/initial_registration_page.dart';
import 'package:sabai_app/screens/auth_pages/select_job_category_page.dart';
import 'package:sabai_app/screens/auth_pages/token_service.dart';
import 'package:sabai_app/screens/success_page.dart';
import 'package:sabai_app/services/job_provider.dart';
import 'package:sabai_app/services/phone_number_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final TextEditingController _pinCodeController = TextEditingController();

  int _currentPage = 0;

  // Gender
  String? _selectedGender;
  bool _isGenderError = false;
  String _genderErrorMessage = '';

  //Age
  String? selectedAge;
  bool _isAgeError = false;
  String _ageErrorMessage = '';

  // Thai Language Level
  String? _selectedLanguageLevel;
  bool _isLanguageLevelError = false;
  String? _languageLevelErrorMessage = '';

  //Status
  String? selectedStatus;
  bool _isStatusError = false;
  String _statusErrorMessage = '';

  //has_passport
  bool? has_passport;

  //has_work_permit
  bool? has_work_permit;

  //has_id_certificate
  bool? has_id_certificate;

  void updateStatus() {
    // Ensure they are not null before updating (optional handling)
    has_passport ??= false;
    has_work_permit ??= false;
    has_id_certificate ??= false;

    // Reset all
    has_passport = false;
    has_work_permit = false;
    has_id_certificate = false;
    switch (selectedStatus) {
      case 'Passport':
        has_passport = true;
        break;
      case 'Work Permit (Pink Card)':
        has_work_permit = true;
        break;
      case 'Certificate of Identification':
        has_id_certificate = true;
        break;
      case 'Still Applying':
        break;
      default:
        return;
    }
  }

  List<Map<String, dynamic>> _jobCategories = [];

  final AuthController _authController = AuthController();
  void initialRegister() async {
    try {
      await _authController.initialSignIn(
          context: context,
          fullName: _fullNameController.text,
          phoneNum: _phoneNumberController.text,
          email: _emailController.text,
          endPoint: '/auth/register/',
          nextScreen: () {
            requestOTP();
            setState(() {
              _currentPage++;
              _progressStep++;
            });
          });
    } catch (e) {
      print(e);
    }
  }

  //request OTP
  Future<void> requestOTP() async {
    // const String url =
    //     'https://sabai-job-backend-k9wda.ondigitalocean.app/api/auth/otp/request/';
    const String url = 'https://api.sabaijob.com/api/auth/otp/request/';
    final Map<String, dynamic> requestBody = {
      //"phone": _phoneNumberController.text,
      "email": _emailController.text,
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

  int _progressStep = 0;

  // handle initialRegister method
  void _handleUserRegistration(PhoneNumberProvider phoneNumberProvider) {
    if (_currentPage == _pageController.initialPage) {
      phoneNumberProvider.setEmail(_emailController.text.toString().trim());
      initialRegister();
    }
  }

  // Profile Set Up (additional info)
  void _handleProfileSetUp() async {
    if (_currentPage == 2) {
      _isLanguageLevelError = _selectedLanguageLevel == null;
      _isGenderError = _selectedGender == null;
      _isAgeError = selectedAge == null;
      _isStatusError = selectedStatus == null;
      setState(() {
        _languageLevelErrorMessage =
            _isLanguageLevelError ? ' Language Level is required ' : '';
        _genderErrorMessage = _isGenderError ? ' Gender is required ' : '';
        _ageErrorMessage = _isAgeError ? ' Age is required ' : '';
        _statusErrorMessage = _isStatusError ? ' Status is required ' : '';
      });
      bool noErrors = !_isLanguageLevelError &
          !_isGenderError &
          !_isAgeError &
          !_isStatusError;
      if (noErrors) {
        updateStatus();
        print('Your Gender: $_selectedGender');
        print('Your Age: $selectedAge');
        print('Your Thai Language Proficiency : $_selectedLanguageLevel');
        print(
            'Your status: Passport: $has_passport, WP: $has_work_permit, CI: $has_id_certificate');
        print('Your email (if any): ${_emailController.text}');
        print(
            'Congratulations! You have completed all the required fields for the registration');
        //post user's info api
        try {
          final token = await TokenService.getToken();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final fcmToken = prefs.getString('fcm_token');
          // Create form data with proper boundary
          var formData = FormData.fromMap({
            "age": selectedAge.toString(),
            "gender": _selectedGender,
            "email": _emailController.text,
            "thai_proficiency": _selectedLanguageLevel,
            "has_passport": has_passport! ? 1 : 0,
            "has_work_permit": has_work_permit! ? 1 : 0,
            "has_id_certificate": has_id_certificate! ? 1 : 0,
            "fcm_token": fcmToken
          });

          Dio dio = Dio();
          final response = await dio.post(
            // "https://sabai-job-backend-k9wda.ondigitalocean.app/api/auth/userinfo/",
            'https://api.sabaijob.com/api/auth/userinfo/',
            options: Options(
              headers: {
                "Content-Type": "multipart/form-data",
                "Authorization": "Bearer $token",
              },
            ),
            data: formData,
          );

          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            print('fcmToken $fcmToken');
            //fetch the job categories
            getJobCategory();
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
            print(response.statusCode);
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Adding info fail: ${response.statusMessage}'),
                ),
              );
            }
            print(response.statusMessage);
          }
        } catch (e) {
          if (e is DioException) {
            print('Error status code: ${e.response?.statusCode}');
            print('Error response data: ${e.response?.data}');
          }
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('error: $e'),
              ),
            );
          }
        }
      } else {
        print('You need to complete all fields');
      }
    }
  }

  // OTP Code Verification
  void _handleOTPVerificationPage(
      String enteredPinCode, JobProvider jobProvider) async {
    if (_currentPage == 1) {
      // const String url =
      //     'https://sabai-job-backend-k9wda.ondigitalocean.app/api/auth/otp/confirm/register/';
      const String url =
          'https://api.sabaijob.com/api/auth/otp/confirm/register/';
      final Map<String, dynamic> requestBody = {
        "phone": _phoneNumberController.text,
        "otp": enteredPinCode,
        "full_name": _fullNameController.text,
        "email": _emailController.text,
      };

      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(requestBody),
        );

        if (response.statusCode >= 200 && response.statusCode < 300) {
          jobProvider.setGuest(false);
          final responseData = json.decode(response.body);
          final token = responseData['token'];
          print(token);
          await TokenService.saveToken(token);
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          getJobCategory();
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

  Future<void> completeRegistration(
      List selectedJobCategories, LanguageProvider languageProvider) async {
    try {
      final response = await ApiService.post('/auth/user/job-preferences/',
          {'preferences': selectedJobCategories});

      if (response.statusCode >= 200 && response.statusCode < 300) {
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
      } else {
        print('Error : ${response.body}');
      }
    } catch (e) {
      print(e);
    }
  }

  // Create Profile
  void _handleCreateProfile(LanguageProvider languageProvider) {
    bool isAnyJobCategorySelected =
        _jobCategories.any((category) => category['selected'] == true);
    if (!isAnyJobCategorySelected) {
      // print('Error: Please select at least one job category.');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text(
      //       'Please select at least one job category.',
      //       style: TextStyle(color: Colors.white),
      //     ),
      //     backgroundColor: Colors.red,
      //     duration: Duration(seconds: 2),
      //   ),
      // );
      // return;
      setState(() {
        var selectedJobCategories = _jobCategories
            .where((category) => category['selected'] == true)
            .map((category) => category['id'])
            .toList();
        print('did you choose something? Y/N ${isAnyJobCategorySelected}');
        print('Selected Categories: ${selectedJobCategories}');

        completeRegistration(selectedJobCategories, languageProvider);
      });
    } else {
      setState(() {
        var selectedJobCategories = _jobCategories
            .where((category) => category['selected'] == true)
            .map((category) => category['id'])
            .toList();
        print('did you choose something? Y/N ${isAnyJobCategorySelected}');
        print('Selected Categories: ${selectedJobCategories}');

        completeRegistration(selectedJobCategories, languageProvider);
      });
    }
  }

  // get job categories
  Future<void> getJobCategory() async {
    try {
      final response = await ApiService.get('/jobs/categories/');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = json.decode(response.body);
        final List<Map<String, dynamic>> jobCategories = data.map((job) {
          String name = job['name'];
          String imageLink = job['image'];
          int id = job['id'];
          return {
            'name': name ?? 'Unknown',
            'image': imageLink ?? '',
            'selected': false,
            'id': id,
          };
        }).toList();
        setState(() {
          _jobCategories = jobCategories;
        });
      } else {
        print('error: ${response.body} , ststusCode: ${response.statusCode} ');
      }
    } catch (e) {
      print(e);
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
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 24),
            //   child: StepProgressIndicator(
            //     roundedEdges: const Radius.circular(10),
            //     padding: 0.0,
            //     totalSteps: totalSteps,
            //     currentStep: _progressStep,
            //     selectedColor: const Color(0xFFFF3997),
            //     unselectedColor: const Color.fromARGB(100, 76, 82, 88),
            //     size: 8.0,
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: CustomProgressBar(
                  totalSteps: totalSteps, currentStep: _progressStep),
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
                ),
                OtpCodeVerificationPage(
                    pinCodeController: _pinCodeController,
                    //requestOtp: requestOTP(),
                    whenOnComplete: (value) {
                      _handleOTPVerificationPage(value, jobProvider);
                    }),
                CompleteUserInfoPage(
                  isLanguageLevelError: _isLanguageLevelError,
                  selectedLanguageLevel: _selectedLanguageLevel,
                  whenLanguageLevelOnChanged: (value) {
                    setState(() {
                      _selectedLanguageLevel = value;
                      _isLanguageLevelError = false;
                    });
                  },
                  languageLevelErrorMessage: _languageLevelErrorMessage,
                  selectedGender: _selectedGender,
                  genderErrorMessage: _genderErrorMessage,
                  isGenderError: _isGenderError,
                  onGenderChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                      _isGenderError = false;
                    });
                  },
                  selectedAge: selectedAge ?? '',
                  whenAgeOnChange: (value) {
                    setState(() {
                      selectedAge = value!;
                    });
                  },
                  selectedStatus: selectedStatus ?? '',
                  whenStatusOnChange: (value) {
                    setState(() {
                      selectedStatus = value!;
                      updateStatus();
                    });
                  },
                  emailController: _emailController,
                  isAgeError: _isAgeError,
                  ageErrorMessage: _ageErrorMessage,
                  isStatusError: _isStatusError,
                  statusErrorMessage: _statusErrorMessage,
                ),
                SelectJobCategoryPage(
                    jobCategoryLength: _jobCategories.length,
                    jobCategoryList: _jobCategories,
                    whenOnChanged: (value, index) {
                      setState(() {
                        _jobCategories[index!]['selected'] = value!;
                      });
                    })
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
                      // original method
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
