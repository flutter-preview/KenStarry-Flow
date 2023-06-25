import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/color_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showPickColorDialog() =>
    showDialog(context: Get.context!, builder: (context) => AlertDialog(
      title: Text("Pick Accent Color"),
      titleTextStyle: Theme.of(context).textTheme.titleSmall,
      icon: Icon(Icons.color_lens_rounded, color: Theme.of(context).iconTheme.color),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      content: const ColorPickerDialog(),
    ));
