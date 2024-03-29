import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:topictimer_flutter_application/bll/topic_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/bluetooth_info_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/planning_selected_date_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/planning_selected_view_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/theme_change_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/timer_info_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/topbar_content_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/tracked_times_provider.dart';
import 'package:topictimer_flutter_application/pages/mobile/home.dart';
import 'package:topictimer_flutter_application/routes/desktop.dart';
import 'package:topictimer_flutter_application/routes/website.dart';

void main() => runApp(const MyApp());

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
                  create: (context) => TopBarConentProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => TimerInfoProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => BluetoothInfoProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => ThemeChangeProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => TopicProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => TrackedTimesProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => PlanningSelectedDateProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => PlanningSelectedViewProvider(),
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
