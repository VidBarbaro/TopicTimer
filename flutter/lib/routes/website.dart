import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:topictimer_flutter_application/pages/website/home.dart';
import 'package:topictimer_flutter_application/pages/website/news.dart';

class WebsiteRouter {
  WebsiteRouter._();

  static GoRouter get() {
    return GoRouter(
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
  }
}
