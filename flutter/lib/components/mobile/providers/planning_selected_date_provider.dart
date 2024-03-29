import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/mobile/models/ble_messages.dart';

class PlanningSelectedDateProvider with ChangeNotifier {
  static Date _selectedDate = Date(
      day: DateTime.now().day,
      month: DateTime.now().month,
      year: DateTime.now().year);

  Date get() {
    return _selectedDate;
  }

  void set(Date newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }
}
