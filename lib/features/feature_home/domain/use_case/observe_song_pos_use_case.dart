import 'package:flow/di/locator.dart';
import 'package:flow/features/feature_home/domain/repository/home_repository.dart';

class ObserveSongPosUseCase {
  final repo = locator.get<HomeRepository>();

  void invoke({required void Function(Duration pos) onPositionChanged}) =>
      repo.observeSongPosition(onPositionChanged: onPositionChanged);
}