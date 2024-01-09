import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topictimer_flutter_application/components/mobile/models/bar_data.dart';
import 'package:topictimer_flutter_application/components/mobile/models/ble_messages.dart';
import 'package:topictimer_flutter_application/components/mobile/models/topic_goals_data.dart';
import 'package:topictimer_flutter_application/components/mobile/history_graph.dart';
import 'package:topictimer_flutter_application/components/mobile/planned_goals.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/tracked_times_provider.dart';

class PlanningCalendarComp extends StatefulWidget {
  @override
  _PlanningCalendarCompState createState() => _PlanningCalendarCompState();
}

class _PlanningCalendarCompState extends State<PlanningCalendarComp> {
  Date selectedDate = Date(day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year);

  List<TopicGoals> myDataList = [
    TopicGoals("Math", DateTime(2023, 12, 12), 60),
    TopicGoals("Biology", DateTime(2023, 12, 12), 45),
    TopicGoals("Chemistry", DateTime(2023, 12, 12), 30),
  ];

  List<TopicGoals> newDataList = [
    TopicGoals("Math", DateTime(2023, 12, 12), 60),
    TopicGoals("Biology", DateTime(2023, 12, 12), 45),
    TopicGoals("Chemistry", DateTime(2023, 12, 12), 30),
  ];



  List<List<TopicGoals>> dataList = [
    [
      TopicGoals("PE", DateTime(2023, 12, 12), 30),
      TopicGoals("Software", DateTime(2023, 12, 12), 55),
      TopicGoals("Technology", DateTime(2023, 12, 12), 10),
    ],
    [
      TopicGoals("Break", DateTime(2023, 12, 12), 70),
      TopicGoals("Infrastructure", DateTime(2023, 12, 12), 95),
      TopicGoals("Chemistry", DateTime(2023, 12, 12), 5),
    ]
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate.setDay(picked.day);
        selectedDate.setMonth(picked.month);
        selectedDate.setYear(picked.year);
      });
      // updateDataList(newDataList, selectedDate);
    }
  }

  // void updateDataList(List<TopicGoals> newDataList, Date selectedDate) {
  //   DateTime targetDate = selectedDate; // Replace this with your target date
  //   newDataList.clear();
  //   for (var outerList in dataList) {
  //     for (var item in outerList) {
  //       if (item.date.isAtSameMomentAs(targetDate)) {
  //         // Perform actions if the date matches the target date
  //         newDataList.add(item);
  //       }
  //     }
  //   }
  //   print(newDataList);
  //   setState(() {
  //     myDataList = newDataList;
  // });
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackedTimesProvider>(
      builder: (context, trackedTimesProvider, child) {
        return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.calendar_today),
                    SizedBox(width: 8.0),
                    Text(
                      'Selected Date: ${selectedDate.day} - ${selectedDate.month} - ${selectedDate.year}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 0),
          // Change HistoryGraphComp so that it can take a dataList as its parameter
          // HistoryGraphComp(dataList: myDataList,),
          PlannedGoalsComp(dataList: context.read<TrackedTimesProvider>().getTrackedTimesOnDate(selectedDate)),
          
        ],
      );
      }
    );
  }
}