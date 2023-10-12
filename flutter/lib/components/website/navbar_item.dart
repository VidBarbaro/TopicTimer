import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavbarItem extends StatefulWidget {
  final String title;
  final String link;
  final String activeLink;

  const NavbarItem({required this.title, required this.link, required this.activeLink, super.key});
  
  @override
  State<NavbarItem> createState() => _NavbarItemState();
}

class _NavbarItemState extends State<NavbarItem> {
  String title = '';
  String link = '';
  bool isActive = false;
  TextStyle nonActiveLinkStyle = const TextStyle(
    color: Colors.white,
    fontFamily: 'BodoniMT',
    fontSize: 20,
  );

  void onHover() {
    setState(() {
      nonActiveLinkStyle = const TextStyle(
        color: Colors.white,
        fontFamily: 'BodoniMT',
        fontSize: 20,
        decoration: TextDecoration.underline,
      );
    });
  }

  void onHoverExit() {
    setState(() {
      nonActiveLinkStyle = const TextStyle(
        color: Colors.white,
        fontFamily: 'BodoniMT',
        fontSize: 20,
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    title = widget.title;
    link = widget.link;
    isActive = widget.link == widget.activeLink;

    if (isActive) {
      return Text.rich(
              TextSpan(
          text: title,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => context.go(link),
                style: const TextStyle(
            color: Colors.white,
                  fontFamily: 'BodoniMT',
                  fontSize: 20,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
                ),
              ),
            );
    }

    return Text.rich(
              TextSpan(
        text: title,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => context.go(link),
        onEnter: (event) => onHover(),
        onExit: (event) => onHoverExit(),
        style: nonActiveLinkStyle,
              ),
            );
  }
}