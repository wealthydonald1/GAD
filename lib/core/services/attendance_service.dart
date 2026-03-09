import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/attendance/domain/attendance_record.dart';

class AttendanceService {
  static const _historyKey = 'attendance_history';
  static const _isClockedInKey = 'attendance_is_clocked_in';
  static const _inTimeKey = 'attendance_in_time';
  static const _outTimeKey = 'attendance_out_time';

  Future<List<AttendanceRecord>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_historyKey) ?? [];

    return raw.map((e) => AttendanceRecord.fromJson(jsonDecode(e))).toList();
  }

  Future<void> _saveHistory(List<AttendanceRecord> history) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = history.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_historyKey, raw);
  }

  Future<Map<String, dynamic>> getClockState() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'isClockedIn': prefs.getBool(_isClockedInKey) ?? false,
      'inTime': prefs.getString(_inTimeKey),
      'outTime': prefs.getString(_outTimeKey),
    };
  }

  Future<void> _setClockState({
    required bool isClockedIn,
    String? inTime,
    String? outTime,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isClockedInKey, isClockedIn);

    if (inTime != null) {
      await prefs.setString(_inTimeKey, inTime);
    }

    if (outTime != null) {
      await prefs.setString(_outTimeKey, outTime);
    }
  }

  String _today() => DateTime.now().toString().split(' ')[0];

  Future<String> clockIn(String time) async {
    final state = await getClockState();
    final alreadyClockedIn = state['isClockedIn'] as bool? ?? false;

    if (alreadyClockedIn) {
      return 'You are already clocked in';
    }

    final history = await getHistory();
    final today = _today();

    final existingIndex = history.indexWhere((e) => e.date == today);

    if (existingIndex != -1 && history[existingIndex].clockOut != '--:--') {
      return 'You have already completed attendance for today';
    }

    if (existingIndex != -1) {
      history[existingIndex] = history[existingIndex].copyWith(clockIn: time);
    } else {
      history.add(
        AttendanceRecord(
          date: today,
          clockIn: time,
          clockOut: '--:--',
        ),
      );
    }

    await _saveHistory(history);
    await _setClockState(
      isClockedIn: true,
      inTime: time,
      outTime: null,
    );

    return 'Clocked in successfully';
  }

  Future<String> clockOut(String time) async {
    final state = await getClockState();
    final alreadyClockedIn = state['isClockedIn'] as bool? ?? false;
    final currentInTime = state['inTime'] as String?;

    if (!alreadyClockedIn || currentInTime == null || currentInTime.isEmpty) {
      return 'You must clock in first';
    }

    final history = await getHistory();
    final today = _today();

    final existingIndex = history.indexWhere((e) => e.date == today);

    if (existingIndex == -1) {
      return 'No clock-in record found for today';
    }

    history[existingIndex] = history[existingIndex].copyWith(clockOut: time);

    await _saveHistory(history);
    await _setClockState(
      isClockedIn: false,
      inTime: currentInTime,
      outTime: time,
    );

    return 'Clocked out successfully';
  }
}
