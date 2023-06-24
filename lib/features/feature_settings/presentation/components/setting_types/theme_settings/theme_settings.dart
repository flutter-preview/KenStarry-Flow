import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/appearance_section.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/theme_setting_appbar.dart';
import 'package:flutter/material.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

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
