import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/mobile/models/topic_model.dart';

class TopicProvider{
  static  List<TopicModel> topiclist = [
    TopicModel(0,'Math', Colors.red),
    TopicModel(1,'Biology', Colors.green),
    TopicModel(2, 'English', Colors.orange),
    TopicModel(3, 'Dutch', Colors.blue)];

  static List<TopicModel> getTopics() => topiclist;
  void createTopic(TopicModel topic) => topiclist.add(topic);
  void deleteTopic(int id) => topiclist.removeWhere((topic) => topic.id == id);
  void updateTopic(TopicModel topic){
    deleteTopic(topic.id);
    createTopic(topic); 
    }

}