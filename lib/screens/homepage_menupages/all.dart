import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/services/job_provider.dart';
import '../../components/work_card.dart';

class All extends StatelessWidget {
  const All({super.key});

  @override
  Widget build(BuildContext context) {
    var jobProvider = Provider.of<JobProvider>(context);
    return Container(
      color: const Color(0xffF7F7F7),
      child: RefreshIndicator(
        color: primaryPinkColor,
        backgroundColor: const Color(0xffFFEBF6),
        onRefresh: () async {
          await Future.delayed(
            const Duration(seconds: 1),
          );
        },
        child: ListView.builder(
          itemCount: jobProvider.allJobs.length, // Total number of items
          itemBuilder: (context, index) {
            final job = jobProvider.combineJobs[index];
            return WorkCard(
              job['jobTitle'],
              job['isPartner'],
            );
          },
        ),
      ),
    );
  }
}
