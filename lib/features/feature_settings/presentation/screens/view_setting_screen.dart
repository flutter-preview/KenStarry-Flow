import 'package:flow/features/feature_settings/domain/model/setting_type.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings.dart';
import 'package:flutter/material.dart';

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
        return ThemeSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
