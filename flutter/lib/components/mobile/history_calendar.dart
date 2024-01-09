import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/mobile/models/bar_data.dart';
import 'package:topictimer_flutter_application/components/mobile/models/ble_messages.dart';
import 'package:topictimer_flutter_application/components/mobile/history_graph.dart';

class HistoryCalendarComp extends StatefulWidget {
  @override
  _HistoryCalendarCompState createState() => _HistoryCalendarCompState();
}

class _HistoryCalendarCompState extends State<HistoryCalendarComp> {
  DateTime selectedDate = DateTime.now();

  List<BarData> myDataList = [
    BarData(Colors.yellow, 10, 18, 'Mat', DateTime(2023, 12, 12)),
    BarData(Colors.green, 10, 8, 'Bio', DateTime(2023, 12, 11)),
    BarData(Colors.orange, 10, 15, 'Che', DateTime(2023, 12, 10)),
    // Add more data items as needed...
  ];

  List<BarData> newDataList = [
    BarData(Colors.yellow, 17, 18, 'Mat', DateTime(2023, 12, 12)),
    BarData(Colors.green, 15, 8, 'Bio', DateTime(2023, 12, 11)),
    BarData(Colors.orange, 10, 15, 'Che', DateTime(2023, 12, 10)),
    // Add more data items as needed...
  ];



  List<List<BarData>> dataList = [
    [
      BarData(Colors.yellow, 10, 18, 'Mat', DateTime(2023, 12, 10)),
      BarData(Colors.green, 10, 8, 'Bio', DateTime(2023, 12, 10)),
      BarData(Colors.orange, 10, 15, 'Che', DateTime(2023, 12, 10)),
    ],
    [
      BarData(Colors.yellow, 17, 18, 'Mat', DateTime(2023, 12, 11)),
      BarData(Colors.green, 15, 8, 'Bio', DateTime(2023, 12, 11)),
      BarData(Colors.orange, 10, 15, 'Che', DateTime(2023, 12, 11)),
    ]
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      updateDataList(newDataList, selectedDate);
    }
  }

  void updateDataList(List<BarData> newDataList, DateTime selectedDate) {
    DateTime targetDate = selectedDate; // Replace this with your target date
    newDataList.clear();
    for (var outerList in dataList) {
      for (var item in outerList) {
        if (item.date.isAtSameMomentAs(targetDate)) {
          // Perform actions if the date matches the target date
          newDataList.add(item);
        }
      }
    }
    print(newDataList);
    setState(() {
      myDataList = newDataList;
  });
  }

  @override
  Widget build(BuildContext context) {
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
                    'Selected Date: ${selectedDate.toString().substring(0, 10)}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        // Change HistoryGraphComp so that it can take a dataList as its parameter
        HistoryGraphComp(dataList: myDataList,),
      ],
    );
  }
}
