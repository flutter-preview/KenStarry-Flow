import 'package:flow/core/utils/extensions/color_extensions.dart';
import 'package:flow/core/utils/extensions/string_extensions.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/accent_color_card.dart';
import 'package:flow/features/feature_settings/presentation/controller/theme_controller.dart';
import 'package:flow/features/feature_settings/presentation/utils/showPickColorDialog.dart';
import 'package:flow/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccentSection extends StatefulWidget {
  const AccentSection({super.key});

  @override
  State<AccentSection> createState() => _AccentSectionState();
}

class _AccentSectionState extends State<AccentSection> {
  late final ThemeController _themeController;

  @override
  void initState() {
    super.initState();

    _themeController = Get.find<ThemeController>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Accent",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Row(
              children: [
                Text(
                  "Pick custom color",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  width: 8,
                ),

                Icon(
                  Icons.chevron_right_rounded,
                  color: Theme.of(context).iconTheme.color,
                ),
                const SizedBox(
                  width: 8,
                ),

                //  open color picker
                Obx(
                  () => UnconstrainedBox(
                    child: FilledButton(
                        onPressed: () => showPickColorDialog(),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                _themeController
                                    .selectedAccentColorHex.value.toColor)),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.color_lens_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Color Picker",
                              style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.fontSize,
                                  fontWeight: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.fontWeight,
                                  color: getTextColorForBackground(
                                      _themeController.selectedAccentColorHex
                                          .value.toColor)),
                            ),
                          ],
                        )),
                  ),
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        //  predefined colors
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ListView.separated(
            itemCount: predefinedAccentColors.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Obx(
                () {
                  return AccentColorCard(
                      color: predefinedAccentColors[index],
                      isActive: predefinedAccentColors[index].toHex ==
                          _themeController.selectedAccentColorHex.value,
                      onTap: () => _themeController.setSelectedAccentColorHex(
                          hex: predefinedAccentColors[index].toHex));
                },
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 8,
            ),
          ),
        )
      ],
    );
  }
}
