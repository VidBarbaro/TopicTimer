import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:topictimer_flutter_application/pages/mobile/home.dart';
import 'package:topictimer_flutter_application/routes/desktop.dart';
import 'package:topictimer_flutter_application/routes/mobile.dart';
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
          router = WebsiteRouter.get('loggedIn');
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
          return const MaterialApp(
            title: 'TopicTimerApp',
            home: HomePageMobile(),
            debugShowCheckedModeBanner: false,
          );
        },
      );
    } 

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
