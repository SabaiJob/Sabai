import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _lan = 'English';

  String get lan => _lan;

  void setLan(String lan) {
    _lan = lan;
    notifyListeners();
  }
}
