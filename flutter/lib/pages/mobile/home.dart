import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/topbar_content_provider.dart';
import 'package:topictimer_flutter_application/pages/mobile/personal_page.dart';
import 'package:topictimer_flutter_application/pages/mobile/planning_page.dart';
import 'package:topictimer_flutter_application/pages/mobile/settings_page.dart';
import 'package:topictimer_flutter_application/pages/mobile/timer_page.dart';
import 'package:topictimer_flutter_application/pages/mobile/topics_page.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => HomePageMobileState();
}

class HomePageMobileState extends State<HomePageMobile> {
  TextStyle navBarItemTextStyle = const TextStyle(color: Color(0xFF239AFB));

  PersistentTabController navBarController =
      PersistentTabController(initialIndex: 2);

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
          textStyle: navBarItemTextStyle,
          icon: const Icon(Icons.subject, color: Color(0xFFFF8205)),
          inactiveIcon: const Icon(Icons.subject, color: Color(0xFF239AFB))),
      PersistentBottomNavBarItem(
          title: 'Planning',
          textStyle: navBarItemTextStyle,
          icon: const Icon(Icons.calendar_today, color: Color(0xFFFF8205)),
          inactiveIcon:
              const Icon(Icons.calendar_today, color: Color(0xFF239AFB))),
      PersistentBottomNavBarItem(
          title: 'Timer',
          textStyle: navBarItemTextStyle,
          icon: const Icon(Icons.timer, color: Color(0xFFFF8205)),
          inactiveIcon: const Icon(Icons.timer, color: Color(0xFF239AFB))),
      PersistentBottomNavBarItem(
          title: 'Personal',
          textStyle: navBarItemTextStyle,
          icon: const Icon(Icons.person, color: Color(0xFFFF8205)),
          inactiveIcon: const Icon(
            Icons.person,
            color: Color(0xFF239AFB),
          )),
      PersistentBottomNavBarItem(
          title: 'Settings',
          textStyle: navBarItemTextStyle,
          icon: const Icon(Icons.settings, color: Color(0xFFFF8205)),
          inactiveIcon: const Icon(Icons.settings, color: Color(0xFF239AFB)))
    ];
  }

  void notifyNavBarChange() {}

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(context,
        screens: createScreens(),
        items: createNavBarItems(),
        controller: navBarController,
        backgroundColor: const Color(0xFFE6F3FE),
        decoration: NavBarDecoration(borderRadius: BorderRadius.circular(1)),
        navBarStyle: NavBarStyle.style15, onItemSelected: (value) {
      context.read<TopBarConentProvider>().setPageIndex(navBarController.index);
    },
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ));
  }
}
