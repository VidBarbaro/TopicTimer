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
  String _title = '';
  String _link = '';
  bool _isActive = false;

  void setTitle(String title) {
    setState(() { _title = title; });
  }
  void setLink(String link) {
    setState(() { _link = link; });
  }
  void setIsActive(String activeLink) {
    setState(() { _isActive = _link == activeLink; });
  }
  
  @override
  Widget build(BuildContext context) {
    if (_isActive) {
      return Text.rich(
              TextSpan(
                text: _title,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => context.go(_link),
                style: const TextStyle(
                  color: Colors.blue,
                  fontFamily: 'BodoniMT',
                  fontSize: 20,
                ),
              ),
            );
    }

    return Text.rich(
              TextSpan(
                text: _title,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => context.go(_link),
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'BodoniMT',
                  fontSize: 20,
                ),
              ),
            );
  }
}