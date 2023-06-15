import 'package:flow/features/feature_home/domain/use_case/check_permission_use_case.dart';
import 'package:flow/features/feature_home/domain/use_case/get_songs_use_case.dart';
import 'package:flow/features/feature_home/domain/use_case/play_song_use_case.dart';

class HomeUseCases {
  final CheckPermissionUseCase checkPermissionUseCase;
  final GetSongsUseCase getSongsUseCase;
  final PlaySongUseCase playSongUseCase;

  HomeUseCases(
      {required this.checkPermissionUseCase,
      required this.getSongsUseCase,
      required this.playSongUseCase});
}