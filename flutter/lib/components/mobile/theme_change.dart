import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/theme_change_provider.dart';

const List<String> list = <String>['Default', 'Dark'];

class ThemeChangeComponent extends StatefulWidget {
  const ThemeChangeComponent({super.key});

  @override
  State<ThemeChangeComponent> createState() => _ThemeChangeComponentState();
}

class _ThemeChangeComponentState extends State<ThemeChangeComponent> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChangeProvider>(
        builder: (context, themeChangeProvider, child) {
        return DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                    themeChangeProvider.changeTheme();
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              );
        });
  }
}
