import 'package:flow/features/feature_settings/domain/model/setting_type.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/player_settings.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewSettingScreen extends StatefulWidget {
  final SettingType type;

  const ViewSettingScreen({super.key, required this.type});

  @override
  State<ViewSettingScreen> createState() => _ViewSettingScreenState();
}

class _ViewSettingScreenState extends State<ViewSettingScreen> {
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
      appBar: AppBar(
        title: Text(
          getTitle(type: widget.type),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(canPop: true),
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).iconTheme.color,
            )),
      ),
    );
  }
}
