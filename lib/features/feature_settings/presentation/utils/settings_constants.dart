import 'package:flow/features/feature_settings/presentation/components/settings_card.dart';
import 'package:flutter/material.dart';

class SettingsConstants {

  static const settings = [
    SettingsCard(title: "Theme", iconData: Icons.dark_mode_rounded, color: Colors.orangeAccent),
    SettingsCard(title: "Player", iconData: Icons.play_arrow_rounded, color: Colors.greenAccent),
  ];
}