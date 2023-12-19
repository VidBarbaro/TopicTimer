import 'package:flutter/material.dart';

class TopicModel {
  TopicModel(this.name, this.color);
  TopicModel.empty();
  TopicModel.withId(
      {required this.id, required this.name, required this.color});
  String id = UniqueKey().toString();
  String name = 'This topic was not initialized correctly';
  Color color = Colors.transparent;

  Map<String, dynamic> toJson() =>
      {'"id"': '"$id"', '"name"': '"$name"', '"color"': color.value.toString()};
}
