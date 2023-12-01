import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/theme_change_provider.dart';
import 'package:topictimer_flutter_application/theme/color_provider.dart';
import 'package:topictimer_flutter_application/theme/custom_color.dart';

class SchoolDetailsComp extends StatelessWidget {
  SchoolDetailsComp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChangeProvider>(
    builder: (context, themeChangeProvider, child) {
      return Container(
          width: 100.w,
          height: 10.h,
          color: ColorProvider.get(CustomColor.tertiary),
          child: Center(
                child: Text(
                  'School name',
                  style: TextStyle(
                    color: ColorProvider.get(CustomColor.background),
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    ),
                ),
              )
          );
      });
  }

}