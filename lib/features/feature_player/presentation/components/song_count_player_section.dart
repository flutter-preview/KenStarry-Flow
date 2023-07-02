import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/presentation/controller/player_controller.dart';

class SongCountPlayerSection extends StatefulWidget {
  const SongCountPlayerSection({super.key});

  @override
  State<SongCountPlayerSection> createState() => _SongCountPlayerSectionState();
}

class _SongCountPlayerSectionState extends State<SongCountPlayerSection> {

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
