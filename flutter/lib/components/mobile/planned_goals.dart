import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/mobile/models/topic_goals_data.dart';

class PlannedGoalsComp extends StatefulWidget {
  final List<TopicGoals> dataList;

  const PlannedGoalsComp({
    Key? key,
    required this.dataList,
  }) : super(key: key);

  @override
  State<PlannedGoalsComp> createState() => _PlannedGoalsCompState();
}

class _PlannedGoalsCompState extends State<PlannedGoalsComp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SizedBox(
        height: 300, // Adjust this height as needed
        child: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.dataList.map((goal) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(goal.topic),
                      subtitle: Text(
                        'Date: ${goal.date.toString()} \nDuration: ${goal.duration.toStringAsFixed(2)} minutes',
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
}
