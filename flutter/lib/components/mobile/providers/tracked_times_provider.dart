import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/mobile/models/ble_messages.dart';

class TrackedTimesProvider with ChangeNotifier {
  List<TopicData> _trackedTimes = List<TopicData>.empty();

  List<TopicData> getTrackedTimes(int topicID) {
    List<TopicData> gatheredData = List<TopicData>.empty();
    for (int i = 0; i < _trackedTimes.length; i++) {
      if (topicID == _trackedTimes[i].id) {
        gatheredData.add(_trackedTimes[i]);
      }
    }
    notifyListeners();
    return gatheredData;
  }

  bool addTrackedTime(TopicData newData) {
    if (newData.beginTime.toString().isNotEmpty &&
        newData.endTime.toString().isNotEmpty) {
      _trackedTimes.add(newData);
      notifyListeners();
      return true;
    }
    return false;
  }

  ///Deletes all tracked times from specific topicID
  ///Returns TRUE if succesfull OR FALSE if failed
  bool deleteTopicTrackedTimes(int topicID) {
    if (topicID < 0) {
      return false;
    }
    for (int i = 0; i < _trackedTimes.length; i++) {
      if (topicID == _trackedTimes[i].id) {
        _trackedTimes.removeAt(i);
      }
    }
    return true;
  }
}
