import 'package:flutter/material.dart';

enum AppTheme { Light, Dark }

final appThemes = {
  AppTheme.Light: ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
  ),
  AppTheme.Dark: ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
  )
};

AppTheme currentTheme = AppTheme.Dark;

Color getButtonTextColor(Color mainColor) {
  switch (mainColor.value) {
    // dark blue
    case (4278190335):
      return Colors.white;
  }
  return getDefaultButtonTextColor();
}

Color getDefaultButtonFrontColor() {
  switch (currentTheme) {
    case AppTheme.Light:
      return Colors.white;
    case AppTheme.Dark:
      return Colors.black;
  }
}

Color getDefaultButtonTextColor() {
  switch (currentTheme) {
    case AppTheme.Light:
      return Colors.black;
    case AppTheme.Dark:
      return Colors.white;
  }
}

Color getDefaultIconColor() {
  switch (currentTheme) {
    case AppTheme.Light:
      return Colors.black;
    case AppTheme.Dark:
      return Colors.white;
  }
}

