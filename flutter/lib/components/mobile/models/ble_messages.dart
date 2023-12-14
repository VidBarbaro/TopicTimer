import 'package:topictimer_flutter_application/bll/topic_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/models/topic_model.dart';

//For sending BLE messages a JSON object is needed,
//In this file all JSON objects are mentioned

class Time {
  int _hour = 0;
  int get hour => _hour;
  int _minute = 0;
  int get minute => _minute;
  int _second = 0;
  int get second => _second;

  void setHour(int h) {
    if (h > 0) {
      _hour = h;
    }
  }

  void setMinute(int m) {
    if (m > 0) {
      _minute = m;
    }
  }

  void setSecond(int s) {
    if (s > 0) {
      _second = s;
    }
  }

  Time({required hour, required minute, required second}) {
    _hour = hour;
    _minute = minute;
    _second = second;
  }

  Time.empty() {
    _hour = 0;
    _minute = 0;
    _second = 0;
  }

  Map<String, dynamic> toJson() =>
      {'"hour"': _hour, '"minute"': _minute, '"second"': _second};
}

class Date {
  int _year = 0;
  int get year => _year;
  int _month = 0;
  int get month => _month;
  int _day = 0;
  int get day => _day;

  void setYear(int y) {
    if (y > 0) {
      _year = y;
    }
  }

  void setMonth(int m) {
    if (m > 0) {
      _month = m;
    }
  }

  void setDay(int d) {
    if (d > 0) {
      _day = d;
    }
  }

  Date({required year, required month, required day}) {
    _year = year;
    _month = month;
    _day = day;
  }

  Date.empty() {
    _year = 0;
    _month = 0;
    _day = 0;
  }

  Map<String, dynamic> toJson() =>
      {'"year"': _year, '"month"': _month, '"day"': _day};
}

class DateTimeJSON {
  Time _time = Time(hour: 0, minute: 0, second: 0);
  Time get time => _time;
  Date _date = Date(year: 0, month: 0, day: 0);
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
        hour: DateTime.now().hour,
        minute: DateTime.now().minute,
        second: DateTime.now().second);
    _date = Date(
        day: DateTime.now().day,
        month: DateTime.now().month,
        year: DateTime.now().year);
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
      time: Time(hour: 0, minute: 0, second: 0),
      date: Date(year: 0, month: 0, day: 0));
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
  String _id = '_';
  String get id => _id;

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
    _id = '_';
    _beginTime = DateTimeJSON.empty();
    _endTime = DateTimeJSON.empty();
  }

  TopicData.fromJson(Map<String, dynamic> json) {
    json['topic']['id'] = _id;
    _beginTime._time.setHour(json['beg']['t']['h']);
    _beginTime._time.setMinute(json['beg']['t']['m']);
    _beginTime._time.setSecond(json['beg']['t']['s']);
    _beginTime._date.setYear(json['beg']['d']['Y']);
    _beginTime._date.setMonth(json['beg']['d']['M']);
    _beginTime._date.setDay(json['beg']['d']['D']);

    _endTime._time.setHour(json['end']['t']['h']);
    _endTime._time.setMinute(json['end']['t']['m']);
    _endTime._time.setSecond(json['end']['t']['s']);
    _endTime._date.setYear(json['end']['d']['Y']);
    _endTime._date.setMonth(json['end']['d']['M']);
    _endTime._date.setDay(json['end']['d']['D']);
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
