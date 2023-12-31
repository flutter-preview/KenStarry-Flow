import 'package:audio_service/audio_service.dart';
import 'package:flow/di/locator.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../domain/use_cases/player_use_cases/player_use_case.dart';

class MyAudioHandler extends BaseAudioHandler {
  final _player = locator.get<AudioPlayer>();

  List<MediaItem> songsMediaItems = [];
  final _playlistQueue = ConcatenatingAudioSource(children: []);
  var currentRepeatMode = AudioServiceRepeatMode.none;

  MyAudioHandler({required int index}) {
    _loadEmptyPlaylist();
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    _listenForCurrentSongIndexChanges(index: index);
    _listenForDurationChanges();
    _listenForSequenceStateChanges();
  }

  Future<void> _loadEmptyPlaylist() async {
    try {
      await _player.setAudioSource(_playlistQueue);
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Future<void> playMediaItem(MediaItem mediaItem) async {
    this.mediaItem.add(mediaItem);
    _player.setAudioSource(_createAudioSource(mediaItem));
    _player.play();
  }

  /// Play
  @override
  Future<void> play() async => await _player.play();

  /// Pause
  @override
  Future<void> pause() async => await _player.pause();

  /// Stop
  @override
  Future<void> stop() async {
    //  Alert Audio Player
    await _player.stop();
    //  Alert System
    return super.stop();
  }

  /// Shuffle
  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    if (shuffleMode == AudioServiceShuffleMode.none) {
      _player.setShuffleModeEnabled(false);
    } else {
      await _player.shuffle();
      _player.setShuffleModeEnabled(true);
    }
  }

  /// Repeat Mode
  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    currentRepeatMode = repeatMode;

    switch (repeatMode) {
      case AudioServiceRepeatMode.none:
        _player.setLoopMode(LoopMode.off);
        break;
      case AudioServiceRepeatMode.one:
        _player.setLoopMode(LoopMode.one);
        break;
      case AudioServiceRepeatMode.group:
      case AudioServiceRepeatMode.all:
        _player.setLoopMode(LoopMode.all);
        break;
    }
  }

  @override
  Future<void> setSpeed(double speed) async {
    _player.setSpeed(speed);
  }

  @override
  Future<void> skipToNext() async {
    //  reset playback loop mode
    _player.setLoopMode(LoopMode.off);

    await _player.seekToNext();

    switch (currentRepeatMode) {
      case AudioServiceRepeatMode.none:
        _player.setLoopMode(LoopMode.off);
        break;
      case AudioServiceRepeatMode.one:
        _player.setLoopMode(LoopMode.one);
        break;
      case AudioServiceRepeatMode.group:
      case AudioServiceRepeatMode.all:
        _player.setLoopMode(LoopMode.all);
        break;
    }
  }

  @override
  Future<void> skipToPrevious() async {
    //  reset playback loop mode
    _player.setLoopMode(LoopMode.off);

    await _player.seekToPrevious();

    switch (currentRepeatMode) {
      case AudioServiceRepeatMode.none:
        _player.setLoopMode(LoopMode.off);
        break;
      case AudioServiceRepeatMode.one:
        _player.setLoopMode(LoopMode.one);
        break;
      case AudioServiceRepeatMode.group:
      case AudioServiceRepeatMode.all:
        _player.setLoopMode(LoopMode.all);
        break;
    }
  }

  /// Seek
  @override
  Future<void> seek(Duration position) async => await _player.seek(position);

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= queue.value.length) return;

    //  check if shuffling is enabled
    if (_player.shuffleModeEnabled) {
      index = _player.shuffleIndices![index];
    }

    _player.seek(Duration.zero, index: index);
    _player.play();
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    //  manage Just Audio
    final audioSource = _createAudioSource(mediaItem);
    _playlistQueue.add(audioSource);

    //  notify audio handler
    final newQueue = queue.value..add(mediaItem);
    queue.add(newQueue);
  }

  /// Queue Playback
  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    songsMediaItems = mediaItems;
    //  manage Just Audio
    final audioSource = mediaItems.map((song) => _createAudioSource(song));
    _playlistQueue.addAll(audioSource.toList());

    //  notify audio handler
    final newQueue = queue.value..addAll(mediaItems);
    queue.add(newQueue);
  }

  @override
  Future<void> removeQueueItemAt(int index) async {
    if (_playlistQueue.length > index) {
      await _playlistQueue.removeAt(index);

      final newQueue = queue.value..removeAt(index);
      queue.add(newQueue);
    }
  }

  //  creating an audio source
  UriAudioSource _createAudioSource(MediaItem mediaItem) {
    return AudioSource.uri(Uri.parse(mediaItem.extras!['url'] as String),
        tag: mediaItem);
  }

  /// Custom Actions
  @override
  Future customAction(String name, [Map<String, dynamic>? extras]) async {
    //  dispose the player
    if (name == 'dispose') {
      await _player.dispose();
      super.stop();
    } else if (name == 'jumpToQueueItem') {
      var index = extras!['index'];

      _player.seek(Duration.zero, index: index);
      _player.play();
    } else if (name == 'clearQueue') {
      await _playlistQueue.clear().whenComplete(() => queue.value.clear());
    } else if (name == 'setMediaItemIndex') {
      final playlist = queue.value;

      if (_player.currentIndex != extras!['index']) {
        _player.seek(Duration.zero, index: extras['index']);
        mediaItem.add(playlist[extras['index']]);
      }
    }
  }

  /// Index of Current Item
  void _listenForCurrentSongIndexChanges({int? index}) {
    if (index != null) {
      _player.seek(Duration.zero, index: index);
    }

    _player.currentIndexStream.listen((index) {
      final playlist = queue.value;
      if (index == null || playlist.isEmpty) return;
      if (_player.shuffleModeEnabled) {
        index = _player.shuffleIndices!.indexOf(index);
      }
      //  update the new song inside media item
      mediaItem.add(playlist[index]);
    });
  }

  /// Current Duration of Song Playing
  void _listenForDurationChanges() {
    _player.durationStream.listen((duration) {
      var index = _player.currentIndex;
      final newQueue = queue.value;

      if (index == null || newQueue.isEmpty) return;

      if (_player.shuffleModeEnabled) {
        index = _player.shuffleIndices!.indexOf(index);
      }

      //  update the old media item duration
      final oldMediaItem = newQueue[index];
      final newMediaItem = oldMediaItem.copyWith(duration: duration);
      newQueue[index] = newMediaItem;

      queue.add(newQueue);
      mediaItem.add(newMediaItem);
    });
  }

  /// Sequence Changes
  void _listenForSequenceStateChanges() {
    _player.sequenceStateStream.listen((SequenceState? sequenceState) {
      final sequence = sequenceState?.effectiveSequence;

      if (sequence == null || sequence.isEmpty) return;

      final items = sequence.map((source) => source.tag as MediaItem);
      queue.add(items.toList());
    });
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
        controls: [
          MediaControl.skipToPrevious,
          _player.playing ? MediaControl.pause : MediaControl.play,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        androidCompactActionIndices: const [
          0,
          1,
          2
        ],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_player.processingState]!,
        playing: _player.playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        queueIndex: event.currentIndex,
        repeatMode: const {
          LoopMode.off: AudioServiceRepeatMode.none,
          LoopMode.one: AudioServiceRepeatMode.one,
          LoopMode.all: AudioServiceRepeatMode.all,
        }[_player.loopMode]!,
        shuffleMode: (_player.shuffleModeEnabled)
            ? AudioServiceShuffleMode.all
            : AudioServiceShuffleMode.none);
  }
}
