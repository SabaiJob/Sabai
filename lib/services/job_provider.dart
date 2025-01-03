import 'package:flutter/material.dart';

class JobProvider extends ChangeNotifier {
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
