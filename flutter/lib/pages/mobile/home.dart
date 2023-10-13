import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:topictimer_flutter_application/components/mobile/navbar.dart';
import 'package:topictimer_flutter_application/components/website/navbar.dart';

class HomePageMobile extends StatelessWidget {
  const HomePageMobile({super.key});

  List<Widget> createScreens() {
    return [
      Text('Home1'),
      Text('Home2'),
      Text('Home3'),
      Text('Home4'),
      Text('Settings')
    ];
  }

  List<PersistentBottomNavBarItem> createNavBarItems() {
    return [
      PersistentBottomNavBarItem(title: 'yeet', icon: Icon(Icons.home)),
      PersistentBottomNavBarItem(icon: Icon(Icons.home)),
      PersistentBottomNavBarItem(
          activeColorSecondary: Colors.white,
          icon: Icon(Icons.home),
          inactiveColorSecondary: Colors.pink),
      PersistentBottomNavBarItem(icon: Icon(Icons.home)),
      PersistentBottomNavBarItem(icon: Icon(Icons.home))
    ];
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return PersistentTabView(
      context,
      screens: createScreens(),
      items: createNavBarItems(),
      backgroundColor: Colors.lightBlue,
      decoration: NavBarDecoration(borderRadius: BorderRadius.circular(1)),
      navBarStyle: NavBarStyle.style15,
=======
    return Scaffold(
      appBar: const Navbar(
        activeLink: '/',
        session: 'loggedIn',
      ),
      body: Column(children: <Widget>[
        const Text('this is the mobile home page'),
        ElevatedButton(
          onPressed: () => context.go('/news'),
          child: const Text('Go to the news page'),
        ),
      ]),
>>>>>>> ebf2ebc09101ff77287b02e309f2fba2283e044f
    );
  }
}
