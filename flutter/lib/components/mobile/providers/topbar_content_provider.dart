import 'package:flutter/material.dart';

class Topic {
  int _id = 0;
  int get id => _id;
  Color _color = Colors.transparent;
  Color get color => _color;
  String _name = 'No name';
  String get name => _name;

  Topic({required int id, required String name, required Color color}) {
    _id = id;
    _name = name;
    _color = color;
  }

  Map<String, dynamic> toJson() => {'id': _id, 'name': _name, 'colour': _color};
}

class TopBarConentProvider with ChangeNotifier {
  int _pageIndex = 2;
  int _selectedTopicIndex = 1;

  List<Topic> topics = [
    Topic(id: 1, name: 'Math', color: Colors.red),
    Topic(id: 2, name: 'English', color: Colors.orange),
    Topic(id: 3, name: 'Dutch', color: Colors.blue),
    Topic(id: 4, name: 'Biology', color: Colors.green)
  ];

  void setPageIndex(int newIndex) {
    _pageIndex = newIndex;
    notifyListeners();
  }

  ///Returns the new topic
  void switchTopicLeft() {
    if (topics.isEmpty) {
      throw Exception('No topics initiased');
    }
    _selectedTopicIndex--;
    if (_selectedTopicIndex < 0) {
      _selectedTopicIndex = topics.length - 1;
    }
    notifyListeners();
  }

  void switchTopicRight() {
    if (topics.isEmpty) {
      throw Exception('No topics initiased');
    }
    _selectedTopicIndex++;
    if (_selectedTopicIndex == topics.length) {
      _selectedTopicIndex = 0;
    }
    notifyListeners();
  }

  Topic getSelectedTopic() => topics[_selectedTopicIndex];

  List<Topic> getTopics() => topics;

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
