import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/timer_info_provider.dart';

class TimerComp extends StatefulWidget {
  const TimerComp({super.key});

  @override
  State<TimerComp> createState() => TimerCompState();
}

class TimerCompState extends State<TimerComp> {
  final ButtonStyle timerControlButtonStyle =
      ElevatedButton.styleFrom(backgroundColor: Colors.white);

  @override
  Widget build(BuildContext context) {
    // TimerInfo timerInfo = TimerInfo();
    context.watch<TimerInfoProvider>();
    return SizedBox(
        height: 60.h,
        width: 80.w,
        child: Column(
          children: [
            SizedBox(
              height: 8.h,
              width: 10.w,
            ),
            Container(
              height: 30.h,
              width: 75.w,
              color: Colors.yellow,
              alignment: Alignment.center,
              child: Container(
                  height: 28.h,
                  width: 70.w,
                  color: Colors.lightBlueAccent,
                  alignment: Alignment.center,
                  child: Consumer<TimerInfoProvider>(
                    builder: (context, timerInfoProvider, child) {
                      return Text(timerInfoProvider.toString());
                    },
                  )),
            ),
            SizedBox(
              height: 3.h,
              width: 5.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Timer.periodic(const Duration(seconds: 1), (timer) {
                        // Provider.of<TimerInfoProvider>(context, listen: false)
                        //     .tick();
                        context.read<TimerInfoProvider>().tick();
                      });
                    },
                    child: const Icon(Icons.play_arrow)),
                ElevatedButton(
                    onPressed: TimerInfoProvider().pauseTimer,
                    child: const Icon(Icons.pause)),
                ElevatedButton(
                    onPressed: TimerInfoProvider().resetTimer,
                    child: const Icon(Icons.stop)),
              ],
            )
          ],
        ));
  }
}
