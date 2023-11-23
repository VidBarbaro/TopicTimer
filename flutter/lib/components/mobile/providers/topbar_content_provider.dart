import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/bll/topic_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/models/topic_model.dart';




class TopBarConentProvider with ChangeNotifier {
  int _pageIndex = 2;
  int _selectedTopicIndex = 0;

  List<TopicModel> topics = TopicProvider.getTopics();

  void setPageIndex(int newIndex) {
    _pageIndex = newIndex;
    _selectedTopicIndex = 0;
    notifyListeners();
  }

  ///Returns the new topic
  void switchTopicLeft() {
    if (topics.isNotEmpty) {
    _selectedTopicIndex--;
    if (_selectedTopicIndex < 0) {
      _selectedTopicIndex = topics.length - 1;
    }
    notifyListeners();
  }}

  void switchTopicRight() {
    if (topics.isNotEmpty) {
     _selectedTopicIndex++;
    if (_selectedTopicIndex == topics.length) {
      _selectedTopicIndex = 0;
    }
    notifyListeners();
  }
      }

  TopicModel getSelectedTopic() {
    if(topics.isNotEmpty){
    return topics[_selectedTopicIndex];
  }
  return TopicModel(-1,'Timer',Colors.transparent);
  }
  
  List<TopicModel> getTopics()  => topics;

  String getSelectedPage() {
    switch (_pageIndex) {
      case 0:
        return 'Topics';
      case 1:
        return 'Planning';
      case 2:
        return 'Timer';
      case 3:
        return 'Personal';
      case 4:
        return 'Settings';
      default:
        return 'Timer';
    }
  }
}
