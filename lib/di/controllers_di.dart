import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/features/feature_home/presentation/controller/home_controller.dart';
import 'package:flow/features/feature_home/presentation/controller/player_controller.dart';
import 'package:get/get.dart';

void initializeControllers() {
  Get.lazyPut(() => CoreController());
  Get.lazyPut(() => PlayerController());
  Get.lazyPut(() => HomeController());
}
