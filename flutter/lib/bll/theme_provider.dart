import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/theme/custom_color.dart';

class ThemeProvider {
  static bool darktheme = false;
  static Map<CustomColor, Color> getTheme() {
    /// THIS MODULE NEEDS TO BE DELETED, IT IS REPLACED BY THE THEME_CHANGE_PROVIDER
    if (darktheme == false) {
      return {
        CustomColor.primary: const Color(0xff009688),
        CustomColor.secondary: const Color(0xffFFC107),
        CustomColor.tertiary: const Color(0xff03A9F4),
        CustomColor.background: const Color(0xffF5F5F5),
        CustomColor.text: const Color(0xff333333),
      };
    }
    return {
      CustomColor.primary: const Color.fromARGB(255, 0, 0, 0),
      CustomColor.secondary: const Color(0xffFFC107),
      CustomColor.tertiary: const Color(0xff03A9F4),
      CustomColor.background: const Color(0xffF5F5F5),
      CustomColor.text: const Color(0xff333333),
    };
  }

  static void changeTheme() {}
}
