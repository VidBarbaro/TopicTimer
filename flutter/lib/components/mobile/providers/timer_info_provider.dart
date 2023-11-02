import 'package:flutter/material.dart';

class TimerInfoProvider with ChangeNotifier {
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;
  bool _isActive = false;
  bool get isActive => _isActive;
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  void setInit() {
    _isInitialized = true;
  }

  void resetTimer() {
    _hours = 0;
    _minutes = 0;
    _seconds = 0;
    _isActive = false;
    notifyListeners();
  }

  void enableTimer() {
    _isActive = true;
    notifyListeners();
  }

  void disableTimer() {
    _isActive = false;
    notifyListeners();
  }

  void tick() {
    if (!_isActive) {
      notifyListeners();
      return;
    }
    _seconds++;
    if (_seconds > 59) {
      _minutes++;
      _seconds = 0;
      if (_minutes > 59) {
        _hours++;
        _minutes = 0;
      }
    }
    notifyListeners();
  }

  @override
  String toString() {
    String outputString = '';
    _hours < 10 ? outputString += '0$_hours:' : outputString += '$_hours:';
    _minutes < 10
        ? outputString += '0$_minutes:'
        : outputString += '$_minutes:';
    _seconds < 10 ? outputString += '0$_seconds' : outputString += '$_seconds';
    return outputString;
  }
}
