import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/bluetooth_info_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/topbar_content_provider.dart';
import 'package:topictimer_flutter_application/pages/mobile/personal_page.dart';
import 'package:topictimer_flutter_application/pages/mobile/planning_page.dart';
import 'package:topictimer_flutter_application/pages/mobile/settings_page.dart';
import 'package:topictimer_flutter_application/pages/mobile/timer_page.dart';
import 'package:topictimer_flutter_application/pages/mobile/topics_page.dart';
import 'package:topictimer_flutter_application/theme/custom_color.dart';
import 'package:topictimer_flutter_application/theme/color_provider.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => HomePageMobileState();
}

class HomePageMobileState extends State<HomePageMobile> {
  // ASK MICHEL, i dont know why but i couldn't get calling this variable to change colors for me
  TextStyle navBarItemTextStyle =
      TextStyle(color: ColorProvider.get(CustomColor.tertiary));

  PersistentTabController navBarController =
      PersistentTabController(initialIndex: 2);

  List<Widget> createScreens() {
    return [
      MobileTopicsPage(),
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
          textStyle: TextStyle(
            color: ColorProvider.get(CustomColor.tertiary),
          ),
          activeColorPrimary:
              ColorProvider.get(CustomColor.secondary) ?? Colors.white,
          icon: Icon(Icons.subject,
              color: ColorProvider.get(CustomColor.secondary)),
          inactiveIcon: Icon(Icons.subject,
              color: ColorProvider.get(CustomColor.tertiary))),
      PersistentBottomNavBarItem(
          title: 'Planning',
          textStyle: TextStyle(color: ColorProvider.get(CustomColor.tertiary)),
          activeColorPrimary:
              ColorProvider.get(CustomColor.secondary) ?? Colors.white,
          icon: Icon(Icons.calendar_today,
              color: ColorProvider.get(CustomColor.secondary)),
          inactiveIcon: Icon(Icons.calendar_today,
              color: ColorProvider.get(CustomColor.tertiary))),
      // HAVE TO ASK MICHEL, is the button active the whole time because it's weird with changing colors and stays on the color as it is active the whole time
      // this it has to do something with intial index but not sure
      PersistentBottomNavBarItem(
          title: 'Timer',
          textStyle: TextStyle(color: ColorProvider.get(CustomColor.tertiary)),
          activeColorPrimary:
              ColorProvider.get(CustomColor.secondary) ?? Colors.white,
          icon:
              Icon(Icons.timer, color: ColorProvider.get(CustomColor.tertiary)),
          inactiveIcon: Icon(Icons.timer,
              color: ColorProvider.get(CustomColor.background))),
      PersistentBottomNavBarItem(
          title: 'Personal',
          textStyle: TextStyle(color: ColorProvider.get(CustomColor.tertiary)),
          activeColorPrimary:
              ColorProvider.get(CustomColor.secondary) ?? Colors.white,
          icon: Icon(Icons.person,
              color: ColorProvider.get(CustomColor.secondary)),
          inactiveIcon: Icon(
            Icons.person,
            color: ColorProvider.get(CustomColor.tertiary),
          )),
      PersistentBottomNavBarItem(
          title: 'Settings',
          textStyle: TextStyle(color: ColorProvider.get(CustomColor.tertiary)),
          activeColorPrimary:
              ColorProvider.get(CustomColor.secondary) ?? Colors.white,
          icon: Icon(Icons.settings,
              color: ColorProvider.get(CustomColor.secondary)),
          inactiveIcon: Icon(Icons.settings,
              color: ColorProvider.get(CustomColor.tertiary)))
    ];
  }

  void notifyNavBarChange() {}

  @override
  Widget build(BuildContext context) {
    context.read<BluetoothInfoProvider>().enableBluetooth();
    return PersistentTabView(context,
        screens: createScreens(),
        items: createNavBarItems(),
        controller: navBarController,
        backgroundColor: ColorProvider.get(CustomColor.primary) ?? Colors.white,
        decoration: NavBarDecoration(borderRadius: BorderRadius.circular(1)),
        navBarStyle: NavBarStyle.style15, onItemSelected: (value) {
      context.read<TopBarConentProvider>().setPageIndex(navBarController.index);
    },
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 100),
        ));
  }
}
