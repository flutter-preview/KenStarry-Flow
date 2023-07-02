import 'package:flow/core/utils/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/colors.dart';

class ThemeController extends GetxController {
  /// Theme Setting
  final selectedThemeIndex = 0.obs;
  final selectedThemeMode = ThemeMode.system.obs;
  final selectedAccentColorHex = predefinedAccentColors[0].toHex.obs;

  final themeTypes = const ['Light Theme', 'Dark Theme', 'System Preferences'];

  final themeModes = const {
    'Light Theme': ThemeMode.light,
    'Dark Theme': ThemeMode.dark,
    'System Preferences': ThemeMode.system
  };

  void setSelectedThemeIndex({required int index}) =>
      selectedThemeIndex.value = index;

  ThemeMode setThemeMode({required ThemeMode mode}) =>
      selectedThemeMode.value = mode;

  void setSelectedAccentColorHex({required String hex}) =>
      selectedAccentColorHex.value = hex;
}
