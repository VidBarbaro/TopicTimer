import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/theme/color_themes.dart';

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
          child: Text.rich(
            const TextSpan(
              text: 'Track. Learn. Succeed.',
            ),
            style: TextStyle(
              color: ColorThemes.get()?['text'],
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
          ),
        ),
        Text.rich(
          const TextSpan(
            text:
                'Make Time Tracking a Breeze\nWhere Learning Meets Simplicity with TopicTimer.',
          ),
          style: TextStyle(
            color: ColorThemes.get()?['text'],
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        Container(
          padding: const EdgeInsetsDirectional.only(
            top: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size(180, 40),
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    ColorThemes.get()?['text'],
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    ColorThemes.get()?['secondary'],
                  ),
                ),
                child: Text.rich(
                  TextSpan(
                    text: 'Try it now',
                    style: TextStyle(
                      color: ColorThemes.get()?['text'],
                      fontSize: 16,
                    ),
                  ),
                ),
                onPressed: () => {},
              ),
              const SizedBox(width: 50),
              TextButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size(180, 40),
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    ColorThemes.get()?['text'],
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    ColorThemes.get()?['secondary'],
                  ),
                ),
                child: Text.rich(
                  TextSpan(
                    text: 'See how it works',
                    style: TextStyle(
                      color: ColorThemes.get()?['text'],
                      fontSize: 16,
                    ),
                  ),
                ),
                onPressed: () => {},
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
