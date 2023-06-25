import 'package:flow/core/utils/extensions/color_extensions.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/accent_color_card.dart';
import 'package:flow/features/feature_settings/presentation/controller/theme_controller.dart';
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Accent",
              style: Theme.of(context).textTheme.titleSmall,
            ),

            //  open color picker
            FilledButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(accent),
                    foregroundColor: MaterialStateProperty.all(Colors.white)),
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
                          fontSize:
                              Theme.of(context).textTheme.bodyMedium?.fontSize,
                          fontWeight: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.fontWeight,
                          color: Colors.white),
                    ),
                  ],
                ))
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
                () => AccentColorCard(
                    color: predefinedAccentColors[index],
                    isActive: predefinedAccentColors[index].toHex ==
                        _themeController.selectedAccentColorHexValue.value,
                    onTap: () =>
                        _themeController.setSelectedAccentColorHexValue(
                            hex: predefinedAccentColors[index].toHex)),
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
