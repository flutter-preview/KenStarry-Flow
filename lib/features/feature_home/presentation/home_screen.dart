import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/core/utils/extensions.dart';
import 'package:flow/features/feature_home/presentation/components/my_appbar.dart';
import 'package:flow/features/feature_home/presentation/controller/player_controller.dart';
import 'package:flow/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:get/get.dart';

import 'components/home_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PlayerController _playerController;
  late final CoreController _coreController;

  @override
  void initState() {
    super.initState();

    _playerController = Get.find<PlayerController>();
    _coreController = Get.find<CoreController>();
  }

  @override
  Widget build(BuildContext context) {
    /// Check for storage permissions
    _playerController.checkPermission();

    return Obx(
      () => AnnotatedRegion(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
            systemNavigationBarIconBrightness: _coreController.isDarkMode.value
                ? Brightness.light
                : Brightness.dark),
        child: Scaffold(
          appBar: myAppBar(controller: _coreController),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: HomeContent(
            playerController: _playerController,
            coreController: _coreController,
          ),
        ),
      ),
    );
  }
}
