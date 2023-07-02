// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_prefs.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerPrefsAdapter extends TypeAdapter<PlayerPrefs> {
  @override
  final int typeId = 3;

  @override
  PlayerPrefs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayerPrefs(
      currentSongIndex: fields[0] == null ? 0 : fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PlayerPrefs obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.currentSongIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerPrefsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
