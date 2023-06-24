import 'package:get/get.dart';

class ThemeController extends GetxController {

  /// Theme Setting
  final selectedThemeIndex = 0.obs;

  void setSelectedThemeIndex({required int index}) => selectedThemeIndex.value = index;
}