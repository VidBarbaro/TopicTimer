import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topictimer_flutter_application/bll/topic_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/topbar.dart';
import 'package:topictimer_flutter_application/components/mobile/topic_component.dart';

class MobileTopicsPage extends StatelessWidget {
  const MobileTopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TopicProvider>(builder: (context, topicProvider, child) {
      return Column(
        children: [
          const TopBar(),
          if (TopicProvider.getTopics().isNotEmpty)
            Column(
              children: [
                for (var topic in TopicProvider.getTopics())
                  TopicWidget(key: UniqueKey(), topic: topic)
              ],
            )
          else
            Text(
              "It seems like you don't have any topics to display yet",
              style: TextStyle(fontSize: 5.w),
              textAlign: TextAlign.center,
            )
        ],
      );
    });
  }
}
