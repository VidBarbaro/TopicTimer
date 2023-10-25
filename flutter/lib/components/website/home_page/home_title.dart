import 'package:flutter/material.dart';

class HomeTitle {
  static Container container = Container(
    width: double.infinity,
    padding: const EdgeInsetsDirectional.all(30),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsetsDirectional.only(
            bottom: 10,
          ),
          child: const Text.rich(
            TextSpan(text: 'Track. Learn. Succeed.'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
          ),
        ),
        const Text.rich(
          TextSpan(
            text:
                'Make Time Tracking a Breeze\nWhere Learning Meets Simplicity with TopicTimer.',
          ),
          style: TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
