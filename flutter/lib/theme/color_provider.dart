import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/theme/custom_color.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/theme_change_provider.dart';

class ColorProvider {
  /// Example:
  /// ColorProvider.get(CustomColor.primary)
  /// 
  static Color? get(CustomColor color) => ThemeChangeProvider.theme?[color];

}
