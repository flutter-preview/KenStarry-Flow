class Playlist {
  final String? playlistName;
  final String? playlistImageUri;
  final DateTime? playlistCreatedDate;
  final List<String>? playlistSongIds;

  Playlist(
      {this.playlistName,
      this.playlistImageUri,
      this.playlistCreatedDate,
      this.playlistSongIds});
}
