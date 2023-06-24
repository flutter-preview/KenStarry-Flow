import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/core/presentation/controller/user_controller.dart';
import 'package:flow/features/feature_artists/presentation/controller/artists_controller.dart';
import 'package:flow/features/feature_home/presentation/controller/home_controller.dart';
import 'package:flow/core/presentation/controller/player_controller.dart';
import 'package:flow/features/feature_playlist/presentation/controller/playlist_controller.dart';
import 'package:flow/features/feature_settings/presentation/controller/theme_controller.dart';
import 'package:get/get.dart';

void initializeControllers() {
  Get.lazyPut(() => CoreController(), fenix: true);
  Get.lazyPut(() => PlayerController(), fenix: true);
  Get.lazyPut(() => HomeController(), fenix: true);
  Get.lazyPut(() => ArtistsController(), fenix: true);
  Get.lazyPut(() => UserController(), fenix: true);
  Get.lazyPut(() => PlaylistController(), fenix: true);
  Get.lazyPut(() => ThemeController(), fenix: true);
}
