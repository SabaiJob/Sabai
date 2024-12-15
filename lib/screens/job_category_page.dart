import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/screens/success_page.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class JobCategoryPage extends StatefulWidget {
  const JobCategoryPage({super.key});

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
    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Create Profile",
          style: TextStyle(
            fontSize: 19.53,
            fontFamily: 'Bricolage-M',
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xffFF3997),
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
              child: const StepProgressIndicator(
                roundedEdges: Radius.circular(10),
                padding: 0.0,
                totalSteps: 3,
                currentStep: 1,
                selectedColor: Color(0xFFFF3997),
                unselectedColor: Color(0xFF4C5258),
                size: 8.0,
              ),
            ),

            Container(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Select Your Job Preferences",
                  style: GoogleFonts.bricolageGrotesque(
                      textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.41,
                  )),
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Choose the job categories that interest you.\n"
                  "This helps us match you with the best\nopportunities",
                  style: TextStyle(
                    fontFamily: 'Bricolage-R',
                    fontSize: 15.63,
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
                          child: Text(
                            categories[index],
                            style: const TextStyle(
                              fontFamily: 'Bricolage-R',
                              fontSize: 15.63,
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
                      return const Dialog(
                        backgroundColor: Colors.white,
                        child: SizedBox(
                          width: 120,
                          height: 200,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
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
                              SizedBox(
                                height: 35,
                              ),
                              Text(
                                'Creating your profile...',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontFamily: 'Bricolage-R',
                                  color: Color(0xff41464B),
                                ),
                              )
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
