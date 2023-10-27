import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/mobile/topbar.dart';

class MobileTopicsPage extends StatelessWidget {
  const MobileTopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar(
          key: super.key,
        )
      ],
    );
  }
}
