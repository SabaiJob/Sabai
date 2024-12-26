import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/work_card.dart';
import '../../services/job_provider.dart';

class Partnerships extends StatelessWidget {
  const Partnerships({super.key});

  @override
  Widget build(BuildContext context) {
    var jobProvider = Provider.of<JobProvider>(context);

    final partnerJobs = jobProvider.combineJobs
        .where((job) => job['isPartner'] == true)
        .toList();

    return Container(
      color: const Color(0xffF7F7F7),
      child: ListView.builder(
        itemCount: partnerJobs.length, // Total number of items
        itemBuilder: (context, index) {
          final job = partnerJobs[index];
          return WorkCard(
            job['jobTitle'],
            job['isPartner'],
          );
        },
      ),
    );
  }
}
