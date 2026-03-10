import 'package:shared_preferences/shared_preferences.dart';

class DevicePrefsService {
  static const _keyBiometricEnabled = 'biometric_enabled';
  static const _keyBiometricPendingRestart = 'biometric_pending_restart';

  static Future<bool> isBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyBiometricEnabled) ?? false;
  }

  static Future<void> enableBiometric() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyBiometricEnabled, true);

    // Prevent prompting in the same app run.
    await prefs.setBool(_keyBiometricPendingRestart, true);
  }

  static Future<void> disableBiometric() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyBiometricEnabled, false);
    await prefs.setBool(_keyBiometricPendingRestart, false);
  }

  static Future<bool> isBiometricPendingRestart() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyBiometricPendingRestart) ?? false;
  }

  /// Call this once during app startup.
  /// If biometric was newly enabled in the previous run, we "arm" it now.
  static Future<void> finalizeLaunchState() async {
    final prefs = await SharedPreferences.getInstance();
    final pending = prefs.getBool(_keyBiometricPendingRestart) ?? false;

    if (pending) {
      await prefs.setBool(_keyBiometricPendingRestart, false);
    }
  }
}
