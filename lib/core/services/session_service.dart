import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const _keyCurrentUserId = 'current_user_id';
  static const _keyCurrentUserRole = 'current_user_role';
  static const _keyIsLoggedIn = 'is_logged_in';

  static Future<void> saveSession({
    required String userId,
    required String role,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyCurrentUserId, userId);
    await prefs.setString(_keyCurrentUserRole, role);
    await prefs.setBool(_keyIsLoggedIn, true);
  }

  static Future<String?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyCurrentUserId);
  }

  static Future<String?> getCurrentUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyCurrentUserRole);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyCurrentUserId);
    await prefs.remove(_keyCurrentUserRole);
    await prefs.setBool(_keyIsLoggedIn, false);
  }
}
