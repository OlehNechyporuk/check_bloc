import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color.fromRGBO(62, 97, 255, 1);
  static const blacBack = Color.fromRGBO(55, 55, 55, 1);
  static const textColor = Color.fromRGBO(109, 109, 109, 1);
  static const textWhiteColor = Color.fromRGBO(255, 255, 255, 1);
}

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryColor,
    brightness: Brightness.light,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
);
