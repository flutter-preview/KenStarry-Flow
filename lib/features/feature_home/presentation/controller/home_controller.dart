import 'package:get/get.dart';

class HomeController extends GetxController {

  /// Current selected tab index
  final currentTabIndex = 0.obs;

  void setBottomNavTabIndex({required int index}) => currentTabIndex.value = index;
}