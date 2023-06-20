import 'package:flow/core/domain/repository/hive_repository.dart';
import 'package:flow/di/locator.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../models/user.dart';

class GetUserPrefs {
  final repo = locator.get<HiveRepository>();

  ValueListenable<Box> call() => repo.getUserPrefs();
}
