import 'dart:async';
import 'package:flutter/material.dart';

class OtpCodeTimerProvider extends ChangeNotifier {
  Timer? _timer;
  int _initialTime = 60;
  bool _isTimerActive = false;

  int get remainingTime => _initialTime;
  bool get isTimerActive => _isTimerActive;

  void startTimer() {
    _initialTime = 60;
    _isTimerActive = true;
    notifyListeners();

    _timer?.cancel(); 
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_initialTime > 0) {
        _initialTime--;
        notifyListeners();
      } else {
        _isTimerActive = false;
        _timer?.cancel();
        notifyListeners();
      }
    });
  }

  void resetTimer() {
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
