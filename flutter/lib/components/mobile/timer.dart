import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:topictimer_flutter_application/bll/topic_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/bluetooth_info_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/timer_info_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/topbar_content_provider.dart';

class TimerComp extends StatelessWidget {
  TimerComp({super.key});
  final ButtonStyle timerControlButtonStyle =
      ElevatedButton.styleFrom(backgroundColor: Colors.white);

  void simulateTrackedTimeMessage(BuildContext context) {
    DateTime startTime = DateTime.now().subtract(Duration(
      hours: context.read<TimerInfoProvider>().getHours(),
      minutes: context.read<TimerInfoProvider>().getMinutes(),
      seconds: context.read<TimerInfoProvider>().getSeconds(),
    ));
    String message = '{';
    message += '"command":"setTrackedTime",';
    message +=
        '"topic":{"id":"${context.read<TopBarConentProvider>().getSelectedTopic().id}"},';
    message +=
        '"beg":{"t":{"h":${startTime.hour},"m":${startTime.minute},"s":${startTime.second}},"d":{"D":${startTime.day},"M":${startTime.month},"Y":${startTime.year}}},';
    message +=
        '"end":{"t":{"h":${DateTime.now().hour},"m":${DateTime.now().minute},"s":${DateTime.now().second}},"d":{"D":${DateTime.now().day},"M":${DateTime.now().month},"Y":${DateTime.now().year}}}';
    message += '}';

    context.read<BluetoothInfoProvider>().handleMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TopicProvider>(builder: (context, topicProvider, child) {
      return SizedBox(
        height: 60.h,
        width: 80.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer<TopBarConentProvider>(
                builder: (context, topBarConentProvider, child) {
              return Wrap(
                  alignment: WrapAlignment.center,
                  direction: Axis.vertical,
                  children: [
                    SizedBox(
                      height: 8.h,
                      width: 10.w,
                    ),
                    Container(
                      height: 30.h,
                      width: 75.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: topBarConentProvider.getSelectedTopic().color,
                          borderRadius: BorderRadius.all(Radius.circular(5.w))),
                      child: Container(
                        height: 28.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.w))),
                        alignment: Alignment.center,
                        child: Consumer<TimerInfoProvider>(
                            builder: (context, timerInfoProvider, child) {
                          if (topicProvider.topicList.isNotEmpty) {
                            return Text(
                              timerInfoProvider.toString(),
                              style: TextStyle(fontSize: 16.w),
                            );
                          } else {
                            return Text(
                              "You don't have any topics. \n Go ahead and make one to start tracking",
                              style: TextStyle(fontSize: 5.w),
                              textAlign: TextAlign.center,
                            );
                          }
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 6.h,
                      width: 5.w,
                    )
                  ]);
            }),
            Consumer<TopBarConentProvider>(
                builder: (context, topBarConentProvider, child) {
              if (TopicProvider.getTopics().isNotEmpty) {
                return Consumer<TimerInfoProvider>(
                    builder: (context, timerInfoProvider, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (!context
                                .read<TimerInfoProvider>()
                                .isInitialized) {
                              Timer.periodic(const Duration(seconds: 1),
                                  (timer) {
                                context.read<TimerInfoProvider>().tick();
                              });
                              context.read<TimerInfoProvider>().setInit();
                            }
                            context.read<TimerInfoProvider>().enableTimer();
                          },
                          child: const Icon(Icons.play_arrow)),
                      ElevatedButton(
                          onPressed: () {
                            context.read<TimerInfoProvider>().pauseTimer();
                          },
                          child: const Icon(Icons.pause)),
                      ElevatedButton(
                          onPressed: () {
                            simulateTrackedTimeMessage(context);
                            context.read<TimerInfoProvider>().resetTimer();
                            context.read<TimerInfoProvider>().disableTimer();
                          },
                          child: const Icon(Icons.stop)),
                    ],
                  );
                });
              }
              return const Text('');
            })
          ],
        ),
      );
    });
  }
}
