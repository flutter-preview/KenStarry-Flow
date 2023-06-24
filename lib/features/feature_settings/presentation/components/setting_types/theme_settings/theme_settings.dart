import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/appearance_section.dart';
import 'package:flutter/material.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //  appearance
        AppearanceSection()
        //  accent color
      ],
    );
  }
}
