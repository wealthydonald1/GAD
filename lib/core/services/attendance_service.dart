import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceEntry {
  final String date; // e.g. 2026-03-05
  final String inTime; // e.g. 8:30 AM
  final String outTime; // e.g. 5:30 PM

  AttendanceEntry({
    required this.date,
    required this.inTime,
    required this.outTime,
  });

  Map<String, dynamic> toJson() => {
        'date': date,
        'in': inTime,
        'out': outTime,
      };

  factory AttendanceEntry.fromJson(Map<String, dynamic> json) {
    return AttendanceEntry(
      date: (json['date'] ?? '').toString(),
      inTime: (json['in'] ?? '--:--').toString(),
      outTime: (json['out'] ?? '--:--').toString(),
    );
  }
}

class AttendanceState {
  final bool isClockedIn;
  final String? inTime;
  final String? outTime;
  final String breakTime;

  AttendanceState({
    required this.isClockedIn,
    required this.inTime,
    required this.outTime,
    required this.breakTime,
  });
}

class AttendanceService {
  static const _kIsClockedIn = 'attendance_isClockedIn';
  static const _kInTime = 'attendance_inTime';
  static const _kOutTime = 'attendance_outTime';
  static const _kBreak = 'attendance_break';
  static const _kHistory = 'attendance_history_v1';

  Future<AttendanceState> load() async {
    final prefs = await SharedPreferences.getInstance();
    return AttendanceState(
      isClockedIn: prefs.getBool(_kIsClockedIn) ?? false,
      inTime: prefs.getString(_kInTime),
      outTime: prefs.getString(_kOutTime),
      breakTime: prefs.getString(_kBreak) ?? '1 hr',
    );
  }

  Future<void> saveState({
    required bool isClockedIn,
    String? inTime,
    String? outTime,
    String? breakTime,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kIsClockedIn, isClockedIn);

    if (inTime != null) await prefs.setString(_kInTime, inTime);
    if (outTime != null) await prefs.setString(_kOutTime, outTime);
    if (breakTime != null) await prefs.setString(_kBreak, breakTime);
  }

  Future<List<AttendanceEntry>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kHistory);
    if (raw == null || raw.isEmpty) return [];
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    return list.map(AttendanceEntry.fromJson).toList();
  }

  Future<void> addHistoryEntry(AttendanceEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await loadHistory();
    history.insert(0, entry); // newest first
    await prefs.setString(_kHistory, jsonEncode(history.map((e) => e.toJson()).toList()));
  }
}