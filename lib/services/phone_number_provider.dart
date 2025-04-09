import 'package:flutter/material.dart';

class PhoneNumberProvider extends ChangeNotifier{
  String _email = '';

  String get phoneNumber => _email;

  void setEmail(String newEmail){
    _email = newEmail;
    notifyListeners();
  }

}