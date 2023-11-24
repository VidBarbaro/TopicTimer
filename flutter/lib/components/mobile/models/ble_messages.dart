import 'package:flutter/material.dart';
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

//Get message used for asking a command from the watch (GetTime & GetTopics)
class GetMessage {
  String _command = 'None'; //getTime OR getTopics
  String get command => _command;

  GetMessage({required command}) {
    _command = command;
  }

  Map<String, dynamic> toJson() => {'command': _command};
}

class TopicData {
  int _id = 0;
  int get id => _id;

  DateTimeJSON _beginTime = DateTimeJSON(
      time: Time(hours: 0, minutes: 0, seconds: 0),
      date: Date(years: 0, months: 0, days: 0));

  DateTimeJSON get beginTime => _beginTime;
  DateTimeJSON _endTime = DateTimeJSON(
      time: Time(hours: 0, minutes: 0, seconds: 0),
      date: Date(years: 0, months: 0, days: 0));
  DateTimeJSON get endTime => _endTime;

  TopicData(
      {required id,
      required DateTimeJSON beginTime,
      required DateTimeJSON endTime}) {
    _id = id;
    _beginTime = beginTime;
    _endTime = endTime;
  }

  Map<String, dynamic> toJson() => {
        'id': _id,
        'beginTime:': _beginTime.toJson(),
        'endTime': _endTime.toJson()
      };
}

class SetTrackedTimes {
  final String _command = 'setTrackedTimes';
  String get command => _command;
  TopicData _data = TopicData(
      id: 0,
      beginTime: DateTimeJSON(
          time: Time(hours: 0, minutes: 0, seconds: 0),
          date: Date(years: 0, months: 0, days: 0)),
      endTime: DateTimeJSON(
          time: Time(hours: 0, minutes: 0, seconds: 0),
          date: Date(years: 0, months: 0, days: 0)));

  SetTrackedTimes({required TopicData data}) {
    _data = data;
  }
  Map<String, dynamic> toJson() =>
      {'command': _command, 'data': _data.toJson()};
}

class SetTopics {
  final String _command = 'setTopics';
  String get command => _command;
  TopicModel _topic = TopicModel('None', Colors.black);

  SetTopics({required TopicModel topic}) {
    _topic = topic;
  }

  Map<String, dynamic> toJson() =>
      {'command': _command, 'data': _topic.toJson()};
}
