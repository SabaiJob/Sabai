import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/screens/success_page.dart';
import 'package:sabai_app/services/job_provider.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../constants.dart';

class JobCategoryPage extends StatefulWidget {
  final int currentStep;
  const JobCategoryPage({super.key, required this.currentStep});

  @override
  State<JobCategoryPage> createState() => _JobCategoryPageState();
}

class _JobCategoryPageState extends State<JobCategoryPage> {
  final List<String> categories = [
    'Hotel 🏨',
    'Restaurant 🧑‍🍳',
    'Beauty 💋',
    'Teaching\t👩‍🏫',
  ];

  final List<String> categoriesMM = [
    'ဟိုတယ်များ 🏨',
    'စားသောက်ဆိုင်များ 🧑‍🍳',
    'အလှပရေးရာ 💋',
    'သင်ကြားရေး\t👩‍🏫',
  ];
  late List<bool> _check;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _check = List<bool>.filled(
      categories.length,
      false,
    );
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var jobProvider = Provider.of<JobProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      body: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 30),
        child: Column(
          children: [
            // progress indicator bar
            Container(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child:  StepProgressIndicator(
                roundedEdges: const Radius.circular(10),
                padding: 0.0,
                totalSteps: totalSteps,
                currentStep: widget.currentStep,
                selectedColor: const Color(0xFFFF3997),
                unselectedColor: const Color.fromARGB(100, 76, 82, 88),
                size: 8.0,
              ),
            ),

            Container(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: Align(
                alignment: Alignment.topLeft,
                child: languageProvider.lan == 'English'
                    ? const Text(
                        "Select Your Job Preferences",
                        style: const TextStyle(
                          fontFamily: 'Bricolage-B',
                          fontSize: 24.41,
                        ),
                      )
                    : const Text(
                        'အလုပ်အကိုင်အမျိုးအစားများ',
                        style: const TextStyle(
                          fontFamily: 'Walone-B',
                          fontSize: 24.41,
                        ),
                      ),
              ),
            ),

            Container(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: Align(
                alignment: Alignment.topLeft,
                child: languageProvider.lan == 'English'
                    ? const Text(
                        "Choose the job categories that interest you.\n"
                        "This helps us match you with the best\nopportunities",
                        style: TextStyle(
                          fontFamily: 'Bricolage-R',
                          fontSize: 15.63,
                          color: Color(0xFF08210E),
                        ),
                      )
                    : const Text(
                        'သင်စိတ်ဝင်စားရာအလုပ်အကိုင်အမျိုးအစားများကို ရွေးချယ်ပါ။'
                        '\nသင့်နဲ့ကိုက်ညီမယ့်အကောင်းဆုံး အလုပ်အခွင့်အလမ်းများကို'
                        '\nကျွန်တော်တို့ ပြပေးနိုင်ပါသည်။',
                        style: TextStyle(
                          fontFamily: 'Walone-R',
                          fontSize: 14,
                          color: Color(0xFF08210E),
                        ),
                      ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: languageProvider.lan == 'English'
                              ? Text(
                                  categories[index],
                                  style: const TextStyle(
                                    fontFamily: 'Bricolage-R',
                                    fontSize: 15.63,
                                  ),
                                )
                              : Text(
                                  categoriesMM[index],
                                  style: const TextStyle(
                                    fontFamily: 'Walone-R',
                                    fontSize: 14,
                                  ),
                                ),
                        ),
                        Checkbox(
                          activeColor: const Color(0xffFF3997),
                          value: _check[index],
                          onChanged: (bool? value) {
                            setState(
                              () {
                                _check[index] = value!;
                                jobProvider.addBestMatched(categories[index]);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              width: 400,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        child: SizedBox(
                          width: 120,
                          height: 200,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                height: 110,
                                width: 110,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      height: 70, // Outer circle size
                                      width: 70,
                                      child: CircularProgressIndicator(
                                        color: Color(0xffFF3997),
                                        strokeWidth:
                                            4.0, // Outer circle thickness
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30, // Inner circle size
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        color: Color(0xffFF3997),
                                        strokeWidth:
                                            4.0, // Inner circle thickness
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              languageProvider.lan == 'English'
                                  ? const Text(
                                      'Creating your profile...',
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        fontFamily: 'Bricolage-R',
                                        color: Color(0xff41464B),
                                      ),
                                    )
                                  : const Text(
                                      'သင့်ပရိုဖိုင်ကို ဖန်တီးနေသည် ...',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontFamily: 'Walone-B',
                                        color: Color(0xff41464B),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      );
                    },
                  );

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
                },
                style: TextButton.styleFrom(
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
                        ? Text(
                            'Continue',
                            style: GoogleFonts.bricolageGrotesque(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.63,
                              ),
                            ),
                          )
                        : Text(
                            'ဆက်လက်ရန်',
                            style: GoogleFonts.bricolageGrotesque(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
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
            )
          ],
        ),
      ),
    );
  }
}
