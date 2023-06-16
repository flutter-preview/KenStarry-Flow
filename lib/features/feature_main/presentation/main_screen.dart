import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:just_audio/just_audio.dart';

import '../../../core/presentation/controller/core_controller.dart';
import '../../../di/locator.dart';
import '../../feature_home/presentation/home_screen.dart';
import '../../feature_home/presentation/components/my_appbar.dart';
import '../../feature_home/presentation/controller/player_controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final PlayerController _playerController;
  late final CoreController _coreController;
  final audioPlayer = locator.get<AudioPlayer>();

  @override
  void initState() {
    super.initState();

    _playerController = Get.find<PlayerController>();
    _coreController = Get.find<CoreController>();

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
            systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
            systemNavigationBarIconBrightness: _coreController.brightness.value == Brightness.dark
                ? Brightness.light
                : Brightness.dark),
        child: Scaffold(
          appBar: myAppBar(controller: _coreController),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: HomeScreen(
            playerController: _playerController,
            coreController: _coreController,
          ),
        ),
      ),
    );
  }
}
