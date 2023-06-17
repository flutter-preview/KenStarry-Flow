import 'package:flow/di/core_di.dart';
import 'package:flow/di/player_di.dart';
import 'package:flow/features/feature_home/data/repository/home_repository_impl.dart';
import 'package:flow/features/feature_home/domain/repository/home_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

var locator = GetIt.instance;

Future<void> invokeDI() async {
  playerDI(locator: locator);
  await coreDI(locator: locator);
}