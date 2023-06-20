import 'package:flow/core/domain/models/user.dart';
import 'package:flow/core/domain/use_cases/hive_repo/hive_use_cases.dart';
import 'package:flow/di/locator.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HiveController extends GetxController {
  final useCases = locator.get<HiveUseCases>();

  /// User Prefs
  final userPrefs = null.obs;

  Future<void> addUserPrefs({required User user}) async =>
      await useCases.addUserPrefs.call(user: user);

  Future<void> deleteUserPrefs() async => await useCases.deleteUserPrefs();

  ValueListenable<Box> getUserPrefs() => useCases.getUserPrefs();

  Future<void> updateUserPrefs({required User user}) async =>
      await useCases.updateUserPrefs.call(user: user);
}
