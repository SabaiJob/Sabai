import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/ad_card.dart';
import '../../components/work_card.dart';
import '../../constants.dart';
import '../../services/job_provider.dart';

class BestMatches extends StatefulWidget {
  const BestMatches({super.key});

  @override
  State<BestMatches> createState() => _BestMatchesState();
}

class _BestMatchesState extends State<BestMatches> {
  final ScrollController _scrollController = ScrollController();
  int _currentBestMatchedPage = 1;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => fetchBestMatchedJobs());
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
      if (_currentBestMatchedPage < jobProvider.totalBestMatchedPages) {
        _currentBestMatchedPage++;
        fetchBestMatchedJobs();
      }
    }
  }

  void fetchBestMatchedJobs() async {
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    await jobProvider.getBestMatchedJobs(_currentBestMatchedPage == 1,
        page: _currentBestMatchedPage);
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
          _currentBestMatchedPage = 1;
          await jobProvider.getBestMatchedJobs(false,
              page: _currentBestMatchedPage);
        },
        child:
            jobProvider.isLoadingBestMatchedJobs && _currentBestMatchedPage == 1
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.pink, // Use your primary color
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: jobProvider.bestMatchedJobs.length + 1,
                    itemBuilder: (context, index) {
                      if (index == jobProvider.bestMatchedJobs.length) {
                        if (_currentBestMatchedPage <
                            jobProvider.totalBestMatchedPages) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.pink,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }
                      final job = jobProvider.bestMatchedJobs[index];
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
