import 'package:flutter/material.dart';

class TopicModel {
  TopicModel(this.name, this.color);
  TopicModel.empty();
  UniqueKey id = UniqueKey();
  String name = 'This topic was not initialized correctly';
  Color color = Colors.transparent;

  Map<String, dynamic> toJson() => {
        '"id"': '"$id"',
        '"name"': '"$name"',
        '"colour"': color.value.toString()
      };
}
