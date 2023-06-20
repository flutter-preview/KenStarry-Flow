import 'package:flow/core/domain/models/user.dart';

abstract class HiveRepository {
  /// Add User Preferences
  Future<void> addUserPrefs({required User user});

  /// Get User Preferences
  Future<void> getUserPrefs();

  /// Update User Preferences
  Future<void> updateUserPrefs();

  /// Delete User Preferences
  Future<void> deleteUserPrefs();
}