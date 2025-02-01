import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/ad_card.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/services/job_provider.dart';
import '../../components/work_card.dart';

class All extends StatefulWidget {
  const All({super.key});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => fetchJobs());
  }

  void fetchJobs() async {
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    await jobProvider.getJobs(true);
  }

  @override
  Widget build(BuildContext context) {
    var jobProvider = Provider.of<JobProvider>(context);
    return Container(
      color: const Color(0xffF7F7F7),
      child: RefreshIndicator(
        color: primaryPinkColor,
        backgroundColor: const Color(0xffFFEBF6),
        onRefresh: () async {
          await jobProvider.getJobs(false);
        },
        child: jobProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: primaryPinkColor,
                ),
              )
            : ListView.builder(
                itemCount: jobProvider.allTypeJobs.length,
                itemBuilder: (context, index) {
                  final job = jobProvider.allTypeJobs[index];
                  if (job['type'] == 'job') {
                    final jobInfo = job['info'] as Map<String, dynamic>;
                    return WorkCard(
                      jobTitle: jobInfo['title'],
                      companyName: jobInfo['company_name'],
                      location: jobInfo['location'],
                      minSalary: jobInfo['salary_min'],
                      maxSalary: jobInfo['salary_max'],
                      currency: jobInfo['currency'],
                      isPartner: true,
                    );
                  } else {
                    final adInfo = job['info'] as Map<String, dynamic>;
                    return AdCard(
                      url: adInfo['link'],
                      imageUrl: adInfo['poster'],
                    );
                  }
                },
              ),
      ),
    );
  }
}
