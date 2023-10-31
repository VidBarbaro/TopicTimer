import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/navbar_index_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/timer_info_provider.dart';
import 'package:topictimer_flutter_application/pages/mobile/home.dart';
import 'package:topictimer_flutter_application/routes/desktop.dart';
import 'package:topictimer_flutter_application/routes/website.dart';

void main() => runApp(const MyApp());

// void main() => runApp(ChangeNotifierProvider<MultiProvider>(
//     child: const MyApp(),
//     create: (_) => MultiProvider(providers: NavBarIndexProvider())));

/*
This might break the website, but I need this for statemanagment of the mobile app,
In case it breaks... This was the old implementation
void main() => runApp(const MyApp());
*/
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoRouter router = GoRouter(routes: <RouteBase>[]);

  void setRouterForDevice(String device) {
    setState(() {
      switch (device) {
        case 'website':
          router = WebsiteRouter.get('loggedOut');
          break;
        case 'desktop':
          router = DesktopRouter.get();
          break;
        default:
          router = GoRouter(
            routes: <RouteBase>[],
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      setRouterForDevice('website');
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      setRouterForDevice('desktop');
    } else if (Platform.isAndroid || Platform.isIOS) {
      return Sizer(
        builder: (context, orientation, deviceType) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => TimerInfoProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => NavBarIndexProvider(),
                )
              ],
              child: const MaterialApp(
                title: 'Topic Timer',
                home: HomePageMobile(),
                debugShowCheckedModeBanner: false,
              ));
        },
      );
    }

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
