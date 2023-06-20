import 'package:hive/hive.dart';

/// flutter packages pub run build_runner build
part 'playlist.g.dart';

@HiveType(typeId: 2)
class Playlist {
  @HiveField(0, defaultValue: '')
  final String? playlistName;

  @HiveField(1, defaultValue: '')
  final String? playlistImageUri;

  @HiveField(2)
  final DateTime? playlistCreatedDate;

  @HiveField(3, defaultValue: [])
  final List<String>? playlistSongIds;

  Playlist(
      {this.playlistName,
      this.playlistImageUri,
      this.playlistCreatedDate,
      this.playlistSongIds});
}
