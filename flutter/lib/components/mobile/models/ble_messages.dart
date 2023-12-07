import 'package:topictimer_flutter_application/bll/topic_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/models/topic_model.dart';

//For sending BLE messages a JSON object is needed,
//In this file all JSON objects are mentioned

class Time {
  int _hours = 0;
  int get hours => _hours;
  int _minutes = 0;
  int get minutes => _minutes;
  int _seconds = 0;
  int get seconds => _seconds;

  Time({required hours, required minutes, required seconds}) {
    _hours = hours;
    _minutes = minutes;
    _seconds = seconds;
  }

  Time.empty() {
    _hours = 0;
    _minutes = 0;
    _seconds = 0;
  }

  Map<String, dynamic> toJson() =>
      {'"hours"': _hours, '"minutes"': _minutes, '"seconds"': _seconds};
}

class Date {
  int _years = 0;
  int get years => _years;
  int _months = 0;
  int get months => _months;
  int _days = 0;
  int get days => _days;

  Date({required years, required months, required days}) {
    _years = years;
    _months = months;
    _days = days;
  }

  Date.empty() {
    _years = 0;
    _months = 0;
    _days = 0;
  }

  Map<String, dynamic> toJson() =>
      {'"year"': _years, '"month"': _months, '"day"': _days};
}

class DateTimeJSON {
  Time _time = Time(hours: 0, minutes: 0, seconds: 0);
  Time get time => _time;
  Date _date = Date(years: 0, months: 0, days: 0);
  Date get date => _date;

  DateTimeJSON({required time, required date}) {
    _time = time;
    _date = date;
  }

  DateTimeJSON.empty() {
    _time = Time.empty();
    _date = Date.empty();
  }

  DateTimeJSON.now() {
    _time = Time(
        hours: DateTime.now().hour,
        minutes: DateTime.now().minute,
        seconds: DateTime.now().second);
    _date = Date(
        days: DateTime.now().day,
        months: DateTime.now().month,
        years: DateTime.now().year);
  }

  setTime(Time newTime) {
    _time = newTime;
  }

  Map<String, dynamic> toJson() =>
      {'"time"': _time.toJson(), '"date"': _date.toJson()};
}

//Phone to watch (SetTime)
class SetTimeMessage {
  final String _command = '"setTime"';
  String get command => _command;
  DateTimeJSON _data = DateTimeJSON(
      time: Time(hours: 0, minutes: 0, seconds: 0),
      date: Date(years: 0, months: 0, days: 0));
  DateTimeJSON get data => _data;

  SetTimeMessage({required Time time, required Date date}) {
    _data = DateTimeJSON(time: time, date: date);
  }
  Map<String, dynamic> toJson() => {
        '"command"': _command,
        '"data"': _data.toJson(),
      };
}

class TopicData {
  int _id = 0;
  int get id => _id;

  DateTimeJSON _beginTime = DateTimeJSON.empty();
  DateTimeJSON get beginTime => _beginTime;
  DateTimeJSON _endTime = DateTimeJSON.empty();
  DateTimeJSON get endTime => _endTime;

  TopicData(
      {required id,
      required DateTimeJSON beginTime,
      required DateTimeJSON endTime}) {
    _id = id;
    _beginTime = beginTime;
    _endTime = endTime;
  }

  TopicData.empty() {
    _id = 0;
    _beginTime = DateTimeJSON.empty();
    _endTime = DateTimeJSON.empty();
  }

  Map<String, dynamic> toJson() => {
        '"id"': _id,
        '"beginTime:"': _beginTime.toJson(),
        '"endTime"': _endTime.toJson()
      };
}

class SetTrackedTimes {
  final String _command = '"setTrackedTimes"';
  String get command => _command;
  TopicData _data = TopicData(
      id: 0, beginTime: DateTimeJSON.empty(), endTime: DateTimeJSON.empty());

  SetTrackedTimes({required TopicData data}) {
    _data = data;
  }
  Map<String, dynamic> toJson() =>
      {'"command"': _command, '"data"': _data.toJson()};
}

class AddTopicMessage {
  String _command = '';
  AddTopicMessage? _secondMessage;
  AddTopicMessage? get secondMessage => _secondMessage;
  String get command => _command;
  int _index = -1;
  TopicModel _topic = TopicModel.empty();

  AddTopicMessage.all({index = 0, required List<TopicModel> topicList}) {
    _command = '"addTopic"';
    if (topicList.length - 1 == index) {
    } else {
      _secondMessage =
          AddTopicMessage.all(index: index + 1, topicList: topicList);
    }
    _topic = topicList[index];
  }

  AddTopicMessage.basedOnIndex(
      {required int index, required List<TopicModel> topicList}) {
    _command = '"addTopic"';
    _index = index;
    if (topicList.isEmpty) {
      return;
    }
    _topic = index == -1 ? topicList[topicList.length - 1] : topicList[index];
  }
  Map<String, dynamic> toJson() =>
      {'"command"': _command, '"index"': _index, '"data"': _topic.toJson()};
}

class RemoveTopicMessage {
  final String _command = '"removeTopic"';
  int _index = -1;

  RemoveTopicMessage({required int index}) {
    if (index < 0) {
      return;
    }
    _index = index;
  }

  Map<String, dynamic> toJson() => {'"command"': _command, '"index"': _index};
}

class RemoveAllTopicsMessage {
  final String _command = '"removeAllTopics"';

  Map<String, dynamic> toJson() => {'"command"': _command};
}
