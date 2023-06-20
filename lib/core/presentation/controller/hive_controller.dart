import 'package:flow/core/domain/models/user.dart';
import 'package:flow/core/domain/use_cases/hive_repo/hive_use_cases.dart';
import 'package:flow/core/utils/hive_utils.dart';
import 'package:flow/di/locator.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HiveController extends GetxController {
  final useCases = locator.get<HiveUseCases>();

  /// User Prefs
  final userPrefs = Hive.box(HiveUtils.userBox).listenable().obs;

  Future<void> addUserPrefs({required User user}) async =>
      await useCases.addUserPrefs.call(user: user);

  Future<void> deleteUserPrefs() async => await useCases.deleteUserPrefs();

  void getUserPrefs({required Function(ValueListenable<Box> box) observeBox}) {
    observeBox(box) => userPrefs.value = box;
  }

  Future<void> updateUserPrefs({required User user}) async =>
      await useCases.updateUserPrefs.call(user: user);
}
