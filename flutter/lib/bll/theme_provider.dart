import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/theme/custom_color.dart';

class ThemeProvider {

  static Map<CustomColor, Color> getTheme() {
    /// TODO change test data to API call or internal storage
      return {
        CustomColor.primary: const Color(0xff009688),
        CustomColor.secondary: const Color(0xffFFC107),
        CustomColor.tertiary: const Color(0xff03A9F4),
        CustomColor.background: const Color(0xffF5F5F5),
        CustomColor.text: const Color(0xff333333),
      };
  }
}