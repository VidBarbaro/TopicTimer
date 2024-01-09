import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topictimer_flutter_application/bll/topic_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/models/ble_messages.dart';
import 'package:topictimer_flutter_application/components/mobile/models/topic_goals_data.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/planning_selected_date_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/tracked_times_provider.dart';

class PlannedGoalsComp extends StatelessWidget {
  const PlannedGoalsComp({
    Key? key,
  }) : super(key: key);

  String calculateTimeDifference(TopicData data) {
    // Calculate the total seconds from a DateTimeJSON instance
    int startSeconds = data.beginTime.time.hour * 3600 +
        data.beginTime.time.minute * 60 +
        data.beginTime.time.second;

    int endSeconds = data.endTime.time.hour * 3600 +
        data.endTime.time.minute * 60 +
        data.endTime.time.second;

    int differenceInSeconds = endSeconds - startSeconds;

    // Format the difference into a human-readable string
    String formattedDifference = _formatDuration(differenceInSeconds);

    return formattedDifference;
  }

  String _formatDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int remainingMinutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    List<String> parts = [];

    if (hours > 0) {
      parts.add('$hours ${hours == 1 ? 'hour' : 'hours'}');
    }

    if (remainingMinutes > 0) {
      parts.add('$remainingMinutes ${remainingMinutes == 1 ? 'minute' : 'minutes'}');
    }

    if (remainingSeconds > 0 || parts.isEmpty) {
      parts.add('$remainingSeconds ${remainingSeconds == 1 ? 'second' : 'seconds'}');
    }

    return parts.join(' and ');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackedTimesProvider>(
      builder: (context, trackedTimesProvider, child) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          height: 300, // Adjust this height as needed
          child: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: context
                    .read<TrackedTimesProvider>()
                    .getTrackedTimesOnDate(
                        context.read<PlanningSelectedDateProvider>().get())
                    .map((goal) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      elevation: 2,
                      child: ListTile(
                        title: Text(context.read<TopicProvider>().getTopicById(goal.id).name),
                        subtitle: Text(
                          'Duration: ${calculateTimeDifference(goal)}',
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      );
      }
    );
  }
}
