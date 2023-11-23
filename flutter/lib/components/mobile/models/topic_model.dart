import 'package:flutter/material.dart';

class TopicModel {
TopicModel(this.id, this.name, this.color);
int id = -1;
String name = 'This topic was not initialized correctly';
Color color = Colors.transparent;

Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'colour': color.value.toString()};
}