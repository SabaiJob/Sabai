import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/work_card.dart';
import '../../services/job_provider.dart';

class BestMatches extends StatelessWidget {
  const BestMatches({super.key});

  @override
  Widget build(BuildContext context) {
    var jobProvider = Provider.of<JobProvider>(context);
    return Container(
      color: const Color(0xffF7F7F7),
      child: jobProvider.bestMatched.isNotEmpty
          ? ListView.builder(
              itemCount:
                  jobProvider.bestMatched.length, // Total number of items
              itemBuilder: (context, index) {
                return WorkCard(
                  jobProvider.bestMatched[index],
                );
              },
            )
          : const Center(
              child: Text('There is no best matches with your skill!'),
            ),
    );
  }
}
