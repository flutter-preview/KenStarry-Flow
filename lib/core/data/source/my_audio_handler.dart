import 'package:audio_service/audio_service.dart';
import 'package:flow/di/locator.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../features/feature_home/domain/use_case/home_use_cases.dart';

class MyAudioHandler extends BaseAudioHandler {
  final _player = locator.get<AudioPlayer>();
  int currentSongIndex = 0;

  List<MediaItem> songsMediaItems = [];
  final _playlistQueue = ConcatenatingAudioSource(children: []);

  MyAudioHandler() {
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    _listenForCurrentSongIndexChanges();
    _listenForDurationChanges();
    _listenForSequenceStateChanges();
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

  /// Seek
  @override
  Future<void> seek(Duration position) async => await _player.seek(position);

  @override
  Future<void> skipToQueueItem(int index) async {
    currentSongIndex = index;
    mediaItem.add(songsMediaItems[index]);
    await _player.setAudioSource(_playlistQueue[index]);
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

  /// Index of Current Item
  void _listenForCurrentSongIndexChanges() {
    _player.currentIndexStream.listen((index) {
      final playlist = queue.value;
      if (index == null || playlist.isEmpty) return;
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

      if  (_player.shuffleModeEnabled) {
        index = _player.shuffleIndices![index];
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
      androidCompactActionIndices: const [0, 1, 2],
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
    );
  }
}
