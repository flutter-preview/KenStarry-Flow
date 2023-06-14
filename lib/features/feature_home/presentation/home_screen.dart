import 'package:flow/core/utils/extensions.dart';
import 'package:flow/features/feature_home/presentation/controller/player_controller.dart';
import 'package:flow/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PlayerController _playerController;

  @override
  void initState() {
    super.initState();

    _playerController = Get.find<PlayerController>();
  }

  @override
  Widget build(BuildContext context) {
    _playerController.checkPermission();

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          systemNavigationBarColor: bgColor,
          systemNavigationBarIconBrightness: Brightness.light),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Flow").addGradient,
          centerTitle: true,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: bgColor,
              statusBarIconBrightness: Brightness.light),
        ),
        backgroundColor: bgColor,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _playerController.isPermissionGranted.value
              ? FutureBuilder<List<SongModel>>(
                  future: _playerController.getSongs(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const Text(
                        "No data found",
                        style: TextStyle(color: Colors.white),
                      );
                    }

                    if (snapshot.data!.isEmpty) {
                      return const Text("Empty data",
                          style: TextStyle(color: Colors.white));
                    }
                    return Container(
                      color: Colors.red,
                    );
                  },
                )
              : Text("Permission not granted"),
        )),
      ),
    );
  }
}
