import 'package:get/get.dart';

class HomeController extends GetxController {

  /// Current selected tab index
  final currentTabIndex = 0.obs;

  /// Bottom bar collapsed state
  final isBottomBarCollapsed = false.obs;

  void setBottomNavTabIndex({required int index}) => currentTabIndex.value = index;

  void setBottomBarCollapsedState({required bool isCollapsed}) => isBottomBarCollapsed.value = isCollapsed;
}