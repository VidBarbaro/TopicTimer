import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topictimer_flutter_application/components/mobile/models/topic_model.dart';

class TopicWidget extends StatelessWidget {
  TopicWidget({super.key, required this.topic});
  TopicModel topic;

  @override
  Widget build(BuildContext context) {
    return Container(
          color: Colors.white,
          margin: const EdgeInsets.fromLTRB(0,0,0,10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0,10,0,10),
                    width: 10.w,
                    color: topic.color,
                    alignment: Alignment.center,
                    child: Text(topic.name[0], style: const TextStyle(fontSize: 20))),
                   Padding(
                    padding: const EdgeInsets.fromLTRB(30,0,0,0),
                    child:  Text(topic.name, style: const TextStyle(fontSize: 20)))
                ]),
              const Row(
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(10,0,10,0), child: Icon(Icons.edit)),
                  Padding(padding: EdgeInsets.fromLTRB(10,0,10,0), child: Icon(Icons.delete))
                ],)
            ],
          ),
        );
  }
}