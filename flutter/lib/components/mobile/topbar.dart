import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => TopBarState();
}

class TopBarState extends State<TopBar> {
  String title = 'No Title';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.w,
      height: 15.h,
      color: Colors.blue,
      child: const Text('yeet'),
    );
  }
}
