import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/navbar_index_provider.dart';

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

  String getTitle(int currentTab) {
    switch (currentTab) {
      case 0:
        return 'Topics';
      case 1:
        return 'Planning';
      case 2:
        return options[currentTopicIndex];
      case 3:
        return 'Personal';
      case 4:
        return 'Settings';
    }
    return '';
  }

  final ButtonStyle topBarButtonStyle =
      ElevatedButton.styleFrom(backgroundColor: Colors.white);

  @override
  Widget build(BuildContext context) {
    var currentTabIndex = context.watch<NavBarIndexProvider>().currentIndex;
    return Column(children: [
      Container(
          width: 100.w,
          height: 12.h,
          color: Colors.blue,
          child: Wrap(
              alignment: WrapAlignment.spaceAround,
              runAlignment: WrapAlignment.center,
              children: [
                if (currentTabIndex.index == 2)
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
                  child: Text(getTitle(currentTabIndex.index)),
                ),
                if (currentTabIndex.index == 2)
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
