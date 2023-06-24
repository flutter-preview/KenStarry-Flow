import 'package:flow/features/feature_settings/domain/model/settings_card_model.dart';
import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {

  final SettingsCardModel settingsCardModel;
  final VoidCallback onCardClicked;

  const SettingsCard({super.key, required this.settingsCardModel, required this.onCardClicked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardClicked,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          borderRadius: BorderRadius.circular(16)
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            //  icon
            Icon(settingsCardModel.iconData, size: 24, color: settingsCardModel.color,),
            const SizedBox(width: 8,),
            //  title
            Text(settingsCardModel.title, style: Theme.of(context).textTheme.bodyLarge,)
          ],
        ),
      ),
    );
  }
}
