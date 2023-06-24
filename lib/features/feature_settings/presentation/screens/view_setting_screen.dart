import 'package:flow/features/feature_settings/domain/model/setting_type.dart';
import 'package:flutter/material.dart';

class ViewSettingScreen extends StatefulWidget {
  final SettingType type;

  const ViewSettingScreen({super.key, required this.type});

  @override
  State<ViewSettingScreen> createState() => _ViewSettingScreenState();
}

class _ViewSettingScreenState extends State<ViewSettingScreen> {
  @override
  Widget build(BuildContext context) {

    print(widget.type);

    return const Placeholder();
  }
}
