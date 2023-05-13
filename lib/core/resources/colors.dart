import 'package:flutter/material.dart';

enum AppThemeMode {
  dark, light
}

abstract class AppThemeColors {

  Color get primaryColor;

  Color get grey;

  Color get editingGray;

  Color get backgroundColor;

  Color get white;

  Color get black;

  Color get secondaryColor;

  Color get accentColor;
  Color get lightblue;
  Color get redColor;


}
class LightModeColors extends AppThemeColors {

  @override
  Color get primaryColor => Colors.blue[900];

  @override
  Color get backgroundColor => const Color(0xfffffdfe);

  @override
  Color get grey => Colors.grey;

  @override
  Color get white => Colors.white;

  @override
  Color get black => Colors.black;

  @override
  Color get secondaryColor => const  Color(0xff2f2e41);

  @override
  Color get accentColor => const Color(0xffe6e6e6);

  @override
  Color get editingGray => const Color(0xffC0C0C0);

  @override
  // TODO: implement lightblue
  Color get lightblue => Colors.blue;

  @override
  // TODO: implement redColor
  Color get redColor => Colors.red[300];


}

class DarkModeColors extends AppThemeColors {

  @override
  Color get primaryColor => const Color(0xffE12456);

  @override
  Color get backgroundColor => const Color(0xff00000e);

  @override
  Color get grey => Colors.grey;

  @override
  Color get white => Colors.white;

  @override
  Color get black => Colors.black;

  @override
  Color get secondaryColor => const  Color(0xff2f2e41);

  @override
  Color get accentColor => const Color(0xffe6e6e6);

  @override
  Color get editingGray => const Color(0xffC0C0C0);

  @override
  // TODO: implement lightblue
  Color get lightblue => const Color(0xffC6D4FF);

  @override
  // TODO: implement redColor
  Color get redColor =>  Colors.red;

}

class ThemeFactory {

  static AppThemeColors colorModeFactory(AppThemeMode appThemeMode) {
    switch (appThemeMode) {
      case AppThemeMode.light:
        return LightModeColors();
      case AppThemeMode.dark:
        return DarkModeColors();
      default:
        return LightModeColors();
    }
  }

  static ThemeMode currentTheme(AppThemeMode appThemeMode) {
    return appThemeMode == AppThemeMode.dark? ThemeMode.dark : ThemeMode.light;
  }

}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
