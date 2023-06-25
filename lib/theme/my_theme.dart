import 'package:flow/core/utils/extensions/color_extensions.dart';
import 'package:flow/features/feature_settings/presentation/controller/theme_controller.dart';
import 'package:flow/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTheme {
  final Color accent;

  MyTheme({required this.accent});

  /// Light Theme
  ThemeData get lightTheme => ThemeData(
      primaryColor: accent,
      scaffoldBackgroundColor: bgColorLightMode,
      primaryColorDark: accent.lightenColor(92),
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
            fontSize: 20, fontWeight: FontWeight.bold, color: textBlack900),
        titleLarge: TextStyle(
            fontSize: 26, fontWeight: FontWeight.bold, color: textBlack900),
      ));

  /// Dark Theme
  ThemeData get darkTheme => ThemeData(
      primaryColor: accent,
      scaffoldBackgroundColor: bgColorDarkMode,
      primaryColorDark: accent.darkenColor(80),
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
            fontSize: 20, fontWeight: FontWeight.bold, color: textWhite900),
        titleLarge: TextStyle(
            fontSize: 26, fontWeight: FontWeight.bold, color: textWhite900),
      ));
}
