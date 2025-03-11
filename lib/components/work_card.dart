import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/popup_widget.dart';
import 'package:sabai_app/components/walkthrough_button.dart';
import 'package:sabai_app/constants.dart';
import '../screens/job_details_page.dart';
import '../screens/auth_pages/log_in_controller_page.dart';
import '../screens/auth_pages/registration_pages_controller.dart';
import '../services/job_provider.dart';
import '../services/language_provider.dart';
import 'package:popover/popover.dart';

class WorkCard extends StatelessWidget {
  final String jobTitle;
  final String companyName;
  final int minSalary;
  final int maxSalary;
  final String location;
  final String currency;
  final bool isPartner;
  final int jobId;
  final String closingAt;
  final String safetyLevel;
  final int viewCount;
  const WorkCard(
      {required this.jobTitle,
      required this.isPartner,
      required this.companyName,
      required this.location,
      required this.maxSalary,
      required this.minSalary,
      required this.currency,
      required this.jobId,
      required this.closingAt,
      required this.safetyLevel,
      required this.viewCount,
      super.key});

  @override
  Widget build(BuildContext context) {
    var language = Provider.of<LanguageProvider>(context);
    var jobProvider = Provider.of<JobProvider>(context);
    bool? isSaved = jobProvider.isSaved(jobId);
    bool? isGuest = jobProvider.isGuest;
    final closed = DateTime.parse(closingAt).toLocal();
    final now = DateTime.now();
    final timeDifference = closed.difference(now);
    final isClosedDay = timeDifference.inDays;
    final isClosedHour = timeDifference.inHours - 7;
    return GestureDetector(
      onTap: () {
        if (jobProvider.isGuest == true) {
          showBottomSheet(
            context: context,
            builder: (context) {
              return guestBotoom(language);
            },
          );
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => JobDetailsPage(
                        jobId: jobId,
                      )));
          print(timeDifference);
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isPartner
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 25,
                        decoration: const BoxDecoration(
                          color: Color(0xffFFEBF6),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'images/status.png',
                              width: 12,
                              height: 12,
                            ),
                            const Text(
                              'Sabai Job Partner',
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Bricolage-R',
                                color: Color(0xff6C757D),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10),
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: const Color(0xffF0F1F2),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              isGuest == true
                                  ? showBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          guestBotoom(language),
                                    )
                                  : jobProvider.saveJob(jobId, context);
                            },
                            icon: isSaved == false
                                ? const Icon(
                                    CupertinoIcons.heart,
                                    color: Color(0xffFF3997),
                                  )
                                : const Icon(
                                    CupertinoIcons.heart_fill,
                                    color: Color(0xffFF3997),
                                  ),
                            iconSize: 18,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      )
                    ],
                  )
                : const SizedBox(
                    height: 20,
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            jobTitle,
                            style: const TextStyle(
                              fontSize: 15.63,
                              fontFamily: 'Bricolage-M',
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'By ',
                              style: const TextStyle(
                                fontSize: 10,
                                fontFamily: 'Bricolage-R',
                                color: Color(0xff6C757D),
                              ),
                              children: [
                                TextSpan(
                                  text: companyName,
                                  style: const TextStyle(
                                    fontFamily: 'Bricolage-B',
                                    fontSize: 10,
                                    color: Color(0xff6C757D),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      isPartner == false
                          ? Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: const Color(0xffF0F1F2),
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    jobProvider.isGuest == true
                                        ? showBottomSheet(
                                            context: context,
                                            builder: (context) =>
                                                guestBotoom(language),
                                          )
                                        : jobProvider.saveJob(
                                            jobId,
                                            context,
                                          );
                                  },
                                  icon: isSaved == false
                                      ? const Icon(
                                          CupertinoIcons.heart,
                                          color: Color(0xffFF3997),
                                        )
                                      : const Icon(
                                          CupertinoIcons.heart_fill,
                                          color: Color(0xffFF3997),
                                        ),
                                  iconSize: 18,
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  language.lan == 'English'
                      ? Text(
                          timeDifference.isNegative
                              ? 'Closed'
                              : isClosedDay > 0
                                  ? 'Closing in $isClosedDay days'
                                  : 'Closing in $isClosedHour hours',
                          style: const TextStyle(
                            fontFamily: 'Bricolage-R',
                            fontSize: 10,
                            color: Color(0xffDC3545),
                          ),
                        )
                      : const Text(
                          '၃ ရက် အတွင်းပိတ်မည်',
                          style: TextStyle(
                            fontFamily: 'Walone-M',
                            fontSize: 10,
                            color: Color(0xffDC3545),
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      language.lan == 'English'
                          ? const Text(
                              'Salary',
                              style: TextStyle(
                                fontFamily: 'Bricolage-R',
                                fontSize: 10,
                                color: Color(0xff6C757D),
                              ),
                            )
                          : const Text(
                              'လစာ',
                              style: TextStyle(
                                fontFamily: 'Walone-R',
                                fontSize: 10,
                                color: Color(0xff6C757D),
                              ),
                            ),
                      Padding(
                        padding: language.lan == 'English'
                            ? const EdgeInsets.only(right: 35)
                            : const EdgeInsets.only(right: 28),
                        child: Row(
                          children: [
                            language.lan == 'English'
                                ? const Text(
                                    'Location',
                                    style: TextStyle(
                                      fontFamily: 'Bricolage-R',
                                      fontSize: 10,
                                      color: Color(0xff6C757D),
                                    ),
                                  )
                                : const Text(
                                    'တည်နေရာ',
                                    style: TextStyle(
                                      fontFamily: 'Walone-R',
                                      fontSize: 10,
                                      color: Color(0xff6C757D),
                                    ),
                                  ),
                            SizedBox(
                              width: language.lan == 'English' ? 63 : 60,
                            ),
                            language.lan == 'English'
                                ? const Text(
                                    'Safety',
                                    style: TextStyle(
                                      fontFamily: 'Bricolage-R',
                                      fontSize: 10,
                                      color: Color(0xff6C757D),
                                    ),
                                  )
                                : const Text(
                                    'စိတ်ချရမှု',
                                    style: TextStyle(
                                      fontFamily: 'Walone-R',
                                      fontSize: 10,
                                      color: Color(0xff6C757D),
                                    ),
                                  ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      language.lan == 'English'
                          ? Text(
                              '$minSalary ~ $maxSalary $currency',
                              style: const TextStyle(
                                fontFamily: 'Bricolage-M',
                                fontSize: 10,
                                color: Color(0xff4C5258),
                              ),
                            )
                          : const Text(
                              '၁၈၀၀၀ ~ ၂၈၀၀၀ ဘတ်',
                              style: TextStyle(
                                fontFamily: 'Walone-B',
                                fontSize: 10,
                                color: Color(0xff4C5258),
                              ),
                            ),
                      Row(
                        children: [
                          Text(
                            location,
                            style: const TextStyle(
                              fontFamily: 'Bricolage-M',
                              fontSize: 10,
                              color: Color(0xff4C5258),
                            ),
                          ),
                          const SizedBox(
                            width: 55,
                          ),
                          JobLevelCard(
                            language: language,
                            level: safetyLevel,
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    child: Divider(
                      height: 10,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Icon(
                                Icons.remove_red_eye_outlined,
                                size: 13,
                                color: Color(0xffFF3997),
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            language.lan == 'English'
                                ? RichText(
                                    text: TextSpan(
                                      text: 'viewed by  ',
                                      style: const TextStyle(
                                        fontSize: 12.5,
                                        fontFamily: 'Bricolage-R',
                                        color: Color(0xff6C757D),
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '$viewCount',
                                          style: const TextStyle(
                                            fontSize: 12.5,
                                            fontFamily: 'Bricolage-B',
                                            color: Color(0xff6C757D),
                                          ),
                                        ),
                                        const TextSpan(text: '  job hunters'),
                                      ],
                                    ),
                                  )
                                : const Text(
                                    'အခြားအလုပ်ရှာဖွေသူ ၂၀ ယောက်ကြည့်ရှုပြီး',
                                    style: TextStyle(
                                      fontFamily: 'Walone-B',
                                      fontSize: 10,
                                      color: Color(0xff899197),
                                    ),
                                  ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              child: Image.asset(
                                'images/give_heart.png',
                                width: 13,
                                height: 13,
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            language.lan == 'English'
                                ? const Text(
                                    '0',
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontFamily: 'Bricolage-B',
                                      color: Color(0xff6C757D),
                                    ),
                                  )
                                : const Text(
                                    '၅၆',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Walone-B',
                                      color: Color(0xff6C757D),
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BottomSheet guestBotoom(LanguageProvider language) {
    return BottomSheet(
      backgroundColor: Colors.white,
      onClosing: () {},
      builder: (context) {
        return SizedBox(
          height: 500,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          'images/guest.png',
                          width: 196,
                          height: 196,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'You\'re in Guest Mode',
                          style: TextStyle(
                              fontSize: 19.53, fontFamily: 'Bricolage-SMB,'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          textAlign: TextAlign.center,
                          'To explore jobs tailored to your skills and\npreferences, please sign up or log in.',
                          style: TextStyle(
                            fontFamily: 'Bricolage-R',
                            fontSize: 12.5,
                            color: Color(0xff6C757D),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Button(
                          languageProvider: language,
                          textEng: 'Get Started',
                          textMm: 'အကောင့်အသစ်ပြုလုပ်ရန်',
                          color: primaryPinkColor,
                          widget: const RegistrationPagesController(),
                          tColor: Colors.white,
                          bColor: primaryPinkColor,
                          isGuest: true,
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Button(
                          languageProvider: language,
                          textEng: 'Log In',
                          textMm: '၀င်ရောက်ရန်',
                          color: Colors.white,
                          widget: const LogInControllerPage(),
                          tColor: primaryPinkColor,
                          bColor: primaryPinkColor,
                          isGuest: true,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      CupertinoIcons.xmark_circle,
                      size: 28,
                      color: primaryPinkColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class JobLevelCard extends StatelessWidget {
  const JobLevelCard({super.key, required this.language, required this.level});

  final LanguageProvider language;
  final String level;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPopover(
        context: context,
        bodyBuilder: (context) => const PopupWidget(),
        direction: PopoverDirection.top,
        width: 130,
        backgroundColor: const Color(0xfff0f1f2),
        arrowWidth: 10,
        arrowHeight: 8,
        radius: 4,
      ),
      child: Card(
        color: const Color(0xffEAF6EC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                CupertinoIcons.info_circle,
                size: 11,
                color: Color(0xff28A745),
              ),
              const SizedBox(
                width: 3,
              ),
              language.lan == 'English'
                  ? Text(
                      'Level-$level',
                      style: const TextStyle(
                        fontFamily: 'Bricolage-R',
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    )
                  : const Text(
                      'အဆင့် - ၃',
                      style: TextStyle(
                        fontFamily: 'Walone-B',
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
