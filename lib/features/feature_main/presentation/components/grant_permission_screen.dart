import 'package:flow/core/presentation/components/my_lottie.dart';
import 'package:flow/core/presentation/controller/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GrantPermissionPage extends StatelessWidget {
  final PlayerController _playerController = Get.find<PlayerController>();

  GrantPermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //  app name
            Text(
              "Flow",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24,),
            //  lottie
            const MyLottie(lottie: 'assets/lottie/flow_music_alt.json'),
            const SizedBox(height: 24,),
            Center(
                child: FilledButton(
              child: const Text("Permission not granted"),
              onPressed: () {
                _playerController.checkPermission();
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor)),
            ))
          ],
        ),
      ),
    );
  }
}
