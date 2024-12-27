import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:provider/provider.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                "Terms and Conditions",
                style: appBarTitleStyleEng,
              )
            : const Text(
                'ထုတ်ပြန်ချက်နှင့် ရေးရာမူဝါဒ',
                style: appBarTitleStyleMn,
              ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xFFFF3997),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 139,
                    height: 139,
                    decoration: const BoxDecoration(
                        color: Color(0xFFf9edc2),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        border: Border(
                          top: BorderSide(
                            color: Color(0xFFFFC107),
                            width: 2,
                          ),
                          bottom: BorderSide(
                            color: Color(0xFFFFC107),
                            width: 2,
                          ),
                          left: BorderSide(
                            color: Color(0xFFFFC107),
                            width: 2,
                          ),
                          right: BorderSide(
                            color: Color(0xFFFFC107),
                            width: 2,
                          ),
                        )),
                  ),
                  Positioned(
                      right: -10,
                      bottom: -10,
                      child: Image.asset(
                        'icons/contract.png',
                        width: 160,
                        height: 160,
                      )),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                languageProvider.lan == 'English'
                    ? 'Terms and Conditions'
                    : 'ထုတ်ပြန်ချက်နှင့် ရေးရာမူဝါဒ',
                style: const TextStyle(
                  fontFamily: 'Bricolage-M',
                  fontSize: 15.63,
                  color: Color(0xFF161719),
                ),
              ),
              Text(
                  languageProvider.lan == 'English'
                      ? 'Effective Date: January 31, 24'
                      : 'အကြုံးဝင်သောရက်ဆွဲ: January 31, 24',
                  style: languageProvider.lan == 'English'
                      ? const TextStyle(
                          color: Color(0xFF616971),
                          fontFamily: 'Bricolage-R',
                          fontSize: 12.5,
                        )
                      : const TextStyle(
                          color: Color(0xFF616971),
                          fontFamily: 'Walone-B',
                          fontSize: 11,
                        )),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                height: 473,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFFF0F1F2),
                      width: 1.5,
                    ),
                    bottom: BorderSide(
                      color: Color(0xFFF0F1F2),
                      width: 1.5,
                    ),
                    right: BorderSide(
                      color: Color(0xFFF0F1F2),
                      width: 1.5,
                    ),
                    left: BorderSide(
                      color: Color(0xFFF0F1F2),
                      width: 1.5,
                    )
                  )
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Introduction', 
                    style: TextStyle(
                      fontSize: 12.5,
                      fontFamily: 'Bricolage-M',
                      color: Color(0xFF363B3F),
                    ),),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('Welcome to Sabai Jobs! These Terms and Conditions ("Terms") govern your access to and use of our job portal services ("Services"). By accessing or using our Services, you agree to be bound by these Terms. If you do not agree to these Terms, please do not use our Services.',
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Bricolage-R',
                      color: Color(0xFF6C757D),
                    ),),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('1. Acceptance of terms', 
                    style: TextStyle(
                      fontSize: 12.5,
                      fontFamily: 'Bricolage-M',
                      color: Color(0xFF363B3F),
                    ),),
                     const SizedBox(
                      height: 5,
                    ),
                    Text('By registering for and/or using the Services, you accept and agree to be bound by these Terms. If you are using the Services on behalf of a company or other legal entity, you represent that you have the authority to bind such entity to these Terms.',
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Bricolage-R',
                      color: Color(0xFF6C757D),
                    ),),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('2. User Registration', 
                    style: TextStyle(
                      fontSize: 12.5,
                      fontFamily: 'Bricolage-M',
                      color: Color(0xFF363B3F),
                    ),),
                     const SizedBox(
                      height: 5,
                    ),
                    Text('To access certain features of the Services, you must register for an account. When registering, you agree to provide accurate, current, and complete information and to update such information as necessary to keep it accurate, current, and complete. You are responsible for maintaining the confidentiality of your account login information and for all activities that occur under your account.',
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Bricolage-R',
                      color: Color(0xFF6C757D),
                    ),),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('3. Use of Service', 
                    style: TextStyle(
                      fontSize: 12.5,
                      fontFamily: 'Bricolage-M',
                      color: Color(0xFF363B3F),
                    ),),
                  const SizedBox(
                      height: 5,
                    ),
                    Text('',
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Bricolage-R',
                      color: Color(0xFF6C757D),
                    ),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
