import 'package:flow/core/utils/extensions/string_extensions.dart';
import 'package:flow/features/feature_settings/domain/model/settings_card_model.dart';
import 'package:flow/features/feature_settings/presentation/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsCard extends StatefulWidget {
  final SettingsCardModel settingsCardModel;
  final VoidCallback onCardClicked;

  const SettingsCard(
      {super.key,
      required this.settingsCardModel,
      required this.onCardClicked});

  @override
  State<SettingsCard> createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  late final ThemeController _themeController;

  @override
  void initState() {
    super.initState();

    _themeController = Get.find<ThemeController>();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onCardClicked,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            //  icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                borderRadius: BorderRadius.circular(100)
              ),
              child: Icon(
                widget.settingsCardModel.iconData,
                size: 24,
                color: _themeController.selectedAccentColorHex.value.toColor as Color,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            //  title
            Text(
              widget.settingsCardModel.title,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}
