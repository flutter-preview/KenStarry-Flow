import 'package:azlistview/azlistview.dart';
import 'package:flow/core/presentation/components/show_player_bottom_sheet.dart';
import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/core/domain/models/player_states.dart';
import 'package:flow/core/presentation/controller/user_controller.dart';
import 'package:flow/features/feature_songs/presentation/components/song_card.dart';
import 'package:flow/features/feature_songs/presentation/controller/songs_controller.dart';
import 'package:flow/core/presentation/controller/player_controller.dart';
import 'package:flow/features/feature_songs/presentation/components/songs_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../core/domain/models/player_prefs.dart';
import '../../../core/utils/hive_utils.dart';

class SongsScreen extends StatefulWidget {
  const SongsScreen({
    super.key,
  });

  @override
  State<SongsScreen> createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen> {
  late final PlayerController _playerController;
  late final CoreController _coreController;
  late final SongsController _homeController;
  late final UserController _userController;
  late final ItemScrollController _scrollController;
  late final FToast _toast;

  @override
  void initState() {
    super.initState();

    _playerController = Get.find();
    _coreController = Get.find();
    _homeController = Get.find();
    _userController = Get.find();
    _scrollController = ItemScrollController();
    _toast = FToast();
    _toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 8),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            songsAppBar(toast: _toast),
            SliverFillRemaining(
              child: AzListView(
                  data: _playerController.azSongs,
                  itemScrollController: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  indexBarOptions: IndexBarOptions(
                      needRebuild: true,
                      textStyle: Theme.of(context).textTheme.bodySmall!,
                      selectTextStyle: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.fontSize,
                          fontWeight: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.fontWeight,
                          color: Colors.black),
                      selectItemDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Theme.of(context).primaryColor),
                      indexHintAlignment: Alignment.centerRight,
                      indexHintOffset: Offset(-15, 0)),
                  indexBarMargin: EdgeInsets.symmetric(vertical: 16),
                  indexHintBuilder: (context, hint) => Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: Center(
                      child: Text(hint,
                          style: TextStyle(
                              fontWeight: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.fontWeight,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.fontSize,
                              color: Colors.black)),
                    ),
                  ),
                  itemCount: _playerController.mediaItemsInitial.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8, left: 8, right: 24),
                    child: SongCard(
                      song: _playerController.mediaItemsInitial[index],
                      songIndex: index,
                      coreController: _coreController,
                      playerController: _playerController,
                      onSongTapped: () async {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _playerController.addPlaylistSongsToQueue(
                              mediaItems:
                              _playerController.mediaItemsInitial,
                              songIndex: index);
                        });

                        //  Save index to database
                        _playerController.updatePlayerPrefs(
                            playerPrefs:
                            PlayerPrefs(currentSongIndex: index));

                        //  DISABLE SHUFFLE MODE
                        if (_playerController
                            .isShuffleModeEnabled.value) {
                          await _playerController.disableShuffle();
                          //  Reenable shuffle
                          // _playerController.shuffleSongs();
                        }

                        if (_playerController.playerState.value ==
                            PlayerStates.playing &&
                            _playerController
                                .currentPlayingSongIndex.value ==
                                index) {
                          //  open player screen bottom sheet
                          showPlayerBottomSheet(
                              playerController: _playerController,
                              homeController: _homeController);
                        } else {
                          _playerController.playSongAtIndex(
                              index: index);

                          //  open player screen bottom sheet
                          showPlayerBottomSheet(
                              playerController: _playerController,
                              homeController: _homeController);
                        }
                      },
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
