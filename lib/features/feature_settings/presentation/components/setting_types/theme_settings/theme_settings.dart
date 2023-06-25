import 'package:flow/core/presentation/controller/user_controller.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/accent_section.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/appearance_section.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/theme_setting_appbar.dart';
import 'package:flow/theme/colors.dart';
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
        const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(child: AppearanceSection())),

        //  Accent Picker section
        const SliverPadding(padding: EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverToBoxAdapter(child: AccentSection(),),),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),

        //  save and discard buttons
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).scaffoldBackgroundColor),
                      foregroundColor: MaterialStateProperty.all(accent),
                    ),
                    child: Text("Discard")),
                const SizedBox(
                  width: 16,
                ),
                FilledButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(accent)),
                    child: Text("Save")),
              ],
            ),
          ),
        )
      ],
    );
  }
}
