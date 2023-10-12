import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_application/components/navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(activeLink: '/',),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/news'),
          child: const Text('Go to the news page'),
        ),
      ),
    );
  }
}