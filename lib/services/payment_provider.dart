import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sabai_app/screens/walkthrough.dart';

import '../screens/auth_pages/api_service.dart';
import '../screens/auth_pages/token_service.dart';

class PaymentProvider extends ChangeNotifier {
  //for saving draft
  String _userPhNo = '';
  String get userPhNo => _userPhNo;

  String _purchaseDate = '';
  int _pricingPlanId = 0;
  int _paymentMethodId = 0;

  int get pricingPlanId => _pricingPlanId;
  int get paymentMethodId => _paymentMethodId;
  String get purchaseDate => _purchaseDate;

  void setPurchaseDate(String value) {
    _purchaseDate = value;
    notifyListeners();
  }

  void setPricingPlanId(int pricingPlanId) {
    _pricingPlanId = pricingPlanId;
    notifyListeners();
  }

  void setPaymentMethodId(int paymentMethodId) {
    _paymentMethodId = paymentMethodId;
    notifyListeners();
  }

  Map<String, dynamic>? _userData;
  Map<String, dynamic>? get userData => _userData;
  Future<void> getProfileData(BuildContext context) async {
    try {
      final response = await ApiService.get('/auth/token/verify/');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _userData = data;
        notifyListeners();
        _userPhNo = _userData!['phone'];
        print(_userPhNo);
        print(_userData!['user_info']['email']);
      } else {
        print(response.body);
        if (response.statusCode == 401) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Walkthrough(),
            ),
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }
  Map<String, dynamic>? _roseCount;
  Map<String, dynamic>? get roseCount => _roseCount;

  Future<void> getRoseCount(BuildContext context)async{
    try{
      final response = await ApiService.get('/rewards/rose-history/');
      final Map<String, dynamic> data = jsonDecode(response.body);
      _roseCount = data;
      notifyListeners();
      print('total_roses: ${_roseCount!['total_roses']}');
      print('rose_history: ${_roseCount!['rose_history']}');

    }catch(e){
      print(e);
    }
  }
}
