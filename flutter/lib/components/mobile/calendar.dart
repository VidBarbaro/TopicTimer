import 'package:flutter/material.dart';
import 'package:calendar_picker/calendar_picker.dart';

class CalendarComp extends StatelessWidget {
  CalendarComp({super.key});

@override
  Widget build(BuildContext context) {
    return Container(
          child: MaterialButton(
            color: Colors.blue,
            onPressed: () {
              showCustomCalendarPicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 30)),
                excluded: [
                  DateTime.now().add(const Duration(days: 2)),
                  DateTime.now().add(const Duration(days: 5)),
                  DateTime.now().subtract(const Duration(days: 5)),
                ],
                onSelected: (date) {
                  print("date $date");
                },
              );
            },
            child: const Text(
              "calendar picker",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
  }
}