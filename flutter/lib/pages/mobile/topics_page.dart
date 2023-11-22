import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/bll/topic_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/models/topic_model.dart';
import 'package:topictimer_flutter_application/components/mobile/topbar.dart';
import 'package:topictimer_flutter_application/components/mobile/topic_component.dart';

class MobileTopicsPage extends StatelessWidget {
  MobileTopicsPage({super.key});
List<TopicModel> topiclist = TopicProvider.getTopics();
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar(
          key: super.key,
        ),
        for(var topic in topiclist) TopicWidget(topic: topic)
      ],
    );
  }
}




