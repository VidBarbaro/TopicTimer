import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topictimer_flutter_application/components/mobile/history_calendar.dart';
import 'package:topictimer_flutter_application/components/mobile/models/bar_data.dart';
import 'package:topictimer_flutter_application/components/mobile/planning_calendar.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/tracked_times_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/topbar.dart';
import 'package:topictimer_flutter_application/components/mobile/tracked_time_component.dart';

class MobilePlanningPage extends StatefulWidget {
  @override
  _MobilePlanningPageState createState() => _MobilePlanningPageState();
}

List<BarData> myDataList = [
  BarData(Colors.yellow, 10, 10, 'Mat', DateTime(2023, 12, 12)),
  BarData(Colors.green, 13, 8, 'Bio', DateTime(2023, 12, 11)),
  BarData(Colors.orange, 12, 15, 'Che', DateTime(2023, 12, 10)),
  // Add more data items as needed...
];

class _MobilePlanningPageState extends State<MobilePlanningPage> {
  bool showComponent = false;
  String buttonText = 'Planning Calendar';

  void toggleComponent() {
    setState(() {
      // Update the state to toggle the visibility of the component
      showComponent = !showComponent;
      // Change the button text based on the component being shown
      buttonText = showComponent ? 'History Calendar' : 'Planning Calendar';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackedTimesProvider>(
      builder: (context, trackedTimesProvider, child) {
        print(context.read<TrackedTimesProvider>().getTrackTimes());
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
                    toggleComponent(); // Call the function to toggle visibility
                  },
                  child: Text(buttonText),
                ),
                SizedBox(height: 10),
                // Conditional rendering of the component based on state
                if (showComponent)
                  HistoryCalendarComp()
                else
                  PlanningCalendarComp()
              ],
            ),
          ),
        ],
      );
      }
    );
  }
}
