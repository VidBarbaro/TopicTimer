import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/mobile/topbar.dart';
import 'package:topictimer_flutter_application/components/mobile/tracked_time_component.dart';

class MobilePlanningPage extends StatelessWidget {
  const MobilePlanningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar(
          key: super.key,
          callback: (){},
        ),
        TrackedTimeComp(),
      ],
    );
  }
}
