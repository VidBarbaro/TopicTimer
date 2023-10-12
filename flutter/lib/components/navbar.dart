import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_application/components/navbar_item.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String activeLink;

  const Navbar({required this.activeLink, super.key});

  @override
  Size get preferredSize {
    return const Size.fromHeight(90.0);
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const WebsiteNavbar(activeLink: activeLink,);
    }
    else if (Platform.isAndroid) {

    }
    else if (Platform.isIOS) {
      
    }
    else if (Platform.isWindows) {
      
    }
    else if (Platform.isLinux) {
      
    }
    else if (Platform.isMacOS) {
      
    }

    return const Placeholder();
  }
}

class WebsiteNavbar extends StatefulWidget {
  final String activeLink;
  const WebsiteNavbar({required this.activeLink, super.key});
  
  @override
  State<WebsiteNavbar> createState() => _WebsiteNavbarState();
}

class _WebsiteNavbarState extends State<WebsiteNavbar> {
  String _activeLink = '/';

  void setActiveLink(String link) {
    setState(() { _activeLink = link; });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff009688),
      padding: const EdgeInsets.all(30),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(image: AssetImage('assets/images/TopicTimerFullLogoWhite.png')),
          Wrap(
            spacing: 50,
            children: [
              NavbarItem(),
              NavbarItem(title: 'News', link: '/news'),
              NavbarItem(title: 'Login', link: '/login'),
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