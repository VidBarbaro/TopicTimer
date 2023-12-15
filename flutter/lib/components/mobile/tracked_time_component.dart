import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topictimer_flutter_application/components/mobile/models/ble_messages.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/tracked_times_provider.dart';

class TrackedTime extends StatelessWidget {
  final String topicId;
  final DateTimeJSON beginTime;
  final DateTimeJSON endTime;

  const TrackedTime(
      {super.key,
      required this.topicId,
      required this.beginTime,
      required this.endTime});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(topicId),
        Text(beginTime.toString()),
        Text(endTime.toString())
      ],
    );
  }
}
