import 'package:flow/core/utils/extensions/color_extensions.dart';
import 'package:flow/features/feature_settings/domain/model/setting_type.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/player_settings.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/controller/core_controller.dart';

class ViewSettingScreen extends StatefulWidget {
  final SettingType type;

  const ViewSettingScreen({super.key, required this.type});

  @override
  State<ViewSettingScreen> createState() => _ViewSettingScreenState();
}

class _ViewSettingScreenState extends State<ViewSettingScreen> {
  late final CoreController _coreController;

  @override
  void initState() {
    super.initState();

    _coreController = Get.find<CoreController>();
  }

  Widget getScreen({required SettingType type}) {
    switch (type) {
      case SettingType.theme:
        return ThemeSettings();
      case SettingType.player:
        return PlayerSettings();
    }
  }

  String getTitle({required SettingType type}) {
    switch (type) {
      case SettingType.theme:
        return "Theme";
      case SettingType.player:
        return "Player";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getScreen(type: widget.type)
    );
  }
}
