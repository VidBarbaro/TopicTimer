import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/website/home_page/home_about.dart';
import 'package:topictimer_flutter_application/components/website/home_page/home_title.dart';
import 'package:topictimer_flutter_application/components/website/navbar.dart';
import 'package:topictimer_flutter_application/theme/color_themes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(
        activeLink: '/',
      ),
      backgroundColor: ColorThemes.get()?['background'],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            HomeTitle.container,
            HomeAbout.container,
          ],
        ),
      ),
    );
  }
}
