import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/mobile/history_calendar.dart';
import 'package:topictimer_flutter_application/components/mobile/planning_calendar.dart';
import 'package:topictimer_flutter_application/components/mobile/topbar.dart';

class MobilePlanningPage extends StatefulWidget {
  @override
  _MobilePlanningPageState createState() => _MobilePlanningPageState();
}

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
}
