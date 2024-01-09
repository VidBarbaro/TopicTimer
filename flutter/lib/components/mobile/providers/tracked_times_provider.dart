import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/mobile/models/ble_messages.dart';

class TrackedTimesProvider with ChangeNotifier {
  static final List<TopicData> _trackedTimes = List<TopicData>.empty(growable: true);
  List<TopicData> get trackedTimes => _trackedTimes;

  List<TopicData> getTrackTimes() {
    return _trackedTimes;
  }

  List<TopicData> getTrackedTimesOnTopicId(int topicID) {
    return _trackedTimes
        .where((data) => topicID.toString() == data.id)
        .toList();
  }

  List<TopicData> getTrackedTimesOnDate(Date date) {
    return _trackedTimes
        .where((data) =>
            date.day == data.endTime.date.day &&
            date.month == data.endTime.date.month &&
            date.year == data.endTime.date.year)
        .toList();
  }

  int getAmountOfTimes() {
    return _trackedTimes.length;
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
      if (topicID.toString() == _trackedTimes[i].id) {
        _trackedTimes.removeAt(i);
      }
    }
    return true;
  }
}
