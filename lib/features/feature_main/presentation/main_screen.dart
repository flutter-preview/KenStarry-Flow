import 'package:azlistview/azlistview.dart';
import 'package:flow/core/domain/models/user.dart';
import 'package:flow/core/presentation/controller/user_controller.dart';
import 'package:flow/features/feature_artists/presentation/artists_screen.dart';
import 'package:flow/features/feature_home/presentation/home_screen.dart';
import 'package:flow/features/feature_songs/presentation/controller/songs_controller.dart';
import 'package:flow/features/feature_main/presentation/components/grant_permission_screen.dart';
import 'package:flow/features/feature_playlist/presentation/screens/playlist_screen.dart';
import 'package:flow/features/feature_settings/presentation/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../core/domain/models/player_prefs.dart';
import '../../../core/presentation/controller/core_controller.dart';
import '../../../core/utils/hive_utils.dart';
import '../../../di/locator.dart';
import '../../feature_songs/presentation/components/bottom_bar/home_bottom_bar.dart';
import '../../feature_songs/presentation/songs_screen.dart';
import '../../feature_songs/presentation/components/songs_appbar.dart';
import '../../../core/presentation/controller/player_controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final PlayerController _playerController;
  late final SongsController _homeController;
  late final CoreController _coreController;
  late final UserController _hiveController;
  late final List<Widget> _screens;
  final audioPlayer = locator.get<AudioPlayer>();

  @override
  void initState() {
    super.initState();

    _playerController = Get.find<PlayerController>();
    _coreController = Get.find<CoreController>();
    _homeController = Get.find<SongsController>();
    _hiveController = Get.find<UserController>();

    _screens = [
      const HomeScreen(),
      const SongsScreen(),
      const PlaylistScreen(),
      const SettingsScreen()
    ];
    _playerController.isSongPlaying();
  }

  @override
  Widget build(BuildContext context) {
    /// Listen for songs playing
    _playerController.isSongPlaying();

    return ValueListenableBuilder(
        valueListenable: _hiveController.userPrefs.value,
        builder: (context, box, widget) {
          final userPrefs = box.get('user') as User?;

          return AnnotatedRegion(
              value: SystemUiOverlayStyle(
                  systemNavigationBarColor:
                      Theme.of(context).scaffoldBackgroundColor,
                  systemNavigationBarIconBrightness:
                      _coreController.brightness.value == Brightness.dark
                          ? Brightness.light
                          : Brightness.dark),
              child: Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: userPrefs!.hasGrantedPermission!
                    ? FutureBuilder<List<SongModel>>(
                        future: _playerController.getSongs(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor));
                          }
                          if (snapshot.data == null) {
                            return const Text(
                              "No data found",
                              style: TextStyle(color: Colors.white),
                            );
                          }

                          if (snapshot.data!.isEmpty) {
                            return const Text("Empty data",
                                style: TextStyle(color: Colors.white));
                          }

                          //  my songs
                          var songs = snapshot.data!;
                          _playerController.initializeSongs(
                              songs: songs,);

                          return Stack(fit: StackFit.loose, children: [
                            Obx(
                              () => IndexedStack(
                                index: _homeController.currentTabIndex.value,
                                children: _screens,
                              ),
                            ),

                            //  Floating bottom bar
                            const Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: HomeBottomBar(),
                            )
                          ]);
                        },
                      )
                    : GrantPermissionPage(),
              ));
        });
  }
}
