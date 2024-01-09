import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topictimer_flutter_application/components/mobile/models/ble_messages.dart';
import 'package:topictimer_flutter_application/components/mobile/planned_goals.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/tracked_times_provider.dart';

class PlanningCalendarComp extends StatefulWidget {
  @override
  _PlanningCalendarCompState createState() => _PlanningCalendarCompState();
}

class _PlanningCalendarCompState extends State<PlanningCalendarComp> {
  Date selectedDate = Date(day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year);

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
    }
  }

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
          PlannedGoalsComp(dataList: context.read<TrackedTimesProvider>().getTrackedTimesOnDate(selectedDate)),
          
        ],
      );
      }
    );
  }
}