import 'package:flow/core/domain/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

abstract class HiveRepository {
  /// Add User Preferences
  Future<void> addUserPrefs({required User user});

  /// Get User Preferences
  void getUserPrefs({required Function(ValueListenable<Box> box) observeBox});

  /// Update User Preferences
  Future<void> updateUserPrefs({required User user});

  /// Delete User Preferences
  Future<void> deleteUserPrefs();
}