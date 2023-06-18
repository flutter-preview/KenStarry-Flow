import 'package:flow/di/artists_di.dart';
import 'package:flow/di/core_di.dart';
import 'package:flow/di/player_di.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.instance;

Future<void> invokeDI() async {
  await playerDI(locator: locator);
  artistsDI(locator: locator);
  await coreDI(locator: locator);
}