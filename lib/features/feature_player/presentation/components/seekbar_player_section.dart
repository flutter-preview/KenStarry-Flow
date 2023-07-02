import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/presentation/controller/player_controller.dart';

class SeekbarPlayerSection extends StatefulWidget {
  const SeekbarPlayerSection({super.key});

  @override
  State<SeekbarPlayerSection> createState() => _SeekbarPlayerSectionState();
}

class _SeekbarPlayerSectionState extends State<SeekbarPlayerSection> {

  late final PlayerController _playerController;

  @override
  void initState() {
    super.initState();

    _playerController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
