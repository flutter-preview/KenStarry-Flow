import 'package:flow/di/locator.dart';
import 'package:flow/core/domain/repository/home_repository.dart';

class PlaySongAtIndexUseCase {

  final repository = locator.get<HomeRepository>();

  Future<void> invoke({required int index}) async => repository.playSongAtIndex(index: index);
}