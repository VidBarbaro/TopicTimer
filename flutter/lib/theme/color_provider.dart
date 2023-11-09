import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/theme/custom_color.dart';
import 'package:topictimer_flutter_application/bll/theme_provider.dart';

class ColorProvider {
  /// Example:
  /// ColorProvider.get(CustomColor.primary)
  static Color? get(CustomColor color) => ThemeProvider.getTheme()[color];
}
