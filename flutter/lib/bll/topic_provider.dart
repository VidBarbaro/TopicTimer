import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:topictimer_flutter_application/components/mobile/models/topic_model.dart';

class TopicProvider {
   static List<TopicModel> topiclist = [
    TopicModel('Software', Colors.red),
    TopicModel('Technology', Colors.green),
    TopicModel('Research', Colors.orange),
    TopicModel('Meeting', Colors.blue)];

  static List<TopicModel> getTopics() 
  {

    return topiclist;
    }
  static TopicModel getTopicById(UniqueKey id) => topiclist.firstWhere((topic) => topic.id == id);
  void createTopic(TopicModel topic) => topiclist.add(topic);
  static void deleteTopic(UniqueKey id) => topiclist.removeWhere((topic) => topic.id == id);
  void updateTopic(TopicModel topic){
    deleteTopic(topic.id);
    createTopic(topic); 
    }

}