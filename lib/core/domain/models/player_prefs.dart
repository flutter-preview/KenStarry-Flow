import 'package:hive/hive.dart';

/// flutter packages pub run build_runner build
part 'player_prefs.g.dart';

@HiveType(typeId: 3)
class PlayerPrefs {

  @HiveField(0, defaultValue: 0)
  final int? currentSongIndex;

  PlayerPrefs({this.currentSongIndex});
}
