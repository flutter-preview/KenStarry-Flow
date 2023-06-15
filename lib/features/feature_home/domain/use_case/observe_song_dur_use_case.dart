import 'package:flow/di/locator.dart';
import 'package:flow/features/feature_home/domain/repository/home_repository.dart';

class ObserveSongDurUseCase {
  final repo = locator.get<HomeRepository>();

  void invoke({required void Function(Duration dur) onDurationChanged}) =>
      repo.observeSongDuration(onDurationChanged: onDurationChanged);
}
