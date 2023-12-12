import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/mobile/models/bar_data.dart';
import 'package:topictimer_flutter_application/pages/mobile/history_graph.dart';

class HistoryCalendarComp extends StatefulWidget {
  @override
  _HistoryCalendarCompState createState() => _HistoryCalendarCompState();
}

class _HistoryCalendarCompState extends State<HistoryCalendarComp> {
  DateTime selectedDate = DateTime.now();

  List<BarData> myDataList = [
    const BarData(Colors.yellow, 18, 18, 'Mat'),
    const BarData(Colors.green, 17, 8, 'Bio'),
    const BarData(Colors.orange, 10, 15, 'Che'),
    // Add more data items as needed...
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
    }
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
