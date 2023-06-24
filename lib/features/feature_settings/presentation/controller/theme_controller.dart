import 'package:get/get.dart';

class ThemeController extends GetxController {

  /// Theme Setting
  final selectedThemeIndex = 0.obs;

  final themeTypes = const ['Light Theme', 'Dark Theme', 'System Preferences'];

  void setSelectedThemeIndex({required int index}) => selectedThemeIndex.value = index;
}