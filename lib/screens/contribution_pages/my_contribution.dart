import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/services/language_provider.dart';

import '../../components/ad_card.dart';
import '../../components/work_card.dart';
import '../../constants.dart';
import '../../services/job_provider.dart';

class MyContribution extends StatefulWidget {
  const MyContribution({super.key});

  @override
  State<MyContribution> createState() => _MyContributionState();
}

class _MyContributionState extends State<MyContribution> {
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String searchQuery = "";
  int _currentContributedJobsPages = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<JobProvider>(context, listen: false).fetchContributedJobs(
          _currentContributedJobsPages == 1, context,
          page: _currentContributedJobsPages);
    });
  }

  void _onScroll() {
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_currentContributedJobsPages < jobProvider.totalContributedJobsPage) {
        _currentContributedJobsPages++;
        jobProvider.fetchAppliedJobs(false, context,
            page: _currentContributedJobsPages);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    final jobProvider = Provider.of<JobProvider>(context);
    final contributedJobs = jobProvider.contributedJobs
        .where((job) => job['type'] == 'job')
        .toList();
    final filterJobs = contributedJobs.where((job) {
      final jobInfo = job['info'] as Map<String, dynamic>;
      final jobTitle = jobInfo['title'] as String;
      bool matchesQuery =
          jobTitle.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesQuery;
    }).toList();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: languageProvider.lan == 'English'
            ? const Text(
                "My Contributions",
                style: appBarTitleStyleEng,
              )
            : const Text(
                'ကျွန်တော့်ကူညီမှုများ',
                style: appBarTitleStyleMn,
              ),
        iconTheme: const IconThemeData(
          color: primaryPinkColor,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey.shade300, // Border color
            height: 1.0, // Border thickness
          ),
        ),
      ),
      body: jobProvider.isLoadingForContributedJobs == true
          ? const Center(
              child: CircularProgressIndicator(
                color: primaryPinkColor,
              ),
            )
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: TextField(
                        controller: _searchController,
                        onTap: () {
                          setState(() {
                            isSearching = true;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Search by Keyword',
                          prefixIcon: isSearching
                              ? GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      isSearching = false;
                                      searchQuery = '';
                                      _searchController.clear();
                                    });
                                  },
                                  child: const Icon(
                                    CupertinoIcons.clear,
                                    size: 20,
                                    color: primaryPinkColor,
                                  ),
                                )
                              : const Icon(
                                  CupertinoIcons.search,
                                  size: 20,
                                  color: primaryPinkColor,
                                ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color(0xffF0F1F2),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color(0xffF0F1F2),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (isSearching) ...[
                      Expanded(
                        child: ListView.builder(
                            itemCount: filterJobs.length,
                            itemBuilder: (context, index) {
                              var job = filterJobs[index];
                              var jobInfo = job['info'] as Map<String, dynamic>;
                              return WorkCard(
                                jobTitle: jobInfo['title'] ?? '',
                                isPartner: jobInfo['is_partner'] ?? '',
                                companyName: jobInfo['company_name'] ?? '',
                                location: jobInfo['location'] ?? '',
                                maxSalary: jobInfo['salary_max'] ?? 0,
                                minSalary: jobInfo['salary_min'] ?? 0,
                                currency: jobInfo['currency'] ?? '',
                                jobId: jobInfo['id'] ?? '',
                                closingAt: jobInfo['closing_at'] ?? '',
                                safetyLevel: jobInfo['safety_level'] ?? '',
                                viewCount: jobInfo['views_count'] ?? '',
                                isNegotiable: jobInfo['is_salary_negotiable'] ?? '',
                              );
                              //return SizedBox();
                            }),
                      ),
                    ] else ...[
                      Text(
                        'Total ( ${jobProvider.contributedJobs.length} ) posts',
                        style: const TextStyle(
                          fontFamily: 'Bricolage-M',
                          fontSize: 15.63,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      jobProvider.contributedJobs.isEmpty
                          ? const Center(
                              child: Text(
                                'You haven\'t posted any jobs yet! ',
                                style: TextStyle(
                                  fontFamily: 'Bricolage-M',
                                  fontSize: 15.63,
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                  controller: _scrollController,
                                  itemCount:
                                      jobProvider.contributedJobs.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index ==
                                        jobProvider.contributedJobs.length) {
                                      if (_currentContributedJobsPages <
                                          jobProvider
                                              .totalContributedJobsPage) {
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color: primaryPinkColor,
                                          ),
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    }

                                    final appliedJobs =
                                        jobProvider.contributedJobs;
                                    if (appliedJobs[index]['type'] == 'job') {
                                      final jobDetail =
                                          appliedJobs[index]['info'];
                                      return WorkCard(
                                        jobTitle: jobDetail['title'] ?? '',
                                        isPartner: jobDetail['is_partner'] ?? '',
                                        companyName: jobDetail['company_name'] ?? '',
                                        location: jobDetail['location'] ?? '',
                                        maxSalary: jobDetail["salary_max"] ?? 0,
                                        minSalary: jobDetail["salary_min"] ?? 0,
                                        currency: jobDetail['currency'] ?? '',
                                        jobId: jobDetail['id'] ?? '',
                                        closingAt: jobDetail['closing_at'] ?? '',
                                        safetyLevel: jobDetail['safety_level'] ?? '',
                                        viewCount: jobDetail['views_count'] ?? '',
                                        isNegotiable: jobDetail['is_salary_negotiable'] ?? '',
                                      );
                                    } else {
                                      final adInfo = appliedJobs[index]['info'];
                                      return AdCard(
                                        url: adInfo['link'],
                                        imageUrl: adInfo['poster'],
                                      );
                                    }
                                  }),
                            )
                    ]
                  ],
                ),
              ),
            ),
    );
  }
}
