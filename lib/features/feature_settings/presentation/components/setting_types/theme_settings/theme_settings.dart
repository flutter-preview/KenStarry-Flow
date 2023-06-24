import 'package:flow/core/presentation/controller/user_controller.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/appearance_section.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/theme_setting_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeSettings extends StatefulWidget {
  const ThemeSettings({super.key});

  @override
  State<ThemeSettings> createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> {

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        //  app bar
        themeSettingAppBar(),
        //  appearance section
        SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(child: AppearanceSection()))
      ],
    );
  }
}
