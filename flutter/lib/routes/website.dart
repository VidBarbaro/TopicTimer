import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:topictimer_flutter_application/pages/website/home.dart';
import 'package:topictimer_flutter_application/pages/website/news.dart';

class WebsiteRouter {
  static String _currentSession = 'loggedOut';
  WebsiteRouter._();

  static Map<String, Map<String, dynamic>>? getRouteList() {
    const Map<String, Map<String, Map<String, dynamic>>> routeList = {
      'loggedOut': {
        '/': {
          'name': 'Home',
          'page': HomePage(),
        },
        '/news': {
          'name': 'News',
          'page': NewsPage(),
        },
      },
      'loggedIn': {
        '/': {
          'name': 'Home',
          'page': HomePage(),
        },
        '/topics': {
          'name': 'Topics',
          'page': NewsPage(),
        },
        '/planning': {
          'name': 'Planning',
          'page': NewsPage(),
        },
        '/history': {
          'name': 'History',
          'page': NewsPage(),
        },
        '/news': {
          'name': 'News',
          'page': NewsPage(),
        },
      }
    };

    return routeList[_currentSession];
  }

  static GoRouter get(String session) {
    _currentSession = session;
    List<RouteBase> routes = <RouteBase>[];
    var routeList = getRouteList();

    routeList?.forEach((key, value) => routes.add(
          GoRoute(
            path: key,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              NoTransitionPage(
            key: state.pageKey,
              child: value['page']
          ),
          ),
        ));

    return GoRouter(
      routes: routes,
    );
  }
}
