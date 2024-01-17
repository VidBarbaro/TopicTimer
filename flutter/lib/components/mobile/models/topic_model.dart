import 'package:flutter/material.dart';

class TopicModel {
  TopicModel(this.name, this.color, this.intervalTime, this.intervalPeriod);
  TopicModel.empty();
  TopicModel.withId(
      {required this.id,
      required this.name,
      required this.color,
      required this.intervalTime,
      required this.intervalPeriod});
  String id = UniqueKey().toString();
  String name = 'This topic was not initialized correctly';
  Color color = Colors.transparent;
  String intervalPeriod = 'seconds';
  int intervalTime = 0;

  Map<String, dynamic> toJson() =>
      {
        '"id"': '"$id"',
        '"name"': '"$name"',
        '"color"': color.value.toString(),
        '"intervalTime"': intervalTime,
        '"intervalPeriod"': '"$intervalPeriod"'
      };
}
