import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/theme_change_provider.dart';
import 'package:topictimer_flutter_application/theme/custom_color.dart';

const List<String> list = <String>['Default', 'Dark'];

class ThemeChangeComponent extends StatelessWidget {
  const ThemeChangeComponent({super.key});

  @override
  Widget build(BuildContext context) {
    String dropdownValue = list.first;
    return Consumer<ThemeChangeProvider>(
        builder: (context, themeChangeProvider, child) {
      return Row(
        children: [
          Container(
            height: 100,
            width: 100,
            color: ThemeChangeProvider.theme?[CustomColor.primary],
          ),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: ThemeChangeProvider.theme?[CustomColor.primary],
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              print('test test test $value');
              print(ThemeChangeProvider.theme?[CustomColor.primary]);
              context.read<ThemeChangeProvider>().changeTheme(value!);
              dropdownValue = value;
              //themeChangeProvider.changeTheme();
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      );
    });
  }
}
