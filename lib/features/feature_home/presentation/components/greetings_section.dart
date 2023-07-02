import 'package:flow/core/presentation/controller/player_controller.dart';
import 'package:flow/features/feature_home/domain/model/time_of_day.dart';
import 'package:flow/features/feature_home/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GreetingsSection extends StatefulWidget {
  const GreetingsSection({super.key});

  @override
  State<GreetingsSection> createState() => _GreetingsSectionState();
}

class _GreetingsSectionState extends State<GreetingsSection> {
  late final PlayerController _playerController;
  late final HomeController _homeController;

  @override
  void initState() {
    super.initState();

    _playerController = Get.find();
    _homeController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  _homeController.timeOfDay.value == MyTimeOfDay.morning
                      ? Icons.sunny
                      : _homeController.timeOfDay.value == MyTimeOfDay.afternoon
                          ? Icons.cloud
                          : Icons.dark_mode_rounded,
                  color: Theme.of(context).primaryColor,
                  size: 24,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  _homeController.timeOfDay.value == MyTimeOfDay.morning
                      ? 'Good Morning'
                      : _homeController.timeOfDay.value == MyTimeOfDay.afternoon
                          ? 'Good Afternoon'
                          : 'Good Evening',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
