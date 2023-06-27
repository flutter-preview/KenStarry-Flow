import 'package:audio_service/audio_service.dart';
import 'package:on_audio_query/on_audio_query.dart';

List<MediaItem> songsToMediaItems({required List<SongModel> songs}) {
  return songs
      .map((song) => MediaItem(
          id: song.id.toString(),
          title: song.displayNameWOExt,
          artist: song.artist,
          genre: song.genre,
          album: song.album,
          duration: Duration(milliseconds: song.duration!),
          extras: {'url': song.uri, 'imageUrl': song.id}))
      .toList();
}
