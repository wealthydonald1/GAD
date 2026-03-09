import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _staffIdKey = 'staff_id';
  static const String _biometricEnabledKey = 'biometric_enabled';

  Future<void> login(String staffId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_staffIdKey, staffId);
  }

  Future<String?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_staffIdKey);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final staffId = prefs.getString(_staffIdKey);
    return staffId != null && staffId.isNotEmpty;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_staffIdKey);
  }

  Future<void> setBiometricEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricEnabledKey, enabled);
  }

  Future<bool> isBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_biometricEnabledKey) ?? false;
  }
}
