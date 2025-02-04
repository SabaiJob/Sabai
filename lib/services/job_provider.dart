import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/registration_&_login_pages/api_service.dart';

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

  String _type = '';
  List<Map<String, dynamic>> _jobInfo = [];
  List<Map<String, dynamic>> _adInfo = [];
  List<dynamic> _jobs = [];
  bool _isLoading = false;
  int totalPages = 1; // Track total pages

  List<Map<String, dynamic>> get jobInfo => _jobInfo;
  List<Map<String, dynamic>> get adInfo => _adInfo;
  List<dynamic> get allTypeJobs => _jobs;
  bool get isLoading => _isLoading;
  String get type => _type;

  Future<void> getJobs(bool isLoading, {int page = 1}) async {
    _isLoading = isLoading;
    notifyListeners();

    try {
      final response = await ApiService.get('/jobs/?page=$page');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('results') && data['results'] is List) {
          final newJobs = data['results'];
          if (page == 1) {
            // Reset the list if it's the first page
            _jobs = newJobs;
          } else {
            // Append new jobs to the existing list
            _jobs.addAll(newJobs);
          }
          _jobInfo = _jobs
              .where((job) => job['type'] == 'job')
              .map((job) => job['info'] as Map<String, dynamic>)
              .toList();
          _adInfo = _jobs
              .where((job) => job['type'] == 'ads')
              .map((job) => job['info'] as Map<String, dynamic>)
              .toList();
          _type = _jobInfo.isNotEmpty
              ? 'job'
              : _adInfo.isNotEmpty
                  ? 'ads'
                  : '';

          // Update total pages
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
      _jobInfo = [];
      _adInfo = [];
    } finally {
      _isLoading = false;
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully save the job!'),
          ),
        );
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
  // void toggleSavedJobs(int jobId) {
  //   if (_savedJobs.contains(jobId)) {
  //     _savedJobs.remove(jobId);
  //   } else {
  //     _savedJobs.add(jobId);
  //   }
  //   notifyListeners();
  // }

  bool isSaved(int jobId) {
    return _savedJobs.contains(jobId);
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

  // void toggleSavedJobs(String jobTitle) {
  //   if (_savedJobs.contains(jobTitle)) {
  //     _savedJobs.remove(jobTitle);
  //   } else {
  //     _savedJobs.add(jobTitle);
  //   }
  //   notifyListeners();
  // }

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
