import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/topbar_content_provider.dart';

class TopBar extends StatelessWidget {
  TopBar({super.key});
  void addTopic() {}
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
                if (context.read<TopBarConentProvider>().getSelectedPage() ==
                    'Timer')
                  ElevatedButton(
                    onPressed: () =>
                        context.read<TopBarConentProvider>().switchTopicLeft(),
                    style: topBarButtonStyle,
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                if (context.read<TopBarConentProvider>().getSelectedPage() ==
                    'Topics')
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
                  child: Consumer<TopBarConentProvider>(
                    builder: (context, topBarConentProvider, child) {
                      if (context
                              .read<TopBarConentProvider>()
                              .getSelectedPage() ==
                          'Timer') {
                        return Text(
                          topBarConentProvider.getSelectedTopic().name,
                          style: TextStyle(fontSize: 5.w),
                        );
                      } else {
                        return Text(
                          topBarConentProvider.getSelectedPage(),
                          style: TextStyle(fontSize: 5.w),
                        );
                      }
                    },
                  ),
                ),
                if (context.read<TopBarConentProvider>().getSelectedPage() ==
                    'Timer')
                  ElevatedButton(
                      onPressed: () => context
                          .read<TopBarConentProvider>()
                          .switchTopicRight(),
                      style: topBarButtonStyle,
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      )),
                if (context.read<TopBarConentProvider>().getSelectedPage() ==
                    'Topics')
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
