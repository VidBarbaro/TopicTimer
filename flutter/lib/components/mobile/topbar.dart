import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => TopBarState();
}

class TopBarState extends State<TopBar> {
  List<String> options = ['Math', 'Biology', 'Sports', 'Gaming'];
  int currentTopicIndex = 0;

  void changeSubjectToLeft() {
    currentTopicIndex--;
    if (currentTopicIndex < 0) {
      currentTopicIndex = 3;
    }
    setState(() {});
  }

  void changeSubjectToRight() {
    currentTopicIndex++;
    if (currentTopicIndex > 3) {
      currentTopicIndex = 0;
    }
    setState(() {});
  }

  final ButtonStyle topBarButtonStyle =
      ElevatedButton.styleFrom(backgroundColor: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          width: 100.w,
          height: 12.h,
          color: Colors.blue,
          child: Wrap(
              alignment: WrapAlignment.spaceAround,
              runAlignment: WrapAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: changeSubjectToLeft,
                  style: topBarButtonStyle,
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                Container(
                    width: 35.w,
                    height: 5.h,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(options[currentTopicIndex])),
                ElevatedButton(
                    onPressed: changeSubjectToRight,
                    style: topBarButtonStyle,
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    )),
              ])),
      Container(
        width: 100.w,
        height: 5.h,
        color: Colors.lightBlue,
        alignment: Alignment.center,
        child: const Wrap(alignment: WrapAlignment.center, children: <Widget>[
          Icon(Icons.watch, color: Colors.white),
          Text(
            'Disconnected',
            style: TextStyle(color: Colors.white, fontSize: 20),
          )
        ]),
      )
    ]);
  }
}
