import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:topictimer_flutter_application/pages/mobile/personal_page.dart';
import 'package:topictimer_flutter_application/pages/mobile/planning_page.dart';
import 'package:topictimer_flutter_application/pages/mobile/settings_page.dart';
import 'package:topictimer_flutter_application/pages/mobile/timer_page.dart';
import 'package:topictimer_flutter_application/pages/mobile/topics_page.dart';

class HomePageMobile extends StatelessWidget {
  const HomePageMobile({super.key});

  List<Widget> createScreens() {
    return [
      const MobileTopicsPage(),
      const MobilePlanningPage(),
      const MobileTimerPage(),
      const MobilePersonalPage(),
      const MobileSettingsPage()
    ];
  }

  List<PersistentBottomNavBarItem> createNavBarItems() {
    return [
      PersistentBottomNavBarItem(
          title: 'Topics',
          icon: const Icon(Icons.subject),
          inactiveIcon: const Icon(
            Icons.subject,
            color: Colors.black,
          )),
      PersistentBottomNavBarItem(
          title: 'Planning',
          icon: const Icon(Icons.calendar_today),
          inactiveIcon: const Icon(
            Icons.calendar_today,
            color: Colors.black,
          )),
      PersistentBottomNavBarItem(
          title: 'Timer',
          icon: const Icon(Icons.timer, color: Colors.white),
          inactiveIcon: const Icon(
            Icons.timer,
            color: Colors.black,
          )),
      PersistentBottomNavBarItem(
          title: 'Personal',
          icon: const Icon(Icons.person),
          inactiveIcon: const Icon(
            Icons.person,
            color: Colors.black,
          )),
      PersistentBottomNavBarItem(
          title: 'Settings',
          icon: const Icon(Icons.settings),
          inactiveIcon: const Icon(Icons.settings, color: Colors.black))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(context,
        screens: createScreens(),
        items: createNavBarItems(),
        backgroundColor: Colors.lightBlue,
        decoration: NavBarDecoration(borderRadius: BorderRadius.circular(1)),
        navBarStyle: NavBarStyle.style15,
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ));
  }
}
