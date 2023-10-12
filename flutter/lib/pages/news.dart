import 'package:flutter/material.dart';
import 'package:test_application/components/navbar.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Navbar(activeLink: '/news',),
      body: Center(
        child: Text('News'),
      ),
    );
  }
}