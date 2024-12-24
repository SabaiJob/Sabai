import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/screens/homepage_menupages/all.dart';
import 'package:sabai_app/services/job_provider.dart';
import 'package:sabai_app/services/language_provider.dart';

class SaveJobs extends StatelessWidget {
  const SaveJobs({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var jobProvider = Provider.of<JobProvider>(context);
    List<String> savedJobs = jobProvider.savedJobs;
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        title: languageProvider.lan == 'English'
            ? const Text(
                "Jobs",
                style: TextStyle(
                  fontFamily: 'Bricolage-M',
                  fontSize: 19.53,
                ),
              )
            : const Text(
                "အလုပ်များ",
                style: TextStyle(
                  fontFamily: 'Walone-B',
                  fontSize: 19.53,
                ),
              ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(1.0), // Height of the bottom border
          child: Container(
            color: Colors.grey.shade300, // Border color
            height: 1.0, // Border thickness
          ),
        ),
        backgroundColor: const Color(0xffF0F1F2),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
        color: const Color(0xffF7F7F7),
        child: savedJobs.isNotEmpty
            ? ListView.builder(
                itemCount: savedJobs.length, // Total number of items
                itemBuilder: (context, index) {
                  return WorkCard(
                    savedJobs[index],
                  );
                },
              )
            : Center(
                child: Text('There is no saved jobs'),
              ),
      ),
    );
  }
}
