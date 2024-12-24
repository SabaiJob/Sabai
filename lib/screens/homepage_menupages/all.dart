import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/screens/job_details_page.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:sabai_app/services/job_provider.dart';

import '../../components/work_card.dart';

class All extends StatelessWidget {
  const All({super.key});

  @override
  Widget build(BuildContext context) {
    var jobProvider = Provider.of<JobProvider>(context);
    return Container(
      color: const Color(0xffF7F7F7),
      child: ListView.builder(
        itemCount: jobProvider.allJobs.length, // Total number of items
        itemBuilder: (context, index) {
          return WorkCard(
            jobProvider.allJobs[index],
          );
        },
      ),
    );
  }
}
