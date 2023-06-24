import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/light_theme_mockup.dart';
import 'package:flutter/material.dart';

class AppearanceSection extends StatelessWidget {
  const AppearanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Appearance", style: Theme.of(context).textTheme.titleSmall,),
        const SizedBox(height: 16,),
        LightThemeMockup()
      ],
    );
  }
}
