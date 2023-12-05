import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/mobile/models/topic_model.dart';

class TopicProvider {
  static List<TopicModel> topiclist = [
    TopicModel('Software', Colors.red),
    TopicModel('Technology', Colors.green),
    TopicModel('Research', Colors.orange),
    TopicModel('Meeting', Colors.blue)
  ];

  static List<TopicModel> getTopics() {
    return topiclist;
  }

  static TopicModel getTopicById(UniqueKey id) => topiclist.firstWhere((topic) => topic.id == id);
  static void createTopic(TopicModel topic) => topiclist.add(topic);
  static void deleteTopic(UniqueKey id) => topiclist.removeWhere((topic) => topic.id == id);
  static void updateTopic(TopicModel topic) => topiclist[topiclist.indexWhere((topicitem) => topicitem.id == topic.id)] = topic;
}
