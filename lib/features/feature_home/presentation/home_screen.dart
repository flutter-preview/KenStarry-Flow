import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/core/utils/extensions.dart';
import 'package:flow/features/feature_home/presentation/components/my_appbar.dart';
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
  late final CoreController _coreController;

  @override
  void initState() {
    super.initState();

    _playerController = Get.find<PlayerController>();
    _coreController = Get.find<CoreController>();
  }

  @override
  Widget build(BuildContext context) {
    /// Check for storage permissions
    _playerController.checkPermission();

    return Obx(
      () => AnnotatedRegion(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
            systemNavigationBarIconBrightness: _coreController.isDarkMode.value
                ? Brightness.light
                : Brightness.dark),
        child: Scaffold(
          appBar: myAppBar(controller: _coreController),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
              child: Obx(
            () => Padding(
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

                        //  my songs
                        var songs = snapshot.data!;

                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: songs.length,
                            itemBuilder: (context, index) {
                              //  song item
                              return Container(
                                padding: const EdgeInsets.all(16),
                                color: bgDarkColor,
                                child: Column(
                                  children: [
                                    Text(
                                      songs[index].displayNameWOExt,
                                      style: TextStyle(color: Colors.white),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    // QueryArtworkWidget(id: songs[index].id, type: ArtworkType.AUDIO)
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 16,
                            ),
                          ),
                        );
                      },
                    )
                  : Text("Permission not granted"),
            ),
          )),
        ),
      ),
    );
  }
}
