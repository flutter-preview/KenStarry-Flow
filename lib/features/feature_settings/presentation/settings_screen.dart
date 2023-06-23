import 'package:flow/features/feature_settings/presentation/components/settings_appbar.dart';
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
        slivers: [
          //  appbar
          settingsAppBar(),
          //  general settings
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => SettingsConstants.settings[index],
                  childCount: SettingsConstants.settings.length))
        ],
      ),
    );
  }
}
