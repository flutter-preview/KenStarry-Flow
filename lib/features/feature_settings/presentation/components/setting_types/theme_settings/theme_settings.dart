import 'package:flow/core/presentation/controller/user_controller.dart';
import 'package:flow/core/utils/extensions/color_extensions.dart';
import 'package:flow/core/utils/extensions/string_extensions.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/accent_section.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/appearance_section.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/theme_setting_appbar.dart';
import 'package:flow/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/theme_controller.dart';

class ThemeSettings extends StatefulWidget {
  const ThemeSettings({super.key});

  @override
  State<ThemeSettings> createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> {
  late final ThemeController _themeController;

  @override
  void initState() {
    super.initState();

    _themeController = Get.find<ThemeController>();
  }

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
        const SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: AccentSection(),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),

        //  save and discard buttons
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).scaffoldBackgroundColor),
                        foregroundColor: MaterialStateProperty.all(
                            (_themeController.selectedAccentColorHex.value
                                .toColor as Color)),
                      ),
                      child: Text("Discard")),
                ),
                const SizedBox(
                  width: 16,
                ),
                Obx(
                  () => FilledButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              (_themeController.selectedAccentColorHex.value
                                  .toColor as Color))),
                      child: Text(
                        "Save",
                        style: TextStyle(
                            fontWeight: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.fontWeight,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.fontSize,
                            color: getTextColorForBackground((_themeController
                                .selectedAccentColorHex
                                .value
                                .toColor as Color))),
                      )),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
