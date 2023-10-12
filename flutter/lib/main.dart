import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:topictimer_flutter_application/pages/website/home.dart';
import 'package:topictimer_flutter_application/pages/website/news.dart';

void main() => runApp(const MyApp());

final GoRouter websiteRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          NoTransitionPage(
        key: state.pageKey,
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: '/news',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          NoTransitionPage(
        key: state.pageKey,
        child: const NewsPage(),
      ),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      //return website properties
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: websiteRouter,
      );
    } else if (Platform.isAndroid) {
    } else if (Platform.isIOS) {
    } else if (Platform.isWindows) {
    } else if (Platform.isLinux) {
    } else if (Platform.isMacOS) {}
    return const Placeholder();
  }
}
