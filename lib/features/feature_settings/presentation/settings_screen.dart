import 'package:flow/features/feature_settings/domain/model/setting_type.dart';
import 'package:flow/features/feature_settings/presentation/components/settings_appbar.dart';
import 'package:flow/features/feature_settings/presentation/components/settings_card.dart';
import 'package:flow/features/feature_settings/presentation/screens/view_setting_screen.dart';
import 'package:flow/features/feature_settings/presentation/utils/settings_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          //  appbar
          settingsAppBar(),
          //  general settings
          SliverPadding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                "General",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return SettingsCard(
                settingsCardModel: SettingsConstants.settings[index],
                onCardClicked: () {
                  //  open view settings screeen
                  switch (index) {
                    case 0:
                      Get.to(() =>
                          const ViewSettingScreen(type: SettingType.theme));
                      break;
                    case 1:
                      Get.to(() =>
                          const ViewSettingScreen(type: SettingType.player));
                      break;
                  }
                },
              );
            }, childCount: SettingsConstants.settings.length)),
          )
        ],
      ),
    );
  }
}
