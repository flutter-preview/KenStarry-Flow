import 'package:flow/features/feature_main/presentation/components/artists_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../feature_main/presentation/components/my_appbar.dart';

class HomeController extends GetxController {
  /// Current selected tab index
  final currentTabIndex = 0.obs;

  /// Bottom bar collapsed state
  final isBottomBarCollapsed = false.obs;

  /// Hide Bottom bar
  final isBottomBarHidden = false.obs;

  /// List Controller
  final AutoScrollController controller = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(Get.context!).padding.bottom),
      axis: Axis.vertical);

  void setBottomNavTabIndex({required int index}) {
    currentTabIndex.value = index;
  }

  void setBottomBarHiddenState({required bool isHidden}) => isBottomBarHidden.value = isHidden;

  void setBottomBarCollapsedState({required bool isCollapsed}) =>
      isBottomBarCollapsed.value = isCollapsed;

  Future<void> scrollToIndex(
          {required int index,
          AutoScrollPosition preferPosition = AutoScrollPosition.middle}) async =>
      controller.scrollToIndex(index,
          preferPosition: preferPosition, duration: const Duration(milliseconds: 10));
}
