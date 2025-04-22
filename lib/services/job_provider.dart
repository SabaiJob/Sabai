import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/auth_pages/api_service.dart';

class JobProvider extends ChangeNotifier {
  JobProvider() {
    _initializeSavedJobs();
  }

  Future<void> _initializeSavedJobs() async {
    await loadSavedJobsFromLocal(); // Load from local storage
    await fetchSavedJobs(); // Sync with API
  }

  bool _isGuest = false;

  bool get isGuest {
    return _isGuest;
  }

  void setGuest(bool isGuest) {
    _isGuest = isGuest;
  }

  bool _isDraft = false;

  bool get isDraft {
    return _isDraft;
  }

  void setDraft(bool isDraft) {
    _isDraft = isDraft;
    notifyListeners();
  }

  //api integration All jobs page

  List<Map<String, dynamic>> _jobInfo = [];
  List<Map<String, dynamic>> _adInfo = [];
  List<dynamic> _jobs = [];
  bool _isLoading = false;
  int totalPages = 1; // Track total pages

  List<Map<String, dynamic>> get jobInfo => _jobInfo;
  List<Map<String, dynamic>> get adInfo => _adInfo;
  List<dynamic> get allTypeJobs => _jobs;
  bool get isLoading => _isLoading;

  void clearJobs() {
    allTypeJobs.clear();
    notifyListeners();
  }

  String locationType = 'local';
  void setLocatiobType(String value) {
    locationType = value;
    notifyListeners();
  }

  Future<void> getJobs(bool isLoading, {int page = 1}) async {
    _isLoading = isLoading;
    notifyListeners();

    try {
      final response = await ApiService.get(
          '/jobs/search/?location_type=$locationType&page=$page');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('hi this is from all jobs');
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        if (data.containsKey('results') && data['results'] is List) {
          final newJobs = data['results'];
          if (page == 1) {
            // Reset the list if it's the first page
            _jobs = newJobs;
          } else {
            // Append new jobs to the existing list
            _jobs.addAll(newJobs);
          }
          // Update total pages
          if (data.containsKey('total_pages')) {
            totalPages = data['total_pages'];
          }
        } else {
          print('Invalid response structure: ${response.body}');
        }
      } else {
        print('Error in get job: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
      _jobInfo = [];
      _adInfo = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getAllJobs() async {
    print("Checking jobs length: ${_jobs.length}"); // Debugging
    _jobs.clear(); // ✅ Clear jobs before fetching all pages
    int page = 1;
    bool hasMorePages = true;
    while (hasMorePages) {
      await getJobs(true, page: page);
      if (page >= totalPages) {
        hasMorePages = false;
      }
      page++;
    }
    print("Confirm  jobs length: ${_jobs.length}");
    notifyListeners(); // ✅ Ensure UI updates after all jobs are loaded
  }

  //fetch best matches jobs

  List<dynamic> _bestMatchedJobs = [];
  bool _isLoadingBestMatchedJobs = false;
  int totalBestMatchedPages = 1;
  // New getters for partner jobs
  List<dynamic> get bestMatchedJobs => _bestMatchedJobs;
  bool get isLoadingBestMatchedJobs => _isLoadingBestMatchedJobs;

  Future<void> getBestMatchedJobs(bool isLoading, {int page = 1}) async {
    _isLoadingBestMatchedJobs = isLoading;
    notifyListeners();

    try {
      final response =
          await ApiService.get('/jobs/search/?best_matches=true&page=$page');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('results') && data['results'] is List) {
          final newJobs = data['results'];
          if (page == 1) {
            // Reset the list if it's the first page
            _bestMatchedJobs = newJobs;
          } else {
            // Append new jobs to the existing list
            _bestMatchedJobs.addAll(newJobs);
          }
          // Update total pages
          if (data.containsKey('total_pages')) {
            totalBestMatchedPages = data['total_pages'];
          }
        } else {
          print('Invalid response structure: ${response.body}');
        }
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
      _bestMatchedJobs = [];
    } finally {
      _isLoadingBestMatchedJobs = false;
      notifyListeners();
    }
  }

  // New variables for partner jobs
  List<dynamic> _partnerJobs = [];
  bool _isLoadingPartnerJobs = false;
  int totalPartnerPages = 1;
  // New getters for partner jobs
  List<dynamic> get partnerJobs => _partnerJobs;
  bool get isLoadingPartnerJobs => _isLoadingPartnerJobs;

  // New method to fetch partner jobs
  Future<void> getPartnerJobs(bool isLoading, {int page = 1}) async {
    _isLoadingPartnerJobs = isLoading;
    notifyListeners();
    try {
      final response = await ApiService.get(
          '/jobs/search/?location_type=$locationType&page=$page&is_partner=true');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('results') && data['results'] is List) {
          final newJobs = data['results'];
          if (page == 1) {
            _partnerJobs = newJobs;
          } else {
            _partnerJobs.addAll(newJobs);
          }

          if (data.containsKey('total_pages')) {
            totalPartnerPages = data['total_pages'];
          }
        } else {
          print('Invalid response structure: ${response.body}');
        }
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
      _partnerJobs = [];
    } finally {
      _isLoadingPartnerJobs = false;
      notifyListeners();
    }
  }

  //save job with API
  Future<void> saveJob(int jobId, BuildContext context) async {
    try {
      final response = await ApiService.post('/jobs/save/', {'job_id': jobId});
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(response.body);
        toggleSavedJobs(jobId);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error ${response.body}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching data: $e'),
        ),
      );
    }
  }

  late List<int> _savedJobs = [];
  bool isSaved(int jobId) {
    return _savedJobs.contains(jobId);
  }

  //premium jobs
  List<dynamic> _premiumJobs = [];
  List<dynamic> get premiumJobs => _premiumJobs;
  bool isPremiumLoading = false;
  int premiumTotalPages = 1;
  Future<void> fetchPremiumJobs(bool isLoading, {int page = 1}) async {
    isPremiumLoading = isLoading;
    notifyListeners();
    try {
      final response = await ApiService.get(
          '/jobs/search/?is_new=true&location_type=$locationType&page=$page');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);
        final newJobs = data['results'];
        if (page == 1) {
          _premiumJobs = newJobs;
          // print(_premiumJobs);
          // print(newJobs);
        } else {
          _premiumJobs.addAll(newJobs);
        }

        if (data.containsKey('total_pages')) {
          premiumTotalPages = data['total_pages'];
        }
      } else {
        print('error ${response.body}');
      }
    } catch (e) {
      print(e);
    } finally {
      isPremiumLoading = false;
      notifyListeners();
    }
  }

  List<dynamic> _savedJobList = [];
  List<dynamic> get savedJobList => _savedJobList;

  Future<void> fetchSavedJobs() async {
    try {
      final response = await ApiService.get('/jobs/saved/');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        //print('Raw response body: ${response.body}');
        final List<dynamic> data = json.decode(response.body);
        _savedJobList = data;
        _savedJobs = data.map((job) => job['job']['id'] as int).toList();
        await saveJobsToLocal();
        notifyListeners();
      } else {
        print('Error ${response.body}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveJobsToLocal() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'saved_jobs', _savedJobs.map((id) => id.toString()).toList());
  }

  void toggleSavedJobs(int jobId) async {
    if (_savedJobs.contains(jobId)) {
      _savedJobs.remove(jobId);
    } else {
      _savedJobs.add(jobId);
    }
    await saveJobsToLocal(); // Save updated list locally
    notifyListeners();
  }

  Future<void> loadSavedJobsFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList('saved_jobs');
    if (savedList != null) {
      _savedJobs = savedList.map((id) => int.parse(id)).toList();
      notifyListeners();
    }
  }

  //fetch applied jobs
  List<dynamic> _appliedJobs = [];
  int _totalAppliedJobsPage = 1;
  int get totalAppliedJobsPage => _totalAppliedJobsPage;
  List<dynamic> get appliedJobs => _appliedJobs;
  bool isLoadigForAppliedJobs = true;
  Future<void> fetchAppliedJobs(bool isLoading, BuildContext context,
      {int page = 1}) async {
    try {
      isLoadigForAppliedJobs = isLoading;
      notifyListeners();
      final response =
          await ApiService.get('/jobs/search/?is_applied=true&page=$page');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);
        if (page == 1) {
          _appliedJobs = data['results'];
          notifyListeners();
        } else {
          _appliedJobs.addAll(data['results']);
          notifyListeners();
        }

        if (data.containsKey('total_pages')) {
          _totalAppliedJobsPage = data['total_pages'];
          notifyListeners();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error fetching data ${response.body}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error $e'),
        ),
      );
    } finally {}
    isLoadigForAppliedJobs = false;
    notifyListeners();
  }

  //fetch contributed jobs
  List<dynamic> _contributedJobs = [];
  int _totalContributedJobsPage = 1;
  int get totalContributedJobsPage => _totalContributedJobsPage;
  List<dynamic> get contributedJobs => _contributedJobs;
  bool isLoadingForContributedJobs = true;
  Future<void> fetchContributedJobs(bool isLoading, BuildContext context,
      {int page = 1}) async {
    try {
      isLoadingForContributedJobs = isLoading;
      notifyListeners();
      final response = await ApiService.get(
          '/jobs/search/?my_contributions=true&page=$page');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);
        if (page == 1) {
          _contributedJobs = data['results'];
          notifyListeners();
        } else {
          _contributedJobs.addAll(data['results']);
          notifyListeners();
        }

        if (data.containsKey('total_pages')) {
          _totalContributedJobsPage = data['total_pages'];
          notifyListeners();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error fetching data ${response.body}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error $e'),
        ),
      );
    } finally {}
    isLoadingForContributedJobs = false;
    notifyListeners();
  }

  //hardcoded stuff
  final List<String> _allJobs = [
    'Barista',
    'Chef',
    'Teacher',
    'Housekeeper',
    'Janitorial Staff'
  ];

  final List<String> _restaurantJobs = ['Barista', 'Chef'];
  final List<String> _hotelJobs = ['Janitorial Staff'];

  //List<String> get allJobs => _allJobs;

  final List<bool> _isPartner = [
    true,
    true,
    false,
    true,
    false,
  ];

  final List<Map<String, dynamic>> _bestMatched = [];
  List<Map<String, dynamic>> get bestMatched => _bestMatched;

  void addBestMatched(String category) {
    // _bestMatched.clear(); // Clear previous matches
    List<String> jobsToAdd = [];

    if (category.contains('Restaurant')) {
      jobsToAdd = _restaurantJobs;
    } else if (category.contains('Hotel')) {
      jobsToAdd = _hotelJobs;
    }

    // Add jobs with their partner status
    for (String job in jobsToAdd) {
      int index = _allJobs.indexOf(job);
      if (index != -1) {
        _bestMatched.add({
          'jobTitle': job,
          'isPartner': _isPartner[index],
        });
      }
    }
    notifyListeners();
  }

  List<Map<String, dynamic>> get combineJobs {
    List<Map<String, dynamic>> combined = [];
    for (int i = 0; i < _allJobs.length; i++) {
      combined.add({
        'jobTitle': _allJobs[i],
        'isPartner': _isPartner[i],
      });
    }
    return combined;
  }
}
