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
  final List<String> _hotelJobs = ['Housekeeper', 'Janitorial Staff'];

  List<String> get allJobs => _allJobs;

  final List<String> _savedJobs = [];

  List<String> get savedJobs => _savedJobs;

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

  final List<String> _bestMatched = [];
  List<String> get bestMatched => _bestMatched;
  void addBestMatched(String category) {
    if (category.contains('Restaurant')) {
      _bestMatched.addAll(_restaurantJobs);
    } else if (category.contains('Hotel')) {
      _bestMatched.addAll(_hotelJobs);
    }
    notifyListeners();
  }

  final List<bool> _isPartner = [
    true,
    true,
    false,
    true,
    false,
  ];

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
