import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topictimer_flutter_application/components/mobile/models/ble_messages.dart';
import 'package:topictimer_flutter_application/components/mobile/planned_goals.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/planning_selected_date_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/tracked_times_provider.dart';

class PlanningCalendarComp extends StatelessWidget {
  Future<void> _selectDate(BuildContext context,
      PlanningSelectedDateProvider selectedDateProvider) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null &&
        (picked.day != selectedDateProvider.get().day ||
            picked.month != selectedDateProvider.get().month ||
            picked.year != selectedDateProvider.get().year)) {
      Date pickedDate =
          Date(year: picked.year, month: picked.month, day: picked.day);
      selectedDateProvider.set(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackedTimesProvider>(
        builder: (context, trackedTimesProvider, child) {
      return Consumer<PlanningSelectedDateProvider>(
          builder: (context, planningSelectedDateProvider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: GestureDetector(
                onTap: () {
                  _selectDate(
                      context, context.read<PlanningSelectedDateProvider>());
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
                        'Selected Date: ${context.read<PlanningSelectedDateProvider>().get().day} - ${context.read<PlanningSelectedDateProvider>().get().month} - ${context.read<PlanningSelectedDateProvider>().get().year}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Change HistoryGraphComp so that it can take a dataList as its parameter
            PlannedGoalsComp(),
          ],
        );
      }
      );
    }
    );
  }
}