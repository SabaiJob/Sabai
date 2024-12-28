import 'package:flutter/material.dart';

import '../constants.dart';

class About extends StatelessWidget {
  const About({super.key});

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
          'About Sabai Job',
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
                'images/about.png',
                width: 89,
                height: 132,
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
                        'Out Mission',
                        style: labelTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'At Sabai Jobs, our mission is to connect blue-collar job seekers in Thailand with reliable and rewarding employment opportunities. We strive to bridge the gap between employers and job seekers by providing a user-friendly platform that makes job searching and hiring efficient, transparent, and accessible for everyone.',
                        style: infoTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Who we are',
                        style: labelTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Sabai Jobs is a dedicated job portal focused on the blue-collar job market in Thailand. We understand the unique challenges faced by both job seekers and employers in this sector, and we are committed to addressing these challenges through innovative solutions and a customer-centric approach.',
                        style: infoTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'What we offer',
                        style: labelTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'For Job Seekers',
                        style: infoTextStyle,
                      ),
                      BulletInfo(
                        padding: 40,
                        infoTextStyle: infoTextStyle,
                        text:
                            'Easy Registration: Our simple and straightforward registration process helps you get started quickly. Provide your basic information, upload necessary documents, and set up your profile in just a few steps.',
                      ),
                      BulletInfo(
                          padding: 25,
                          text:
                              'Job Listings: Access a wide range of job opportunities across various industries, including construction, manufacturing, logistics, hospitality, and more.',
                          infoTextStyle: infoTextStyle),
                      BulletInfo(
                          padding: 25,
                          infoTextStyle: infoTextStyle,
                          text:
                              'Profile Setup: Create a detailed profile highlighting your skills, experience, and preferences to attract potential employers.'),
                      BulletInfo(
                        padding: 25,
                        infoTextStyle: infoTextStyle,
                        text:
                            'Application Tracking: Keep track of your job applications and get updates on their status directly through our platform.',
                      ),
                      BulletInfo(
                          infoTextStyle: infoTextStyle,
                          text:
                              'Support and Guidance: Receive support and guidance through every step of your job search, from creating your profile to preparing for interviews.',
                          padding: 25),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'For Employers',
                        style: infoTextStyle,
                      ),
                      BulletInfo(
                          infoTextStyle: infoTextStyle,
                          text:
                              'Efficient Hiring: Post job listings and reach a large pool of qualified candidates quickly and easily.',
                          padding: 10),
                      BulletInfo(
                          infoTextStyle: infoTextStyle,
                          text:
                              'Candidate Profiles: Access detailed profiles of job seekers to find the best match for your job requirements.',
                          padding: 15),
                      BulletInfo(
                          infoTextStyle: infoTextStyle,
                          text:
                              'Application Management: Manage and track applications seamlessly through our intuitive dashboard.',
                          padding: 15),
                      BulletInfo(
                          infoTextStyle: infoTextStyle,
                          text:
                              'Verification Services: Utilize our verification services to ensure the authenticity of candidates\' documents and credentials.',
                          padding: 25),
                      BulletInfo(
                          infoTextStyle: infoTextStyle,
                          text:
                              'Customer Support: Get assistance from our dedicated customer support team to address any queries or issues you may encounter.',
                          padding: 25),
                      SizedBox(
                        height: 10,
                      ),
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

class BulletInfo extends StatelessWidget {
  const BulletInfo({
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
