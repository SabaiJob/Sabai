import 'package:flutter/material.dart';
import 'package:sabai_app/constants.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    const labelTextStyle = TextStyle(
      fontFamily: 'Bricolage-M',
      fontSize: 12.5,
      color: Color(0xff363B3F),
    );

    const infoTextStyle = TextStyle(
      fontFamily: 'Bricolage-R',
      fontSize: 10,
      color: Color(0xff6C757D),
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Privacy Policy',
          style: appBarTitleStyleEng,
        ),
        iconTheme: const IconThemeData(
          color: primaryPinkColor,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'images/privacy.png',
                width: 113,
                height: 114,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Privacy Policy',
                style: labelStyleEng,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Effective Date : January 31,2024',
                style: TextStyle(
                  fontFamily: 'Bricolage-R',
                  fontSize: 12.5,
                  color: Color(0xff616971),
                ),
              ),
              const Card(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Introduction',
                        style: labelTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Sabai Jobs ("we," "us," or "our") is committed to protecting'
                        ' your privacy. This Privacy Policy explains how we'
                        ' collect, use, disclose, and safeguard your information'
                        ' when you use our job portal services ("Services").'
                        ' By accessing or using our Services, you agree to the terms of this Privacy Policy. '
                        'If you do not agree with the terms, please do not use our Services.',
                        style: infoTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '1. Information We Collect',
                        style: labelTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'We may collect personal information from you in a variety of ways when you use our Services, including:',
                        style: infoTextStyle,
                      ),
                      bulletInfo(
                        padding: 25,
                        infoTextStyle: infoTextStyle,
                        text:
                            'Personal Identification Information: This includes your name, email address, phone number, gender, date of birth, and other contact details.',
                      ),
                      bulletInfo(
                          padding: 25,
                          text:
                              'Professional Information: This includes your resume, job history, educational background, skills, and other information relevant to job applications.',
                          infoTextStyle: infoTextStyle),
                      bulletInfo(
                          padding: 25,
                          infoTextStyle: infoTextStyle,
                          text:
                              'Verification Information: This includes your passport number, work permit details, and photos of your passport and work permit.'),
                      bulletInfo(
                        padding: 25,
                        infoTextStyle: infoTextStyle,
                        text:
                            'Usage Data: This includes information about how you access and use our Services, including your IP address, browser type, device information, pages visited, and the date and time of your visit.',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '2. How We Use Your Information',
                        style: labelTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'We may use the information we collect from you for various purposes, including:',
                        style: infoTextStyle,
                      ),
                      bulletInfo(
                        padding: 0,
                        infoTextStyle: infoTextStyle,
                        text: 'To provide, operate, and maintain our Services.',
                      ),
                      bulletInfo(
                          padding: 0,
                          infoTextStyle: infoTextStyle,
                          text:
                              'To improve, personalize, and expand our Services'),
                      bulletInfo(
                        infoTextStyle: infoTextStyle,
                        text:
                            'To process your registration and manage your account.',
                        padding: 0,
                      ),
                      bulletInfo(
                          infoTextStyle: infoTextStyle,
                          text:
                              'To facilitate communication between job seekers and employers.',
                          padding: 0),
                      bulletInfo(
                          infoTextStyle: infoTextStyle,
                          text:
                              'To send you updates, notifications, and other information related to your use of the Services.',
                          padding: 0),
                      bulletInfo(
                          infoTextStyle: infoTextStyle,
                          text:
                              'To prevent fraudulent activity and ensure the security of our Services.',
                          padding: 0),
                      bulletInfo(
                          infoTextStyle: infoTextStyle,
                          text:
                              'To comply with legal obligations and protect our legal rights.',
                          padding: 0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class bulletInfo extends StatelessWidget {
  const bulletInfo({
    super.key,
    required this.infoTextStyle,
    required this.text,
    required this.padding,
  });

  final String text;
  final TextStyle infoTextStyle;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 10,
      horizontalTitleGap: 0,
      minLeadingWidth: 10,
      minVerticalPadding: 0,
      leading: Padding(
        padding: EdgeInsets.only(bottom: padding),
        child: const Icon(
          Icons.circle,
          size: 3,
        ),
      ),
      title: Text(
        text,
        style: infoTextStyle,
      ),
    );
  }
}
