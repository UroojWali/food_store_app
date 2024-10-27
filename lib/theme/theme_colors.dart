import 'package:flutter/material.dart';

abstract class ThemeColors {
  Color primaryColor = const Color(0xFF30d14e);
  Color primaryVariantColor = const Color(0xFFffffff);
  Color white = const Color(0xFFFFFFFF);
  Color blue = const Color(0xFF4a85fd);
  Color red = const Color(0xFFc42b1c);
  Color green = const Color(0xFF1dbf73);
  Color textColor = const Color(0xFF000000);

  static ThemeColors getThemeColors(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    if (brightness == Brightness.dark) {
      return DarkThemeColors();
    } else {
      return LightThemeColors();
    }
  }
}

class LightThemeColors extends ThemeColors {
  LightThemeColors() {
    super.primaryColor = const Color(0xFF229638);
    super.primaryVariantColor = const Color(0xFFffffff);
    super.white = const Color(0xFFFFFFFF);
    super.blue = const Color(0xFF4a85fd);
    super.red = const Color(0xFFc42b1c);
    super.green = const Color(0xFF1dbf73);
    super.textColor = const Color(0xFF000000);
  }
}

class DarkThemeColors extends ThemeColors {
  DarkThemeColors() {
    super.primaryColor = const Color(0xFF1d102d);
    super.primaryVariantColor = const Color(0xFFffffff);
    super.white = const Color(0xFFFFFFFF);
    super.blue = const Color(0xFF1e266b);
    super.red = const Color(0xFFc42b1c);
    super.green = const Color(0xFF1dbf73);
    textColor = const Color(0xFFFFFFFF);
  }
}
