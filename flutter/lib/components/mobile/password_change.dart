import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/theme_change_provider.dart';
import 'package:topictimer_flutter_application/theme/color_provider.dart';
import 'package:topictimer_flutter_application/theme/custom_color.dart';

class PasswordChangeComp extends StatelessWidget {
  PasswordChangeComp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChangeProvider>(
    builder: (context, themeChangeProvider, child) {
      return Align(
        alignment: Alignment.topCenter,
        child: Container(
          decoration: BoxDecoration(
            color: ColorProvider.get(CustomColor.text),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          constraints: const BoxConstraints(maxWidth: 270, maxHeight: 235),
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment(-0.85, -0.75),
                child: Text(
                  'Password',
                  style: TextStyle(
                    color: ColorProvider.get(CustomColor.background),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              _buildPasswordField('Old password'),
              _buildPasswordField('New password'),
              _buildPasswordField('Confirm new password'),
              Align(
                alignment: Alignment(0.75, 0.85),
                child: ElevatedButton(
                  onPressed: () {
                    // Action to perform when the button is pressed
                    print('Button pressed!');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorProvider.get(CustomColor.secondary),
                  ),
                  child: Text(
                    'Save Changes',
                    style: TextStyle(
                      color: ColorProvider.get(CustomColor.background),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      });
  }

  Widget _buildPasswordField(String hintText) {
    return Consumer<ThemeChangeProvider>(
    builder: (context, themeChangeProvider, child) {
      return Padding(
        padding: const EdgeInsets.all(3.0),
        child: SizedBox(
          height: 35,
          width: 230,
          child: TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: ColorProvider.get(CustomColor.background),
              border: OutlineInputBorder(),
              hintText: hintText,
              contentPadding: const EdgeInsets.all(1),
            ),
          ),
        ),
      );
            });
  }
}
