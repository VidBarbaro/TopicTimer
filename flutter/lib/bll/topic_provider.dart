import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topictimer_flutter_application/components/mobile/models/topic_model.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/bluetooth_info_provider.dart';

class TopicProvider with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static final List<TopicModel> _topicList =
      List<TopicModel>.empty(growable: true);

  TopicProvider() {}

  void checkLocalStorage() async {
    final SharedPreferences prefs = await _prefs;

    // Try reading data from the 'topics' key. If it doesn't exist, returns null.
    final List<String>? topics = prefs.getStringList('topics');

    topics?.forEach((topic) {
      createTopicFromJsonString(topic);
    });
  }

  Future<bool> _saveToLocalStorage(TopicModel topic) async {
    final SharedPreferences prefs = await _prefs;

    List<String> topics = List<String>.empty(growable: true);
    List<String>? storedTopics = prefs.getStringList('topics');
    if (storedTopics != null) topics = storedTopics;

    topics.add(topic.toJson().toString());

    prefs.setStringList('topics', topics);

    return true;
  }

  TopicModel getTopicById(String id) =>
      _topicList.firstWhere((topic) => topic.id == id);

  static List<TopicModel> getTopics() {
    return _topicList;
  }

  void createTopic(TopicModel topic, {bool saveToLocal = true}) {
    _topicList.add(topic);
    BluetoothInfoProvider.sendTopic(-1, _topicList);
    if (saveToLocal) _saveToLocalStorage(topic);
    notifyListeners();
  }

  void createTopicFromJsonString(String topicJsonString) {
    Map<String, dynamic> jsonObject = jsonDecode(topicJsonString);
    Color c = Color(jsonObject['color']);

    TopicModel newTopic = TopicModel.withId(
        id: jsonObject['id'], name: jsonObject['name'], color: c);

    createTopic(newTopic, saveToLocal: false);
  }

  void deleteTopicFromLocal(String id) async {
    final SharedPreferences prefs = await _prefs;
    List<String>? storedTopics = prefs.getStringList('topics');

    for (int i = 0; i < storedTopics!.length; i++) {
      Map<String, dynamic> jsonObject = jsonDecode(storedTopics[i]);
      if (jsonObject['id'] == id) {
        storedTopics.remove(storedTopics[i]);
      }
    }
    if (storedTopics == null) {
      return;
    }

    prefs.setStringList('topics', storedTopics);
  }

  void deleteTopic(String id) {
    int indexToRemove =
        _topicList.indexWhere((topicitem) => topicitem.id == id);
    _topicList.removeAt(indexToRemove);
    BluetoothInfoProvider.sendRemoveTopic(index: indexToRemove);
    deleteTopicFromLocal(id);

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
