import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/website/navbar_item.dart';
import 'package:topictimer_flutter_application/routes/website.dart';
import 'package:topictimer_flutter_application/theme/color_themes.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String activeLink;

  const Navbar({required this.activeLink, super.key});

  @override
  Size get preferredSize {
    return const Size.fromHeight(80.0);
  }

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    List<Widget> navbarItems = <Widget>[];
    var routeList = WebsiteRouter.getRouteList();
    routeList?.forEach((key, value) => navbarItems.add(NavbarItem(
        title: value['name'], link: key, activeLink: widget.activeLink)));

    return Container(
      color: ColorThemes.get()?['primary'],
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Image(
            image: AssetImage('assets/images/TopicTimerFullLogoWhite.png'),
          ),
          Wrap(
            spacing: 50,
            children: navbarItems,
          ),
        ],
      ),
    );
  }
}

class DesktopNavbar extends StatelessWidget {
  const DesktopNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
