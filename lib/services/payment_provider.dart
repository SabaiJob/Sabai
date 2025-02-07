import 'package:flutter/foundation.dart';

class PaymentProvider extends ChangeNotifier {
  int _pricingPlanId = 0;
  int _paymentMethodId = 0;

  int get pricingPlanId => _pricingPlanId;
  int get paymentMethodId => _paymentMethodId;

  void setPricingPlanId(int pricingPlanId) {
    _pricingPlanId = pricingPlanId;
    notifyListeners();
  }

  void setPaymentMethodId(int paymentMethodId) {
    _paymentMethodId = paymentMethodId;
    notifyListeners();
  }
}
