import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:topictimer_flutter_application/components/mobile/navbar.dart';
import 'package:topictimer_flutter_application/components/website/navbar.dart';

class HomePageMobile extends StatelessWidget {
  const HomePageMobile({super.key});

  List<Widget> createScreens() {
    return [
      Text('Topics page'),
      Text('Planning'),
      Text('Timer'),
      Text('Personal'),
      Text('Settings')
    ];
  }

  List<PersistentBottomNavBarItem> createNavBarItems() {
    return [
      PersistentBottomNavBarItem(title: 'Topics', icon: Icon(Icons.subject)),
      PersistentBottomNavBarItem(
          title: 'Planning', icon: Icon(Icons.calendar_today)),
      PersistentBottomNavBarItem(
          title: 'Timer',
          activeColorSecondary: Colors.white,
          icon: Icon(Icons.timer, color: Colors.black)),
      PersistentBottomNavBarItem(
          title: 'Personal',
          icon: Icon(Icons.person, color: Colors.black),
          inactiveIcon: Icon(
            Icons.person,
            color: Colors.black,
          )),
      PersistentBottomNavBarItem(title: 'Settings', icon: Icon(Icons.settings))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: createScreens(),
      items: createNavBarItems(),
      backgroundColor: Colors.lightBlue,
      decoration: NavBarDecoration(borderRadius: BorderRadius.circular(1)),
      navBarStyle: NavBarStyle.style15,
    );
  }
}
