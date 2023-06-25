import 'package:flow/core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../../core/utils/extensions/color_extensions.dart';
import '../../../controller/theme_controller.dart';

class ColorPickerDialog extends StatefulWidget {
  const ColorPickerDialog({super.key});

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  late final ThemeController _themeController;

  @override
  void initState() {
    super.initState();

    _themeController = Get.find<ThemeController>();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //  color picker
          ColorPicker(
              pickerColor: _themeController.selectedAccentColorHex.value.toColor,
              enableAlpha: true,
              labelTypes: [],
              hexInputBar: true,
              onColorChanged: (col) {
                //  save this color to the theme controller
                _themeController.setSelectedAccentColorHex(hex: col.toHex);
              }),

          Obx(
            () => Align(
              alignment: AlignmentDirectional.centerEnd,
              child: UnconstrainedBox(
                child: FilledButton(
                    onPressed: () => Get.back(),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            _themeController
                                .selectedAccentColorHex.value.toColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          "Save",
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.fontSize,
                              fontWeight: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.fontWeight,
                              color: getTextColorForBackground(_themeController
                                  .selectedAccentColorHex.value.toColor)),
                        ),
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
