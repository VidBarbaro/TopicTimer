import 'package:flutter/material.dart';

class ColorThemes {
  /// Example:
  /// ColorThemes.get()?['primary']
  static Map<String, dynamic>? get({String theme = 'default'}) {
    const themes = {
      'default': {
        'primary': Color(0xff009688),
        'secondary': Color(0xffFFC107),
        'tertiary': Color(0xff03A9F4),
        'background': Color(0xffF5F5F5),
        'text': Color(0xff333333),
      }
    };

    return themes[theme] ?? themes['default'];
  }
}
