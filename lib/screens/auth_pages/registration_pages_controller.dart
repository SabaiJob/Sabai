import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sabai_app/components/custom_progress_bar.dart';
import 'package:sabai_app/components/reusable_double_circle_loading_component.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/data/sabai_app_data.dart';
import 'package:sabai_app/screens/auth_pages/api_service.dart';
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
  //final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _visiblePassword = true;

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

  int _progressStep = 0;

  List<Map<String, dynamic>> _jobCategories = [];

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

  // Initial Register with Phone and Password
  void initialRegister(JobProvider jobProvider) async {
    bool isFormValid = _formKey.currentState!.validate();
    if (isFormValid) {
      try {
        final response = await ApiService.unauthenticatedPost(
            '/auth/phone-password/register/', {
          "phone": _phoneNumberController.text,
          "password": _passwordController.text,
          "full_name": _fullNameController.text,
        });
        if (response.statusCode >= 200 && response.statusCode < 300) {
          jobProvider.setGuest(false);
          final responseData = jsonDecode(response.body);
          final token = responseData['token'] ?? '';
          await TokenService.saveToken(token);
          await getJobCategory();
          await sendFCMToken();
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          setState(() {
            _currentPage++;
            _progressStep++;
          });
        } else if (response.statusCode == 409) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(jsonDecode(response.body)['error'],
                style: const TextStyle(
                    fontFamily: 'Bricolage-M',
                    fontSize: 12.5,
                    color: Color(0xFF616971))),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.white,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(jsonDecode(response.body)['error'],
                style: const TextStyle(
                    fontFamily: 'Bricolage-M',
                    fontSize: 12.5,
                    color: Color(0xFF616971))),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.white,
          ));
        }
      } catch (e) {
        print('Error $e');
      }
    }
  }

  // Create Profile
  void _handleCreateProfile(LanguageProvider languageProvider) {
    bool isAnyJobCategorySelected =
        _jobCategories.any((category) => category['selected'] == true);
    if (!isAnyJobCategorySelected) {
      print('Error: Please select at least one job category.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one job category.',
              style: TextStyle(
                  fontFamily: 'Bricolage-M',
                  fontSize: 12.5,
                  color: Color(0xFF616971))),
          backgroundColor: Colors.white,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
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

  Future<void> sendFCMToken() async {
    try {
      final token = await TokenService.getToken();
      // Ensure token is not null or empty
      if (token == null || token.isEmpty) {
        print('Error: No valid token available.');
        return;
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final fcmToken = prefs.getString('fcm_token');
      // Ensure fcm_token is valid
      if (fcmToken == null || fcmToken.isEmpty) {
        print('Error: FCM token is missing or invalid.');
        return;
      }
      var formData = FormData.fromMap({"fcm_token": fcmToken});
      Dio dio = Dio();
      final response = await dio.post(
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
        print('FCM token sent successfully: $fcmToken');
      } else {
        print('Failed to send FCM token: ${response.statusCode}');
        print('Response: ${response.data}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _pageController.dispose();
    super.dispose();
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
                  seePassword: () {
                    setState(() {
                      _visiblePassword = !_visiblePassword;
                    });
                  },
                  visiblePassword: _visiblePassword,
                  formKey: _formKey,
                  fullNameController: _fullNameController,
                  phoneNumberController: _phoneNumberController,
                  // emailController: _emailController,
                  passwordController: _passwordController,
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
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                // original method
                if (_currentPage == _pageController.initialPage) {
                  initialRegister(jobProvider);
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
                          _currentPage == 3 ? 'Create Profile ' : 'Continue',
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
      ],
    );
  }
}
