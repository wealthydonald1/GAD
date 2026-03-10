import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _staffIdKey = 'staff_id';
  static const String _roleKey = 'user_role';
  static const String _biometricEnabledKey = 'biometric_enabled';
  static const String _biometricPendingNextLaunchKey =
      'biometric_pending_next_launch';

  Future<void> login({
    required String staffId,
    required String role,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_staffIdKey, staffId);
    await prefs.setString(_roleKey, role);
  }

  Future<String?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_staffIdKey);
  }

  Future<String?> getCurrentRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_roleKey);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final staffId = prefs.getString(_staffIdKey);
    return staffId != null && staffId.isNotEmpty;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    // Clear session only
    await prefs.remove(_staffIdKey);
    await prefs.remove(_roleKey);

    // IMPORTANT:
    // Do NOT clear biometric preference here.
    // Biometrics are a device-level preference.
  }

  Future<void> setBiometricEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricEnabledKey, enabled);
  }

  Future<bool> isBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_biometricEnabledKey) ?? false;
  }

  Future<void> setBiometricPendingNextLaunch(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricPendingNextLaunchKey, value);
  }

  Future<bool> isBiometricPendingNextLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_biometricPendingNextLaunchKey) ?? false;
  }

  Future<void> clearBiometricPendingNextLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_biometricPendingNextLaunchKey);
  }
}
