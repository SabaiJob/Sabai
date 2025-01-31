import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/services/job_provider.dart';
import '../../components/work_card.dart';

class All extends StatefulWidget {
  const All({
    super.key,
  });

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchJobs();
  }

  void fetchJobs() async {
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    await jobProvider.getJobs(true); // Fetch the jobs
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
                itemCount: jobProvider.jobInfo.length, // Total number of items
                itemBuilder: (context, index) {
                  final jobInfo = jobProvider.jobInfo;
                  return WorkCard(
                    jobTitle: jobInfo[index]['title'],
                    companyName: jobInfo[index]['company_name'],
                    location: jobInfo[index]['location'],
                    minSalary: jobInfo[index]['salary_min'],
                    maxSalary: jobInfo[index]['salary_max'],
                    currency: jobInfo[index]['currency'],
                    isPartner: true,
                  );
                },
              ),
      ),
    );
  }
}
