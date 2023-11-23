import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/theme/color_provider.dart';
import 'package:topictimer_flutter_application/theme/custom_color.dart';

class ProfileDetailsComp extends StatelessWidget {
  ProfileDetailsComp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
    return Container(
      color: ColorProvider.get(CustomColor.primary),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: ColorProvider.get(CustomColor.background),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: ColorProvider.get(CustomColor.text),
                    child: Center(
                      child: Icon(
                        Icons.person, 
                        color: ColorProvider.get(CustomColor.background),
                        size: 100,
                        ),
                    )
                  ),
                ),
                SizedBox(height: 15),
                // Is the white border around the text as shown in figma needed? No in built property by flutter
                Text(
                  'John Doe',
                  style: TextStyle(
                    color: ColorProvider.get(CustomColor.tertiary),
                    fontWeight: FontWeight.bold,
                    fontSize: 37,
                    ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

}