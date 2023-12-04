import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/theme/custom_color.dart';

class ThemeChangeProvider with ChangeNotifier {
  static bool defaultTheme = true;
  Color _color = Colors.black;
  Color get color => _color;

  static Map<CustomColor, Color>? _theme = {
    CustomColor.primary: const Color(0xff009688),
    CustomColor.secondary: const Color(0xffFFC107),
    CustomColor.tertiary: const Color(0xff03A9F4),
    CustomColor.background: const Color(0xffF5F5F5),
    CustomColor.text: const Color(0xff333333),
  };

  static Map<CustomColor, Color>? get theme => _theme;

  // static Map<CustomColor, Color>? getTheme() {
  //   // ignore: avoid_print
  //   print('bla bla bla bla');
  //   print(_theme);
  //   return _theme;
  // }

static void setTheme(String value) {
  if(value == 'Default'){
  _theme =  {
    CustomColor.primary: const Color(0xff009688),
    CustomColor.secondary: const Color(0xffFFC107),
    CustomColor.tertiary: const Color(0xff03A9F4),
    CustomColor.background: const Color(0xffF5F5F5),
    CustomColor.text: const Color(0xff333333),
  };}
  else if (value == 'Dark') {
  _theme = {
    CustomColor.primary: Color.fromARGB(255, 0, 0, 0),
    CustomColor.secondary: Color.fromARGB(255, 116, 88, 3),
    CustomColor.tertiary: Color.fromARGB(255, 53, 89, 106),
    CustomColor.background: Color.fromARGB(255, 255, 0, 0),
    CustomColor.text: Color.fromARGB(255, 255, 255, 255),
  };}
}
      
  void changeTheme(String value) {
    // defaultTheme = !defaultTheme;
    setTheme(value);
    // print(_theme);
    // getTheme();
    // if(_color == Colors.black)
    // {
    // _color = Colors.blue;
    // }
    // else {
    //   _color = Colors.black;
    // }
    notifyListeners();
  }
}