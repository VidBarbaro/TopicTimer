import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimerInfoProvider with ChangeNotifier {
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;
  bool _isActive = false;

  // void startTimer() {
  //   if (isActive == false) {
  //     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //       context.watch<_timerInfoProvider>().tick();
  //     });
  //   }
  //   isActive = true;
  // }

  void pauseTimer() {
    _isActive = false;
  }

  void resetTimer() {
    _hours = 0;
    _minutes = 0;
    _seconds = 0;
    _isActive = false;
  }

  void tick() {
    _seconds++;
    if (_seconds > 59) {
      _minutes++;
      _seconds = 0;
      if (_minutes > 59) {
        _hours++;
        _minutes = 0;
      }
    }
    print(toString());
    notifyListeners();
  }

  @override
  String toString() {
    return '${_hours}:${_minutes}:${_seconds}';
  }
}
