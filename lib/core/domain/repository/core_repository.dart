import 'package:audio_service/audio_service.dart';

abstract class CoreRepository {
  /// Add User Preferences
  Future<void> addUserPrefs();

  /// Get User Preferences
  Future<void> getUserPrefs();

  /// Update User Preferences
  Future<void> updateUserPrefs();

  /// Delete User Preferences
  Future<void> deleteUserPrefs();
}
