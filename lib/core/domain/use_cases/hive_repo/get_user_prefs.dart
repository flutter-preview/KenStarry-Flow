import 'package:flow/core/domain/repository/user_repository.dart';
import 'package:flow/di/locator.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../models/user.dart';

class GetUserPrefs {
  final repo = locator.get<UserRepository>();

  void call({required Function(ValueListenable<Box> box) observeBox}) =>
      repo.getUserPrefs(observeBox: observeBox);
}
