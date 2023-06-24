import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/core/presentation/controller/user_controller.dart';
import 'package:flow/features/feature_artists/presentation/controller/artists_controller.dart';
import 'package:flow/features/feature_home/presentation/controller/home_controller.dart';
import 'package:flow/core/presentation/controller/player_controller.dart';
import 'package:flow/features/feature_playlist/presentation/controller/playlist_controller.dart';
import 'package:flow/features/feature_settings/presentation/controller/theme_controller.dart';
import 'package:get/get.dart';

void initializeControllers() {
  Get.lazyPut(() => CoreController());
  Get.lazyPut(() => PlayerController());
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => ArtistsController());
  Get.lazyPut(() => UserController());
  Get.lazyPut(() => PlaylistController());
  Get.lazyPut(() => ThemeController());
}
