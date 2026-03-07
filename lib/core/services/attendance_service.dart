import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/attendance/domain/attendance_record.dart';

class AttendanceService {
  static const _key = 'attendance_history';

  Future<List<AttendanceRecord>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();

    final raw = prefs.getStringList(_key) ?? [];

    return raw.map((e) => AttendanceRecord.fromJson(jsonDecode(e))).toList();
  }

  Future<void> saveRecord(AttendanceRecord record) async {
    final prefs = await SharedPreferences.getInstance();

    final raw = prefs.getStringList(_key) ?? [];

    raw.add(jsonEncode(record.toJson()));

    await prefs.setStringList(_key, raw);
  }
}
