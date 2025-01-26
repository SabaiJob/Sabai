import 'package:flutter/material.dart';
class JobFilterProvider with ChangeNotifier {
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