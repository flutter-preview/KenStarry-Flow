import 'package:flow/features/feature_main/presentation/components/artists_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../feature_main/presentation/components/my_appbar.dart';

class HomeController extends GetxController {

  /// Current selected tab index
  final currentTabIndex = 0.obs;

  /// Bottom bar collapsed state
  final isBottomBarCollapsed = false.obs;

  /// Main Appbar
  final Rx<PreferredSizeWidget?> mainAppBar = myAppBar().obs;

  void setBottomNavTabIndex({required int index}) {
    currentTabIndex.value = index;

    //  change the app bar
    switch (index) {
      case 0:
        mainAppBar.value = myAppBar();
        break;
      case 1:
        mainAppBar.value = myAppBar();
        break;
      case 2:
        mainAppBar.value = null;
        break;
      case 3:
        mainAppBar.value = myAppBar();
        break;
    }
  }

  void setBottomBarCollapsedState({required bool isCollapsed}) => isBottomBarCollapsed.value = isCollapsed;
}