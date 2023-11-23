import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/mobile/models/topic_model.dart';

class TopicProvider{
  static  List<TopicModel> topiclist = [
    TopicModel(0,'Software', Colors.red),
    TopicModel(1,'Technology', Colors.green),
    TopicModel(2, 'Research', Colors.orange),
    TopicModel(3, 'Meeting', Colors.blue)];

  static List<TopicModel> getTopics() => topiclist;
  void createTopic(TopicModel topic) => topiclist.add(topic);
  void deleteTopic(int id) => topiclist.removeWhere((topic) => topic.id == id);
  void updateTopic(TopicModel topic){
    deleteTopic(topic.id);
    createTopic(topic); 
    }

}