import 'package:flow/features/feature_settings/domain/model/settings_card_model.dart';
import 'package:flow/features/feature_settings/presentation/components/settings_card.dart';
import 'package:flutter/material.dart';

class SettingsConstants {

  static var settings = <SettingsCardModel>[
    SettingsCardModel(title: "Theme", iconData: Icons.dark_mode_rounded, color: Colors.orangeAccent),
    SettingsCardModel(title: "Player", iconData: Icons.play_arrow_rounded, color: Colors.greenAccent),
  ];
}