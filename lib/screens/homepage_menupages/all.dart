import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/ad_card.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/services/job_provider.dart';
import 'package:sabai_app/services/jobfilter_provider.dart';
import 'package:sabai_app/services/payment_provider.dart';
import '../../components/work_card.dart';

class All extends StatefulWidget {
  const All({super.key});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => fetchJobs());
    //Future.microtask(() => fetchAllJobs());
    Future.microtask(() => fetchFilterJobs());
    Future.microtask(() => fetchPremiumJobs());
    Future.microtask(() => fetchUserData());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    final jobFilterProvider =
        Provider.of<JobFilterProvider>(context, listen: false);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Check if there are more pages to load

      if (jobFilterProvider.isFiltered) {
        if (_currentPage < jobFilterProvider.totalPages) {
          _currentPage++;
          fetchFilterJobs();
        }
      } else {
        if (_currentPage < jobProvider.totalPages) {
          _currentPage++;
          fetchJobs();
        }
      }
    }
  }

  void fetchJobs() async {
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    await jobProvider.getJobs(_currentPage == 1, page: _currentPage);
  }

  void fetchPremiumJobs() async {
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    await jobProvider.fetchPremiumJobs(_currentPage == 1, page: _currentPage);
  }

  void fetchUserData() async {
    final paymentProvider =
        Provider.of<PaymentProvider>(context, listen: false);
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    if (!jobProvider.isGuest) {
      await paymentProvider.getProfileData(context);
    }
  }

  void fetchAllJobs() async {
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    if (jobProvider.isLoading) return;
    await jobProvider.getAllJobs();
  }

  void fetchFilterJobs() async {
    final jobProvider = Provider.of<JobFilterProvider>(context, listen: false);
    await jobProvider.getFilterJobs(_currentPage == 1, page: _currentPage);
  }

  

  @override
  Widget build(BuildContext context) {
    var jobProvider = Provider.of<JobProvider>(context);
    var jobFetchedProvider = Provider.of<JobFilterProvider>(context);
    var paymentProvider = Provider.of<PaymentProvider>(context);
    if (jobProvider.isGuest == true) {
      return Container(
        color: const Color(0xffF7F7F7),
        child: RefreshIndicator(
          color: primaryPinkColor,
          backgroundColor: const Color(0xffFFEBF6),
          onRefresh: () async {
            // Reset to the first page on refresh
            _currentPage = 1;
            //await jobProvider.getAllJobs();
            await jobProvider.getJobs(_currentPage == 1, page: _currentPage);
          },
          child: jobProvider.isLoading && _currentPage == 1
              ? const Center(
                  child: CircularProgressIndicator(
                    color: primaryPinkColor,
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: jobProvider.allTypeJobs.length + 1,
                  itemBuilder: (context, index) {
                    if (index == jobProvider.allTypeJobs.length) {
                      // Show a loading indicator at the bottom if there are more pages to load
                      if (_currentPage < jobProvider.totalPages) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: primaryPinkColor,
                          ),
                        );
                      } else {
                        // No more pages to load
                        return Container();
                      }
                    }
                    final job = jobProvider.allTypeJobs[index];
                    if (job['type'] == 'job') {
                      final jobInfo = job['info'] as Map<String, dynamic>;
                      return WorkCard(
                        jobTitle: jobInfo['title'] ?? 'none',
                        companyName: jobInfo['company_name'] ?? 'none',
                        location: jobInfo['location'] ?? 'none',
                        minSalary: jobInfo['salary_min'] ?? 0,
                        maxSalary: jobInfo['salary_max'] ?? 0,
                        currency: jobInfo['currency'] ?? 'none',
                        jobId: jobInfo['id'] ?? 0,
                        isPartner: jobInfo['is_partner'] ?? false,
                        closingAt: jobInfo['closing_at'] ?? '',
                        safetyLevel: jobInfo['safety_level'],
                        viewCount: jobInfo['views_count'],
                        isNegotiable: jobInfo['is_salary_negotiable'],
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
    } else if (paymentProvider.userData == null) {
      return const Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: CircularProgressIndicator(
            color: primaryPinkColor,
          ),
        ),
      ); // Show loading state
    }
    return jobFetchedProvider.isFiltered
        ? Container(
            color: const Color(0xffF7F7F7),
            child: RefreshIndicator(
              color: primaryPinkColor,
              backgroundColor: const Color(0xffFFEBF6),
              onRefresh: () async {
                // Reset to the first page on refresh
                _currentPage = 1;
                await jobFetchedProvider.getFilterJobs(false,
                    page: _currentPage);
              },
              child: jobFetchedProvider.isLoading && _currentPage == 1
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primaryPinkColor,
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: jobFetchedProvider.allTypeJobs.length + 1,
                      itemBuilder: (context, index) {
                        if (index == jobFetchedProvider.allTypeJobs.length) {
                          // Show a loading indicator at the bottom if there are more pages to load
                          if (_currentPage < jobFetchedProvider.totalPages) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: primaryPinkColor,
                              ),
                            );
                          } else {
                            // No more pages to load
                            return Container();
                          }
                        }
                        final job = jobFetchedProvider.allTypeJobs[index];
                        if (job['type'] == 'job') {
                          final jobInfo = job['info'] as Map<String, dynamic>;
                          return WorkCard(
                            jobTitle: jobInfo['title'] ?? 'none',
                            companyName: jobInfo['company_name'] ?? 'none',
                            location: jobInfo['location'] ?? 'none',
                            minSalary: jobInfo['salary_min'] ?? 0,
                            maxSalary: jobInfo['salary_max'] ?? 0,
                            currency: jobInfo['currency'] ?? 'none',
                            jobId: jobInfo['id'] ?? 0,
                            isPartner: jobInfo['is_partner'] ?? false,
                            closingAt: jobInfo['closing_at'] ?? '',
                            safetyLevel: jobInfo['safety_level'],
                            viewCount: jobInfo['views_count'],
                            isNegotiable: jobInfo['is_salary_negotiable']
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
          )
        : paymentProvider.userData!['is_premium'] == true
            ? Container(
                color: const Color(0xffF7F7F7),
                child: RefreshIndicator(
                  color: primaryPinkColor,
                  backgroundColor: const Color(0xffFFEBF6),
                  onRefresh: () async {
                    // Reset to the first page on refresh
                    //_currentPage = 1;
                    await jobProvider.fetchPremiumJobs(true);
                  },
                  child: jobProvider.isPremiumLoading == true
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryPinkColor,
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: jobProvider.premiumJobs.length + 1,
                          itemBuilder: (context, index) {
                            if (index == jobProvider.premiumJobs.length) {
                              // Show a loading indicator at the bottom if there are more pages to load
                              if (_currentPage <
                                  jobProvider.premiumTotalPages) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: primaryPinkColor,
                                  ),
                                );
                              } else {
                                // No more pages to load
                                return Container();
                              }
                            }
                            final jobType = jobProvider.premiumJobs[index];
                            if (jobType['type'] == 'job') {
                              final job = jobType['info'];
                              return WorkCard(
                                jobTitle: job['title'] ?? 'none',
                                companyName: job['company_name'] ?? 'none',
                                location: job['location'] ?? 'none',
                                minSalary: job['salary_min'] ?? 0,
                                maxSalary: job['salary_max'] ?? 0,
                                currency: job['currency'] ?? 'none',
                                jobId: job['id'] ?? 0,
                                isPartner: job['is_partner'] ?? false,
                                closingAt: job['closing_at'] ?? '',
                                safetyLevel: job['safety_level'] ?? '',
                                viewCount: job['views_count'] ?? 0,
                                isNegotiable: job['is_salary_negotiable'],
                              );
                            } else {
                              final adInfo =
                                  jobType['info'] as Map<String, dynamic>;
                              return AdCard(
                                url: adInfo['link'],
                                imageUrl: adInfo['poster'],
                              );
                            }
                            // return SizedBox(
                            //   child: Text('none'),
                            // );
                          },
                        ),
                ),
              )
            : Container(
                color: const Color(0xffF7F7F7),
                child: RefreshIndicator(
                  color: primaryPinkColor,
                  backgroundColor: const Color(0xffFFEBF6),
                  onRefresh: () async {
                    // Reset to the first page on refresh
                    _currentPage = 1;
                    await jobProvider.getJobs(_currentPage == 1,
                        page: _currentPage);
                    // await jobProvider.getAllJobs();
                  },
                  child: jobProvider.isLoading && _currentPage == 1
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryPinkColor,
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: jobProvider.allTypeJobs.length + 1,
                          itemBuilder: (context, index) {
                            if (index == jobProvider.allTypeJobs.length) {
                              // Show a loading indicator at the bottom if there are more pages to load
                              if (_currentPage < jobProvider.totalPages) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: primaryPinkColor,
                                  ),
                                );
                              } else {
                                // No more pages to load
                                return Container();
                              }
                            }
                            final job = jobProvider.allTypeJobs[index];
                            if (job['type'] == 'job') {
                              final jobInfo =
                                  job['info'] as Map<String, dynamic>;
                              // print(jobInfo);
                              return WorkCard(
                                jobTitle: jobInfo['title'] ?? 'none',
                                companyName: jobInfo['company_name'] ?? 'none',
                                location: jobInfo['location'] ?? 'none',
                                minSalary: jobInfo['salary_min'] ?? 0,
                                maxSalary: jobInfo['salary_max'] ?? 0,
                                currency: jobInfo['currency'] ?? 'none',
                                jobId: jobInfo['id'] ?? 0,
                                isPartner: jobInfo['is_partner'] ?? false,
                                closingAt: jobInfo['closing_at'] ?? '',
                                safetyLevel: jobInfo['safety_level'],
                                viewCount: jobInfo['views_count'],
                                isNegotiable: jobInfo['is_salary_negotiable'],
                              );
                            } else {
                              final adInfo =
                                  job['info'] as Map<String, dynamic>;
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
