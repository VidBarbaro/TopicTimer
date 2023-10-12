import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:topictimer_flutter_application/pages/home.dart';
import 'package:topictimer_flutter_application/pages/news.dart';

void main() => runApp(const MyApp());

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) => NoTransitionPage (
            key: state.pageKey,
            child: const HomePage(),
          ),
    ),
    GoRoute(
      path: '/news',
      pageBuilder: (BuildContext context, GoRouterState state) => NoTransitionPage (
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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}