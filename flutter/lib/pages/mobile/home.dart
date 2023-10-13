import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:topictimer_flutter_application/components/website/navbar.dart';

class HomePageMobile extends StatelessWidget {
  const HomePageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(
        activeLink: '/',
      ),
      body: Column(children: <Widget>[
        const Text('this is the mobile home page'),
        ElevatedButton(
          onPressed: () => context.go('/news'),
          child: const Text('Go to the news page'),
        ),
      ]),
    );
  }
}
