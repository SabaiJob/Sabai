import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/ad_card.dart';
import '../../components/work_card.dart';
import '../../constants.dart';
import '../../services/job_provider.dart';

class Partnerships extends StatefulWidget {
  const Partnerships({super.key});

  @override
  State<Partnerships> createState() => _PartnershipsState();
}

class _PartnershipsState extends State<Partnerships> {
  final ScrollController _scrollController = ScrollController();
  int _currentPartnerPage = 1;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => fetchPartnerJobs());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_currentPartnerPage < jobProvider.totalPartnerPages) {
        _currentPartnerPage++;
        fetchPartnerJobs();
      }
    }
  }

  void fetchPartnerJobs() async {
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    await jobProvider.getPartnerJobs(_currentPartnerPage == 1,
        page: _currentPartnerPage);
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
          _currentPartnerPage = 1;
          await jobProvider.getPartnerJobs(false, page: _currentPartnerPage);
        },
        child: jobProvider.isLoadingPartnerJobs && _currentPartnerPage == 1
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.pink, // Use your primary color
                ),
              )
            : ListView.builder(
                controller: _scrollController,
                itemCount: jobProvider.partnerJobs.length + 1,
                itemBuilder: (context, index) {
                  if (index == jobProvider.partnerJobs.length) {
                    if (_currentPartnerPage < jobProvider.totalPartnerPages) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.pink,
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }
                  final job = jobProvider.partnerJobs[index];
                  if (job['type'] == 'job') {
                    final jobInfo = job['info'] as Map<String, dynamic>;
                    return WorkCard(
                      jobTitle: jobInfo['title'],
                      companyName: jobInfo['company_name'],
                      location: jobInfo['location'],
                      minSalary: jobInfo['salary_min'],
                      maxSalary: jobInfo['salary_max'],
                      currency: jobInfo['currency'],
                      jobId: jobInfo['id'],
                      isPartner: jobInfo['is_partner'],
                      closingAt: jobInfo['closing_at'],
                      safetyLevel: jobInfo['safety_level'],
                      viewCount: jobInfo['views_count'],
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
