import 'dart:convert';

import 'package:flutter/material.dart';

import '../screens/registration_&_login_pages/api_service.dart';

class JobProvider extends ChangeNotifier {
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
  bool _isLoading = false;

  List<Map<String, dynamic>> get jobInfo => _jobInfo;
  bool get isLoading => _isLoading;

  Future<void> getJobs(bool isLoading) async {
    _isLoading = isLoading;
    notifyListeners();

    try {
      final response = await ApiService.get('/jobs/');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('results') && data['results'] is List) {
          final List<dynamic> jobs = data['results'];
          _jobInfo =
              jobs.map((job) => job['info'] as Map<String, dynamic>).toList();
        } else {
          print('Invalid response structure: ${response.body}');
        }
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
      _jobInfo = [];
    } finally {
      _isLoading = false;
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

  List<String> get allJobs => _allJobs;

  final List<String> _savedJobs = [];
  List<String> get savedJobs => _savedJobs;

  final List<bool> _isPartner = [
    true,
    true,
    false,
    true,
    false,
  ];

  final List<Map<String, dynamic>> _bestMatched = [];
  List<Map<String, dynamic>> get bestMatched => _bestMatched;

  void toggleSavedJobs(String jobTitle) {
    if (_savedJobs.contains(jobTitle)) {
      _savedJobs.remove(jobTitle);
    } else {
      _savedJobs.add(jobTitle);
    }
    notifyListeners();
  }

  bool isSaved(String jobTitle) {
    return savedJobs.contains(jobTitle);
  }

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
