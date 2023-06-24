import 'package:flow/features/feature_settings/presentation/components/settings_appbar.dart';
import 'package:flow/features/feature_settings/presentation/components/settings_card.dart';
import 'package:flow/features/feature_settings/presentation/utils/settings_constants.dart';
import 'package:flutter/material.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                delegate: SliverChildBuilderDelegate(
                    (context, index) => SettingsCard(
                        settingsCardModel: SettingsConstants.settings[index],
                    onCardClicked: (){},),
                    childCount: SettingsConstants.settings.length)),
          )
        ],
      ),
    );
  }
}
