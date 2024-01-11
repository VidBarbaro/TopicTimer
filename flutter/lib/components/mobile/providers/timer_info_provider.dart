import 'package:flutter/material.dart';

class TimerInfoProvider with ChangeNotifier {
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;
  bool _isActive = false;
  bool get isActive => _isActive;
  bool _isButtonActive = false;
  bool get isButtonActive => _isButtonActive;
  bool _isPaused = false;
  bool get isPaused => _isPaused;
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  void setInit() {
    _isInitialized = true;
  }

  void disableButton() {
    _isButtonActive = true;
  }
  void enableButton() {
    _isButtonActive = false;
  }

  void resetTimer() {
    _hours = 0;
    _minutes = 0;
    _seconds = 0;
    _isPaused = false;
    _isButtonActive = false;
    _isActive = false;
    notifyListeners();
  }

  void enableTimer() {
    _isActive = true;
    _isButtonActive = true;
    _isPaused = false;
    notifyListeners();
  }

  void pauseTimer() {
    _isPaused = true;
  }

  void disableTimer() {
    _isActive = false;
    _isButtonActive = false;
    _isPaused = false;
    notifyListeners();
  }

  void tick() {
    if (!_isActive || _isPaused) {
      //Early return because Timer is not active or is paused
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
