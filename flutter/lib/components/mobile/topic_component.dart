import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topictimer_flutter_application/bll/topic_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/models/topic_model.dart';
import 'package:topictimer_flutter_application/theme/custom_color.dart';
import 'package:topictimer_flutter_application/theme/color_provider.dart';

class TopicWidget extends StatefulWidget {
  TopicWidget({super.key, required this.topic, required this.callback});
  TopicModel topic;
  Function() callback;
  @override
  State<TopicWidget> createState() => _TopicWidgetState(topic: topic, callback: callback);
}

class _TopicWidgetState extends State<TopicWidget> {
  _TopicWidgetState({required this.topic, required this.callback});
  TopicModel topic;
  Function() callback;
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
          color: ColorProvider.get(CustomColor.background),
          margin: const EdgeInsets.fromLTRB(0,0,0,10),
          child:
          Column(children: [
           Row(
            children: [
              TextButton(onPressed: (){setState(() {_isVisible = !_isVisible;});}, 
              style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              child: 
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10,10,10,10),
                    width: 15.w,
                    color: topic.color,
                    alignment: Alignment.center,
                    child: Text(topic.name[0], style:  TextStyle(fontSize: 20, color: ColorProvider.get(CustomColor.text)))),
                   Container(
                    width: 60.w,
                    padding: const EdgeInsets.fromLTRB(30,0,0,0),
                    child:  Text(topic.name, style:  TextStyle(fontSize: 20, color: ColorProvider.get(CustomColor.text))))
                ])),
               Row(
                children: [
                  TextButton(onPressed: (){setState(() {_isVisible = !_isVisible;});}, 
                    style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero), tapTargetSize: MaterialTapTargetSize.shrinkWrap, minimumSize: MaterialStatePropertyAll(Size.zero)),
                    child: Padding(padding: const EdgeInsets.fromLTRB(10,0,10,0), child: Icon(Icons.edit, color: ColorProvider.get(CustomColor.text)))),
                  TextButton(onPressed: (){setState(() {TopicProvider.deleteTopic(topic.id); callback();});}, 
                    style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero), tapTargetSize: MaterialTapTargetSize.shrinkWrap, minimumSize: MaterialStatePropertyAll(Size.zero)),
                    child:Padding(padding: const EdgeInsets.fromLTRB(10,0,10,0), child: Icon(Icons.delete, color: ColorProvider.get(CustomColor.text))))
                ],)
                
            ],
          ),
           Visibility(
            visible: _isVisible,
            child: 
            Padding(
                    padding: const EdgeInsets.fromLTRB(30,10,30,10),
                    child:  Text('Additional Topic information is displayed here', style:  TextStyle(fontSize: 15, color: ColorProvider.get(CustomColor.text)))))
          ])
        );
  }
}
