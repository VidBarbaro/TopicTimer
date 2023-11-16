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
      {'hours': _hours, 'minutes': _minutes, 'seconds': _seconds};
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
      {'years': _years, 'months': _months, 'days': _days};
}

class SetTimeData {
  Time _time = Time(hours: 0, minutes: 0, seconds: 0);
  Time get time => _time;
  Date _date = Date(years: 0, months: 0, days: 0);
  Date get date => _date;

  SetTimeData({required time, required date}) {
    _time = time;
    _date = date;
  }

  Map<String, dynamic> toJson() =>
      {'time': _time.toJson(), 'date': _date.toJson()};
}

class SetTimeMessage {
  String _command = 'None';
  String get command => _command;
  SetTimeData _data = SetTimeData(
      time: Time(hours: 0, minutes: 0, seconds: 0),
      date: Date(years: 0, months: 0, days: 0));
  SetTimeData get data => _data;

  SetTimeMessage({required command, required time, required date}) {
    _command = command;
    _data = SetTimeData(time: time, date: date);
  }
  Map<String, dynamic> toJson() => {
        'command': _command,
        'data': _data.toJson(),
      };
}

class GetMessage {
  String _command = 'None';
  String get command => _command;

  GetMessageContent({required command}) {
    _command = command;
  }

  Map<String, dynamic> toJson() => {'command': _command};
}
