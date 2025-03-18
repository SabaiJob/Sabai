import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../screens/auth_pages/api_service.dart';

class PaymentProvider extends ChangeNotifier {
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
  Future<void> getProfileData() async {
    try {
      final response = await ApiService.get('/auth/token/verify/');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _userData = data;
        notifyListeners();
        //print(_userData);
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
