import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:topictimer_flutter_application/components/mobile/models/navbar_index_model.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/navbar_index_provider.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => TopBarState();
}

class TopBarState extends State<TopBar> {
  void changeSubjectToLeft(NavBarIndex provider) {
    int index = NavBarIndexProvider().getTopicIndex();
    index--;
    if (index < 0) {
      NavBarIndexProvider().setTopicIndex(3);
      setState(() {});
      return;
    }
    NavBarIndexProvider().setTopicIndex(index);
    setState(() {});
  }

  void changeSubjectToRight(NavBarIndex provider) {
    int index = NavBarIndexProvider().getTopicIndex();
    index++;
    if (index > 3) {
      NavBarIndexProvider().setTopicIndex(0);
      setState(() {});
      return;
    }
    NavBarIndexProvider().setTopicIndex(index);
    setState(() {});
  }

  void addTopic() {}

  String getSelectedTopicTitle() {
    switch (NavBarIndexProvider().getTopicIndex()) {
      case 0:
        return 'Math';
      case 1:
        return 'Biology';
      case 2:
        return 'Sports';
      case 3:
        return 'Gaming';
    }
    return '';
  }

  String getTitle(NavBarIndex provider) {
    switch (provider.pageIndex) {
      case 0:
        return 'Topics';
      case 1:
        return 'Planning';
      case 2:
        return getSelectedTopicTitle();
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
    NavBarIndex topBarProvider =
        context.watch<NavBarIndexProvider>().currentIndex;
    return Column(children: [
      Container(
          width: 100.w,
          height: 12.h,
          color: Colors.blue,
          child: Wrap(
              alignment: WrapAlignment.spaceAround,
              runAlignment: WrapAlignment.center,
              children: [
                if (topBarProvider.pageIndex == 2)
                  ElevatedButton(
                    onPressed: () => changeSubjectToLeft(topBarProvider),
                    style: topBarButtonStyle,
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                if (topBarProvider.pageIndex == 0)
                  //Empty button for spacing the topbar
                  TextButton(
                    onPressed: () {},
                    child: const Icon(Icons.abc, color: Colors.blue),
                  ),
                Container(
                  width: 35.w,
                  height: 5.h,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Text(
                    getTitle(topBarProvider),
                  ),
                ),
                if (topBarProvider.pageIndex == 2)
                  ElevatedButton(
                      onPressed: () => changeSubjectToRight(topBarProvider),
                      style: topBarButtonStyle,
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      )),
                if (topBarProvider.pageIndex == 0)
                  ElevatedButton(
                      onPressed: () => addTopic(),
                      style: topBarButtonStyle,
                      child: const Icon(
                        Icons.add,
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
