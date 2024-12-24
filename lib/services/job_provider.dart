import 'package:flutter/material.dart';

class JobProvider extends ChangeNotifier {
  final List<String> _savedJobs = [];

  List<String> get savedJobs => _savedJobs;

  void toggleSavedJobs(String jobTite) {
    if (_savedJobs.contains(jobTite)) {
      _savedJobs.remove(jobTite);
    } else {
      _savedJobs.add(jobTite);
    }
    notifyListeners();
  }

  bool isSaved(String jobTitle) {
    return savedJobs.contains(jobTitle);
  }
}
