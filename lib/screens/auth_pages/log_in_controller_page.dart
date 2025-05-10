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

  final TextEditingController _passwordController = TextEditingController();

  bool _visiblePassword = true;

  //user login
  Future<void> userLogin(JobProvider jobProvider) async {
    bool isFormValid = _formKey.currentState!.validate();
    if (isFormValid) {
      const String url =
          'https://api.sabaijob.com/api/auth/phone-password/login/';

      final Map<String, dynamic> requestBody = {
        'phone': _phoneNumberController.text,
        'password': _passwordController.text,
      };

      try {
        final response = await http.post(
          Uri.parse(url),
          body: json.encode(requestBody),
          headers: {'Content-Type': 'application/json'},
        );
        if (response.statusCode >= 200 && response.statusCode < 300) {
          jobProvider.setGuest(false);
          final responseData = json.decode(response.body);
          final token = responseData['token'];
          print(token);
          await TokenService.saveToken(token);
          setState(() {
            _currentPage++;
          });
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
                backgroundColor: Colors.white,
                behavior: SnackBarBehavior.floating,
                content: Text(
                  'Login failed: ${jsonDecode(response.body)['error']}',
                  style: const TextStyle(
                      fontFamily: 'Bricolage-M',
                      fontSize: 12.5,
                      color: Color(0xFF616971)),
                ),
              ),
            );
          }
        }
      } catch (e) {
        print('Error: $e');
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
                  passwordController: _passwordController,
                  visiblePassword: _visiblePassword,
                  seePassword: () {
                    setState(() {
                      _visiblePassword = !_visiblePassword;
                    });
                  },
                ),
              ],
            ))
          ],
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                await userLogin(jobProvider);
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
      ],
    );
  }
}
