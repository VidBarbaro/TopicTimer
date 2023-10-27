import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/mobile/models/navbar_index_model.dart';

NavBarIndex currentNavBarIndex = NavBarIndex(index: 2);

class NavBarIndexProvider with ChangeNotifier {
  NavBarIndex currentIndex = currentNavBarIndex;
  NavBarIndex get index => currentIndex;

  void updateIndex(int newIndex) {
    currentIndex.index = newIndex;
    print(newIndex.toString());
    notifyListeners();
  }
}
