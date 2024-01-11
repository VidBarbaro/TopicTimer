import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topictimer_flutter_application/components/mobile/history_calendar.dart';
import 'package:topictimer_flutter_application/components/mobile/models/bar_data.dart';
import 'package:topictimer_flutter_application/components/mobile/planning_calendar.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/planning_selected_view_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/tracked_times_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/topbar.dart';
import 'package:topictimer_flutter_application/components/mobile/tracked_time_component.dart';

class MobilePlanningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TrackedTimesProvider>(
        builder: (context, trackedTimesProvider, child) {
      return Consumer<PlanningSelectedViewProvider>(
          builder: (context, planningSelectedViewProvider, child) {
        return Column(
          children: [
            const TopBar(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Button to toggle the visibility of the component
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<PlanningSelectedViewProvider>()
                          .toggle(); // Call the function to toggle visibility
                    },
                    child: Text(
                        context.read<PlanningSelectedViewProvider>().get()
                            ? 'History calendar'
                            : 'Planning calendar'),
                  ),
                  SizedBox(height: 10),
                  // Conditional rendering of the component based on state
                  if (context.read<PlanningSelectedViewProvider>().get())
                    PlanningCalendarComp()
                  else
                    HistoryCalendarComp()
                ],
              ),
            ),
          ],
        );
      }
      );
    }
    );
  }
}
