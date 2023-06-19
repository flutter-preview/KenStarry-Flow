import 'package:flow/features/feature_artists/presentation/artists_screen.dart';
import 'package:flow/features/feature_home/presentation/controller/home_controller.dart';
import 'package:flow/features/feature_playlist/presentation/playlist_screen.dart';
import 'package:flow/features/feature_settings/presentation/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:just_audio/just_audio.dart';

import '../../../core/presentation/controller/core_controller.dart';
import '../../../di/locator.dart';
import '../../feature_home/presentation/components/bottom_bar/home_bottom_bar.dart';
import '../../feature_home/presentation/home_screen.dart';
import 'components/my_appbar.dart';
import '../../../core/presentation/controller/player_controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final PlayerController _playerController;
  late final HomeController _homeController;
  late final CoreController _coreController;
  late final List<Widget> _screens;
  final audioPlayer = locator.get<AudioPlayer>();

  @override
  void initState() {
    super.initState();

    _playerController = Get.find<PlayerController>();
    _coreController = Get.find<CoreController>();
    _homeController = Get.find<HomeController>();

    _screens = [
      const HomeScreen(),
      const PlaylistScreen(),
      const ArtistsScreen(),
      const SettingsScreen()
    ];
    _playerController.isSongPlaying();
  }

  @override
  Widget build(BuildContext context) {
    /// Check for storage permissions
    _playerController.checkPermission();

    /// Listen for songs playing
    _playerController.isSongPlaying();
    return Obx(
      () => AnnotatedRegion(
          value: SystemUiOverlayStyle(
              systemNavigationBarColor:
                  Theme.of(context).scaffoldBackgroundColor,
              systemNavigationBarIconBrightness:
                  _coreController.brightness.value == Brightness.dark
                      ? Brightness.light
                      : Brightness.dark),
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Obx(
              () => _playerController.isPermissionGranted.value
                  ? Stack(fit: StackFit.loose, children: [
                      IndexedStack(
                        index: _homeController.currentTabIndex.value,
                        children: _screens,
                      ),

                      //  Floating bottom bar
                      const Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: HomeBottomBar(),
                      )
                    ])
                  : Center(
                      child: FilledButton(
                      child: const Text("Permission not granted"),
                      onPressed: () {
                        _playerController.checkPermission();
                      },
                    )),
            ),
          )),
    );
  }
}
