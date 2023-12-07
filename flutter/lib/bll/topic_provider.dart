import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/mobile/models/topic_model.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/bluetooth_info_provider.dart';

class TopicProvider with ChangeNotifier {
  static final List<TopicModel> _topicList =
      List<TopicModel>.empty(growable: true);

  TopicProvider();

  TopicModel getTopicById(UniqueKey id) =>
      _topicList.firstWhere((topic) => topic.id == id);

  static List<TopicModel> getTopics() {
    return _topicList;
  }

  void createTopic(TopicModel topic) {
    _topicList.add(topic);
    BluetoothInfoProvider.sendTopic(-1, _topicList);
    notifyListeners();
  }

  void deleteTopic(UniqueKey id) {
    int indexToRemove =
        _topicList.indexWhere((topicitem) => topicitem.id == id);
    _topicList.removeAt(indexToRemove);
    BluetoothInfoProvider.sendRemoveTopic(index: indexToRemove);
    notifyListeners();
  }

  void updateTopic(TopicModel topic) {
    int indexToUpdate =
        _topicList.indexWhere((topicitem) => topicitem.id == topic.id);
    _topicList[indexToUpdate] = topic;
    BluetoothInfoProvider.sendTopic(indexToUpdate, _topicList);
    notifyListeners();
  }
}
