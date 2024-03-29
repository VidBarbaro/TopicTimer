import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/mobile/models/ble_messages.dart';

class PlanningSelectedViewProvider with ChangeNotifier {
  static bool _isPlanning = true;

  bool get() {
    return _isPlanning;
  }

  void toggle() {
    _isPlanning = !_isPlanning;
    print('toggling...');
    notifyListeners();
  }
}
