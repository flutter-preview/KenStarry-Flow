import 'package:flow/di/locator.dart';
import 'package:flow/core/domain/repository/home_repository.dart';

class SeekSongUseCase {

  final repo = locator.get<HomeRepository>();

  void invoke({required int seconds}) => repo.seekSong(seconds: seconds);
}