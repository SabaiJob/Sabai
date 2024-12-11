import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class JobCategoryPage extends StatefulWidget {
  const JobCategoryPage({super.key});

  @override
  State<JobCategoryPage> createState() => _JobCategoryPageState();
}

class _JobCategoryPageState extends State<JobCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F1F2),
       appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Create Profile", style: GoogleFonts.bricolageGrotesque(textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 19.53,
        )),),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 30),
        child: Column(
          children: [
            // progress indicator bar
              Container(
                padding: EdgeInsets.only(top: 12, bottom: 12),
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
                padding: EdgeInsets.only(top: 12, bottom: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Select Your Job Preferences", style: GoogleFonts.bricolageGrotesque(textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.41,
                  )),),
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 12, bottom: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Choose the job categories that interest you.\n This helps us match you with the best\n opportunities", style: GoogleFonts.bricolageGrotesque(textStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.63,
                    color: Color(0xFF08210E),
                  )),),
                ),
              ),
          ],
        ),
      ),
    );
  }
}