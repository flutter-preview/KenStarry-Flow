import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  /// Theme Setting
  final selectedThemeIndex = 0.obs;
  final selectedThemeMode = ThemeMode.system.obs;
  final selectedAccentColorHexValue = ''.obs;

  final themeTypes = const ['Light Theme', 'Dark Theme', 'System Preferences'];

  final themeModes = const [ThemeMode.light, ThemeMode.dark, ThemeMode.system];

  void setSelectedThemeIndex({required int index}) =>
      selectedThemeIndex.value = index;

  ThemeMode setThemeMode({required ThemeMode mode}) =>
      selectedThemeMode.value = mode;

  void setSelectedAccentColorHexValue({required String hex}) =>
      selectedAccentColorHexValue.value = hex;
}
