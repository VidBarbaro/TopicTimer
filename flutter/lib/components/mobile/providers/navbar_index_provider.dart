import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/mobile/models/navbar_index_model.dart';

NavBarIndex currentNavBarIndex =
    NavBarIndex(pageIndex: 2, selectedTopicIndex: 0);

class NavBarIndexProvider with ChangeNotifier {
  NavBarIndex currentIndex = currentNavBarIndex;
  NavBarIndex get index => currentIndex;

  void setPageIndex(int newIndex) {
    currentIndex.pageIndex = newIndex;
    notifyListeners();
  }

  void setTopicIndex(int newIndex) {
    currentIndex.selectedTopicIndex = newIndex;
    notifyListeners();
  }

  int getTopicIndex() {
    return currentIndex.selectedTopicIndex;
  }
}
