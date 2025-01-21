import 'package:flutter/material.dart';

class PhoneNumberProvider extends ChangeNotifier{
  String _phoneNumber = '06';

  String get phoneNumber => _phoneNumber;

  void setPhoneNumber(String newNumber){
    _phoneNumber = newNumber;
    notifyListeners();
  }

}