import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:topictimer_flutter_application/pages/mobile/home.dart';

class MobileRouter {
  MobileRouter._();

  static GoRouter get() {
    return GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              NoTransitionPage(
            key: state.pageKey,
            child: const HomePageMobile(),
          ),
        ),
      ],
    );
  }
}
