import 'package:flow/di/locator.dart';
import 'package:flow/core/domain/repository/player_repository.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GetSongsUseCase {

  var repository = locator.get<PlayerRepository>();

  Future<List<SongModel>> call() async => await repository.getAllSongs();
}