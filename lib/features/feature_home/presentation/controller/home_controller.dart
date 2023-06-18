import 'package:flow/features/feature_main/presentation/components/artists_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../feature_main/presentation/components/my_appbar.dart';

class HomeController extends GetxController {

  /// Current selected tab index
  final currentTabIndex = 0.obs;

  /// Bottom bar collapsed state
  final isBottomBarCollapsed = false.obs;

  void setBottomNavTabIndex({required int index}) {
    currentTabIndex.value = index;
  }

  void setBottomBarCollapsedState({required bool isCollapsed}) => isBottomBarCollapsed.value = isCollapsed;
}