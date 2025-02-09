import 'dart:convert';

import 'package:flutter/material.dart';

import '../screens/registration_&_login_pages/api_service.dart';

class JobFilterProvider with ChangeNotifier {
  //loading filtered jobs
  bool _isFiltered = false;
  void setFilter(bool value) {
    _isFiltered = value;
  }

  bool get isFiltered => _isFiltered;

  List<dynamic> _jobs = [];
  bool _isLoading = false;
  int totalPages = 1;
  String title = '';
  String category = '';
  String location = '';
  String jobType = '';
  bool? thaiLanguageRequired;
  int? salaryMin;
  int? salaryMax;
  bool? isVerified;

  // void setFiler({
  //   String? title,
  //   String? category,
  //   String? location,
  //   String? jobType,
  //   bool? thaiLanguageRequired,
  //   int? salaryMin,
  //   int? salaryMax,
  //   bool? isVerified,
  // }) {
  //   this.title = title!;
  //   this.category = category!;
  //   this.location = location!;
  //   this.jobType = jobType!;
  //   this.thaiLanguageRequired = thaiLanguageRequired!;
  //   this.salaryMax = salaryMax!;
  //   this.salaryMin = salaryMin!;
  //   this.isVerified = isVerified!;
  //   notifyListeners();
  // }

  void setCategory(String value) {
    category = value;
    notifyListeners();
  }

  void setTitle(String value) {
    title = value;
    notifyListeners();
  }

  List<dynamic> get allTypeJobs => _jobs;
  bool get isLoading => _isLoading;

  Future<void> getFilterJobs(
    bool isLoading, {
    int page = 1,
  }) async {
    _isLoading = isLoading;
    notifyListeners();

    try {
      String url = '/jobs/search/?page=$page';

      // Append filters to URL if provided
      if (title.isNotEmpty) url += '&title=$title';
      if (category.isNotEmpty) url += '&category=$category';
      if (location.isNotEmpty) url += '&location=$location';
      if (jobType.isNotEmpty) url += '&job_type=$jobType';
      if (thaiLanguageRequired != null) {
        url += '&thai_language_required=$thaiLanguageRequired';
      }
      if (salaryMin != null) url += '&salary_min=$salaryMin';
      if (salaryMax != null) url += '&salary_max=$salaryMax';
      if (isVerified != null) url += '&is_verified=$isVerified';

      final response = await ApiService.get(url);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('results') && data['results'] is List) {
          final newJobs = data['results'];
          if (page == 1) {
            _jobs = newJobs;
          } else {
            _jobs.addAll(newJobs);
          }

          if (data.containsKey('total_pages')) {
            totalPages = data['total_pages'];
          }
        } else {
          print('Invalid response structure: ${response.body}');
        }
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
      _jobs = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Map<String, dynamic>? _filterValues;

  Map<String, dynamic>? get filterValues => _filterValues;

  void updateFilterValues(Map<String, dynamic>? values) {
    _filterValues = values;
    notifyListeners();
  }

  int calculateFilterCount() {
    if (_filterValues == null) return 0;

    int count = 0;
    count += (_filterValues!['jobNames'] as List?)?.length ?? 0;
    count += (_filterValues!['jobCategories'] as List?)?.length ?? 0;
    count += (_filterValues!['jobLocations'] as List?)?.length ?? 0;
    count += (_filterValues!['jobTypes'] as List?)?.length ?? 0;
    count += _filterValues!['thaiLanguageRequired'] == true ? 1 : 0;
    count += _filterValues!['verificationRequired'] == true ? 1 : 0;
    count += (_filterValues!['salaryRange'] > 1000.00) ? 1 : 0;

    return count;
  }
}
