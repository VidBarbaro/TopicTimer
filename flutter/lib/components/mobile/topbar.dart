import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/bluetooth_info_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/timer_info_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/topbar_content_provider.dart';
import 'package:topictimer_flutter_application/theme/color_provider.dart';
import 'package:topictimer_flutter_application/theme/custom_color.dart';

class TopBar extends StatelessWidget {
  TopBar({super.key});
  void addTopic() {}
  final ButtonStyle topBarButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: ColorProvider.get(CustomColor.background),
      elevation: 5,
      disabledBackgroundColor: ColorProvider.get(CustomColor.primary));
// THINGS TO DISCUSS WITH MICHEL
// the changing of the pages, why dont the two left and right pointer buttons dissapear
// why doesnt the plus button appear on the topics page
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          width: 100.w,
          height: 12.h,
          color: ColorProvider.get(CustomColor.primary),
          child: Wrap(
              alignment: WrapAlignment.spaceAround,
              runAlignment: WrapAlignment.center,
              children: [
                if (context.read<TopBarConentProvider>().getSelectedPage() ==
                    'Timer')
                  Consumer<TimerInfoProvider>(
                      builder: (context, timerInfoProvider, child) {
                    return ElevatedButton(
                      onPressed: timerInfoProvider.isButtonActive
                          ? null
                          : () => context
                              .read<TopBarConentProvider>()
                              .switchTopicLeft(),
                      style: topBarButtonStyle,
                      child: Icon(
                        Icons.arrow_back,
                        color: ColorProvider.get(CustomColor.primary),
                      ),
                    );
                  }),
                if (context.read<TopBarConentProvider>().getSelectedPage() ==
                    'Topics')
                  //Empty button for spacing the topbar
                  TextButton(
                    onPressed: () {},
                    child: Icon(Icons.abc,
                        color: ColorProvider.get(CustomColor.primary)),
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
                  Consumer<TimerInfoProvider>(
                      builder: (context, timerInfoProvider, child) {
                    return ElevatedButton(
                        onPressed: timerInfoProvider.isButtonActive
                            ? null
                            : () => context
                                .read<TopBarConentProvider>()
                                .switchTopicRight(),
                        style: topBarButtonStyle,
                        child: Icon(
                          Icons.arrow_forward,
                          color: ColorProvider.get(CustomColor.primary),
                        ));
                  }),
                if (context.read<TopBarConentProvider>().getSelectedPage() ==
                    'Topics')
                  ElevatedButton(
                      onPressed: () => addTopic(),
                      style: topBarButtonStyle,
                      child: Icon(
                        Icons.add,
                        color: ColorProvider.get(CustomColor.primary),
                      )),
              ])),
      Container(
        width: 100.w,
        height: 5.h,
        color: ColorProvider.get(CustomColor.tertiary),
        alignment: Alignment.center,
        child: Consumer<BluetoothInfoProvider>(
            builder: (context, bluetoothInfoProvider, child) {
          return Wrap(alignment: WrapAlignment.center, children: <Widget>[
            Icon(Icons.watch, color: ColorProvider.get(CustomColor.background)),
            Text(
              bluetoothInfoProvider.getConnectionState(),
              style: TextStyle(
                  color: ColorProvider.get(CustomColor.background),
                  fontSize: 20),
            ),
          ]);
        }),
      ),
    ]);
  }
}
