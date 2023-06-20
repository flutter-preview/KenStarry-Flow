// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistAdapter extends TypeAdapter<Playlist> {
  @override
  final int typeId = 2;

  @override
  Playlist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Playlist(
      playlistName: fields[0] == null ? '' : fields[0] as String?,
      playlistImageUri: fields[1] == null ? '' : fields[1] as String?,
      playlistCreatedDate: fields[2] as DateTime?,
      playlistSongIds:
          fields[3] == null ? [] : (fields[3] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Playlist obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.playlistName)
      ..writeByte(1)
      ..write(obj.playlistImageUri)
      ..writeByte(2)
      ..write(obj.playlistCreatedDate)
      ..writeByte(3)
      ..write(obj.playlistSongIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
