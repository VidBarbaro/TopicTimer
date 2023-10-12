import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/website/navbar_item.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String activeLink;

  const Navbar({required this.activeLink, super.key});

  @override
  Size get preferredSize {
    return const Size.fromHeight(90.0);
  }

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff009688),
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Image(
            image: AssetImage('assets/images/TopicTimerFullLogoWhite.png'),
            height: 50,
          ),
          Wrap(
            spacing: 50,
            children: [
              NavbarItem(
                title: 'Home',
                link: '/',
                activeLink: widget.activeLink,
              ),
              NavbarItem(
                title: 'News',
                link: '/news',
                activeLink: widget.activeLink,
              ),
              NavbarItem(
                title: 'Login',
                link: '/login',
                activeLink: widget.activeLink,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MobileNavbar extends StatelessWidget {
  const MobileNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class DesktopNavbar extends StatelessWidget {
  const DesktopNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
