import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topictimer_flutter_application/bll/topic_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/topbar_content_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/models/topic_model.dart';
import 'package:topictimer_flutter_application/components/mobile/topbar.dart';
import 'package:topictimer_flutter_application/components/mobile/topic_component.dart';

class MobileTopicsPage extends StatefulWidget {
  const MobileTopicsPage({super.key});

  @override
  State<MobileTopicsPage> createState() => _MobileTopicsPageState();
}

class _MobileTopicsPageState extends State<MobileTopicsPage> {
void callback() => setState(() {topiclist = TopicProvider.getTopics();});
List<TopicModel> topiclist = TopicProvider.getTopics();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar(),
        Column(
           children: [for(var topic in topiclist) TopicWidget(topic: topic, callback: callback)],
        )
      ],
    );
  }
}





