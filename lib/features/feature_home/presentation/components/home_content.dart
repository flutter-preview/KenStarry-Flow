import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/features/feature_home/presentation/controller/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../theme/colors.dart';

class HomeContent extends StatelessWidget {
  final PlayerController playerController;
  final CoreController coreController;

  const HomeContent(
      {super.key,
      required this.playerController,
      required this.coreController});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Padding(
        padding: const EdgeInsets.all(16.0),
        child: playerController.isPermissionGranted.value
            ? FutureBuilder<List<SongModel>>(
                future: playerController.getSongs(),
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
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                    ),
                  );
                },
              )
            : Text("Permission not granted"),
      ),
    ));
  }
}
