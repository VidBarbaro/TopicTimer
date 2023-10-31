import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/mobile/timer.dart';
import 'package:topictimer_flutter_application/components/mobile/topbar.dart';

class MobileTimerPage extends StatelessWidget {
  const MobileTimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar(
          key: super.key,
        ),
        TimerComp(key: super.key),
      ],
    );
  }
}
