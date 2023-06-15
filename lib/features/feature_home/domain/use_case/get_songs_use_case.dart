import 'package:flow/di/locator.dart';
import 'package:flow/features/feature_home/domain/repository/home_repository.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GetSongsUseCase {

  var repo = locator.get<HomeRepository>();

  Future<List<SongModel>> invoke() async => await repo.getAllSongs();
}