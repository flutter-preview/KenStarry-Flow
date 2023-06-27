import 'package:audio_service/audio_service.dart';
import 'package:azlistview/azlistview.dart';
import 'package:flow/core/domain/models/repeat_state.dart';
import 'package:flow/core/domain/models/user.dart';
import 'package:flow/core/presentation/controller/user_controller.dart';
import 'package:flow/core/presentation/notifiers/repeat_button_notifier.dart';
import 'package:flow/core/utils/math_utils.dart';
import 'package:flow/core/utils/songs_to_media_items.dart';
import 'package:flow/features/feature_home/domain/model/az_item.dart';
import 'package:flow/core/domain/use_cases/player_use_cases/player_use_case.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../di/locator.dart';
import '../../domain/models/player_states.dart';

class PlayerController extends GetxController {
  final playerUseCases = locator.get<PlayerUseCases>();
  final _audioHandler = locator.get<AudioHandler>();
  final _userController = Get.find<UserController>();

  final isPermissionGranted = false.obs;

  final RxList<SongModel> songs = <SongModel>[].obs;
  List<ISuspensionBean> azSongs =
      List<ISuspensionBean>.empty(growable: true).obs;

  final totalSongs = 0.obs;
  final totalSongsDuration = ''.obs;

  late List<MediaItem> mediaItemsInitial;
  late List<MediaItem> mediaItemsDynamic;

  // UI
  final duration = ''.obs;
  final position = ''.obs;
  final maxSlider = 0.0.obs;
  final sliderValue = 0.0.obs;

  // Index of the currently playing song
  final Rx<int?> currentPlayingSongIndex = 0.obs;
  final playerState = PlayerStates.stopped.obs;
  final repeatButtonState = RepeatState.off.obs;
  final isShuffleModeEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    _listenToChangesInPlaylist();
    _listenToPlaybackState();
    _listenToChangesInSong();
    _listenToCurrentPosition();
    _listenToTotalDuration();
  }

  /// Listen To Playlist changed from audio handler
  void _listenToChangesInPlaylist() {
    _audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) return;
      // songs.value = playlist.map((item) => SongModel()).toList();
      mediaItemsDynamic = playlist;
    });
  }

  /// Listen to Playback states
  void _listenToPlaybackState() {
    _audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;

      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        playerState.value = PlayerStates.paused;
      } else if (!isPlaying) {
        playerState.value = PlayerStates.paused;
      } else if (processingState != AudioProcessingState.completed) {
        playerState.value = PlayerStates.paused;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
    });
  }

  /// Listen to Currently Playing Media Item from Audio Handler
  void _listenToChangesInSong() {
    _audioHandler.mediaItem.listen((mediaItem) {
      currentPlayingSongIndex.value = mediaItemsInitial.indexOf(mediaItem!);
    });
  }

  /// Listen to song position
  void _listenToCurrentPosition() {
    AudioService.position.listen((pos) {
      position.value = pos.toString().split(".")[0];
      sliderValue.value = pos.inSeconds.toDouble();
    });
  }

  /// Listen to song duration
  void _listenToTotalDuration() {
    _audioHandler.mediaItem.listen((mediaItem) {
      duration.value = mediaItem?.duration.toString().split(".")[0] ??
          Duration.zero.toString().split(".")[0];
      maxSlider.value = mediaItem?.duration?.inSeconds.toDouble() ??
          Duration.zero.inSeconds.toDouble();
    });
  }

  /// Shuffle Songs
  void shuffle() {
    final enable = !isShuffleModeEnabled.value;
    //  change shuffle mode
    isShuffleModeEnabled.value = enable;

    playerUseCases.shuffleUseCase
        .invoke(isShuffleModeEnabled: enable);
  }

  void disableShuffle() {
    isShuffleModeEnabled.value = false;
    _audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
  }

  /// Repeat Mode
  void repeat() {
    nextRepeatState();

    final repeatMode = repeatButtonState.value;

    switch (repeatMode) {
      case RepeatState.off:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
        break;
      case RepeatState.repeatSong:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
        break;
    }
  }

  //  move to the next state
  void nextRepeatState() {
    final next =
        (repeatButtonState.value.index + 1) % RepeatState.values.length;
    repeatButtonState.value = RepeatState.values[next];
  }

  void setTotalSongsDuration({required List<SongModel> songs}) {
    var durations = songs.map((song) => song.duration);
    var totalDuration =
        durations.reduce((dur, element) => dur! + element!.toInt())!;

    totalSongsDuration.value =
        MathUtils.printToMinutesSeconds(Duration(milliseconds: totalDuration));
  }

  /// Listen to total duration from audio handler
  void initializeSongs({required List<SongModel> songs}) {
    this.songs.value = songs;

    azSongs = songs
        .map((s) => AZItem(
            title: s.displayNameWOExt,
            tag: s.displayNameWOExt[0].toUpperCase()))
        .toList();

    mediaItemsInitial = songsToMediaItems(songs: songs);

    mediaItemsDynamic = songs
        .map((song) => MediaItem(
            id: song.id.toString(),
            title: song.displayNameWOExt,
            artist: song.artist,
            genre: song.genre,
            album: song.album,
            duration: Duration(milliseconds: song.duration!),
            extras: {'url': song.uri, 'imageUrl': song.id}))
        .toList();

    //  Add media to audio handler
    _audioHandler.addQueueItems(mediaItemsDynamic);
  }

  ///  Play Song
  Future<void> playSong({required int index}) async {
    currentPlayingSongIndex.value = index;
    await playerUseCases.playSongUseCase.invoke();
  }

  /// Play Song At Index
  Future<void> playSongAtIndex({required int index}) async {
    await playerUseCases.playSongAtIndexUseCase.invoke(index: index);
  }

  /// Pause Song
  Future<void> pauseSong() async {
    await playerUseCases.pauseSongUseCase.invoke();
  }

  /// Next Song
  Future<void> playNextSong({required int index}) async {
    //  turn off repeat and turn it on for the current song
    final currentRepeatState = repeatButtonState.value;

    //  turn off repeat
    _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);

    currentPlayingSongIndex.value = index;
    await playerUseCases.playNextSongUseCase.invoke();

    //  turn on repeat
    switch (currentRepeatState) {
      case RepeatState.off:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
        break;
      case RepeatState.repeatSong:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
        break;
    }
  }

  /// Prev Song
  Future<void> playPrevSong({required int index}) async {
    //  turn off repeat and turn it on for the current song
    final currentRepeatState = repeatButtonState.value;
    //  turn off repeat
    _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);

    currentPlayingSongIndex.value = index;
    await playerUseCases.playPrevSongUseCase.invoke();

    //  turn on repeat
    switch (currentRepeatState) {
      case RepeatState.off:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
        break;
      case RepeatState.repeatSong:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
        break;
    }
  }

  /// Seek Song
  void seekSong({required int seconds}) {
    playerUseCases.seekSongUseCase.invoke(seconds: seconds);
  }

  /// Get Songs
  Future<List<SongModel>> getSongs() async {
    var songs = await playerUseCases.getSongsUseCase.invoke();
    this.songs.value = songs;
    totalSongs.value = songs.length;
    return songs;
  }

  /// Check if song is playing
  void isSongPlaying() => playerUseCases.isSongPlayingUseCase
      .invoke(onStateChanged: (state) => playerState.value = state);

  /// Disposing our Audio Player
  void disposeAudio() {
    _audioHandler.customAction('dispose');
  }

  /// Stopping our Audio Player
  void stopAudio() {
    _audioHandler.stop();
  }

  /// Check Storage Permission
  Future<void> checkPermission() async {
    //  request access to storage
    var isStorageGranted = await playerUseCases.checkPermissionUseCase.invoke();

    if (isStorageGranted) {
      //  save the value to the database
      _userController.updateUserPrefs(user: User(hasGrantedPermission: true));
    } else {
      isPermissionGranted.value = false;
    }
  }
}
