import 'package:flow/theme/colors.dart';
import 'package:flutter/material.dart';

class MyTheme {
  /// Light Theme
  static ThemeData get lightTheme => ThemeData(
      primaryColor: accent,
      scaffoldBackgroundColor: bgColorLightMode,
      primaryColorDark: accentLight,
      iconTheme: const IconThemeData(color: textBlack300),
      fontFamily: 'Poppins',
      textTheme: const TextTheme(
        bodySmall: TextStyle(
            fontSize: 12, fontWeight: FontWeight.w500, color: textBlack300),
        bodyMedium: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: textBlack500),
        bodyLarge: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: textBlack500),
        titleSmall: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700, color: textBlack500),
        titleMedium: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: textBlack900),
        titleLarge: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: textBlack900),
      ));

  /// Dark Theme
  static ThemeData get darkTheme => ThemeData(
      primaryColor: accent,
      scaffoldBackgroundColor: bgColorDarkMode,
      primaryColorDark: bgDarkColor,
      iconTheme: const IconThemeData(color: textWhite300),
      fontFamily: 'Poppins',
      textTheme: const TextTheme(
        bodySmall: TextStyle(
            fontSize: 12, fontWeight: FontWeight.w500, color: textWhite300),
        bodyMedium: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: textWhite500),
        bodyLarge: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: textWhite500),
        titleSmall: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700, color: textWhite500),
        titleMedium: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: textWhite900),
        titleLarge: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: textWhite900),
      ));
}
