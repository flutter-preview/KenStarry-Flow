import 'package:flow/features/feature_home/presentation/components/bottom_bar/bottom_bar_item.dart';
import 'package:flow/features/feature_home/presentation/controller/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({super.key});

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  late final PlayerController _playerController;

  @override
  void initState() {
    super.initState();
    _playerController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 10,
              blurRadius: 30,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => Wrap(
            alignment: WrapAlignment.start,
            runSpacing: 16,
            children: [
              //  Bottom Nav Currently playing music
              _playerController.songs.isNotEmpty
                  ? Row(
                      children: [
                        //  track name
                        Flexible(
                          child: Text(
                            _playerController
                                .songs[_playerController
                                    .currentPlayingSongIndex.value!].displayNameWOExt,
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        
                        //  play icon
                        IconButton(onPressed: (){}, icon: const Icon(Icons.play_arrow_rounded))
                        //  seekbar
                        //  elapsed time
                      ],
                    )
                  : const SizedBox.shrink(),
              //  Bottom nav icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //  home icon
                  bottomBarItem(title: "Home", icon: Icons.home),
                  bottomBarItem(
                      title: "Playlist", icon: Icons.playlist_play_rounded),
                  bottomBarItem(title: "Genres", icon: Icons.music_note_outlined),
                  bottomBarItem(title: "Settings", icon: Icons.settings),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
