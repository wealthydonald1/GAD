import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/attendance/domain/attendance_record.dart';

class AttendanceService {
  static const _historyKey = 'attendance_history';

  static const _isClockedInKey = 'attendance_is_clocked_in';
  static const _inTimeKey = 'attendance_in_time';
  static const _outTimeKey = 'attendance_out_time';

  static const _stateDateKey = 'attendance_state_date';
  static const _inDateTimeIsoKey = 'attendance_in_datetime_iso';
  static const _outDateTimeIsoKey = 'attendance_out_datetime_iso';

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

  String _today() => DateTime.now().toIso8601String().split('T')[0];

  Future<void> _resetDailyClockState(
    SharedPreferences prefs, {
    required String today,
  }) async {
    await prefs.setString(_stateDateKey, today);
    await prefs.setBool(_isClockedInKey, false);
    await prefs.remove(_inTimeKey);
    await prefs.remove(_outTimeKey);
    await prefs.remove(_inDateTimeIsoKey);
    await prefs.remove(_outDateTimeIsoKey);
  }

  String formatDuration(Duration duration) {
    final totalMinutes = duration.inMinutes;
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;

    if (hours <= 0) return '${minutes}m';
    return '${hours}h ${minutes}m';
  }

  DateTime? _parseRecordDateTime(String date, String time) {
    if (time.trim().isEmpty || time == '--:--') return null;

    final dateParts = date.split('-');
    if (dateParts.length != 3) return null;

    final year = int.tryParse(dateParts[0]);
    final month = int.tryParse(dateParts[1]);
    final day = int.tryParse(dateParts[2]);

    if (year == null || month == null || day == null) return null;

    final match = RegExp(
      r'^(\d{1,2}):(\d{2})(?:\s*([AaPp][Mm]))?$',
    ).firstMatch(time.trim());

    if (match == null) return null;

    var hour = int.tryParse(match.group(1)!);
    final minute = int.tryParse(match.group(2)!);
    final amPm = match.group(3)?.toUpperCase();

    if (hour == null || minute == null) return null;

    if (amPm != null) {
      if (amPm == 'AM') {
        if (hour == 12) hour = 0;
      } else if (amPm == 'PM') {
        if (hour != 12) hour += 12;
      }
    }

    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) return null;

    return DateTime(year, month, day, hour, minute);
  }

  Duration? _recordDuration(AttendanceRecord record) {
    final inDateTime = _parseRecordDateTime(record.date, record.clockIn);
    final outDateTime = _parseRecordDateTime(record.date, record.clockOut);

    if (inDateTime == null || outDateTime == null) return null;
    if (outDateTime.isBefore(inDateTime)) return null;

    return outDateTime.difference(inDateTime);
  }

  Future<Map<String, dynamic>> getClockState() async {
    final prefs = await SharedPreferences.getInstance();
    final today = _today();
    final savedStateDate = prefs.getString(_stateDateKey);

    if (savedStateDate != today) {
      await _resetDailyClockState(prefs, today: today);
    }

    final isClockedIn = prefs.getBool(_isClockedInKey) ?? false;
    final inTime = prefs.getString(_inTimeKey);
    final outTime = prefs.getString(_outTimeKey);
    final inIso = prefs.getString(_inDateTimeIsoKey);
    final outIso = prefs.getString(_outDateTimeIsoKey);

    DateTime? inDateTime;
    DateTime? outDateTime;

    if (inIso != null && inIso.isNotEmpty) {
      inDateTime = DateTime.tryParse(inIso);
    }

    if (outIso != null && outIso.isNotEmpty) {
      outDateTime = DateTime.tryParse(outIso);
    }

    String workDuration = '--';

    if (inDateTime != null && outDateTime != null) {
      final diff = outDateTime.difference(inDateTime);
      if (!diff.isNegative) {
        workDuration = formatDuration(diff);
      }
    } else if (inDateTime != null && isClockedIn) {
      final diff = DateTime.now().difference(inDateTime);
      if (!diff.isNegative) {
        workDuration = '${formatDuration(diff)}';
      }
    }

    return {
      'isClockedIn': isClockedIn,
      'inTime': inTime,
      'outTime': outTime,
      'workDuration': workDuration,
    };
  }

  Future<void> _setClockState({
    required bool isClockedIn,
    required String stateDate,
    String? inTime,
    String? outTime,
    String? inDateTimeIso,
    String? outDateTimeIso,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_stateDateKey, stateDate);
    await prefs.setBool(_isClockedInKey, isClockedIn);

    if (inTime != null) {
      await prefs.setString(_inTimeKey, inTime);
    } else {
      await prefs.remove(_inTimeKey);
    }

    if (outTime != null) {
      await prefs.setString(_outTimeKey, outTime);
    } else {
      await prefs.remove(_outTimeKey);
    }

    if (inDateTimeIso != null) {
      await prefs.setString(_inDateTimeIsoKey, inDateTimeIso);
    } else {
      await prefs.remove(_inDateTimeIsoKey);
    }

    if (outDateTimeIso != null) {
      await prefs.setString(_outDateTimeIsoKey, outDateTimeIso);
    } else {
      await prefs.remove(_outDateTimeIsoKey);
    }
  }

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
      history[existingIndex] = history[existingIndex].copyWith(
        clockIn: time,
        clockOut: '--:--',
      );
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

    final nowIso = DateTime.now().toIso8601String();

    await _setClockState(
      isClockedIn: true,
      stateDate: today,
      inTime: time,
      outTime: null,
      inDateTimeIso: nowIso,
      outDateTimeIso: null,
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

    final prefs = await SharedPreferences.getInstance();
    final inIso = prefs.getString(_inDateTimeIsoKey);
    final outIso = DateTime.now().toIso8601String();

    await _setClockState(
      isClockedIn: false,
      stateDate: today,
      inTime: currentInTime,
      outTime: time,
      inDateTimeIso: inIso,
      outDateTimeIso: outIso,
    );

    return 'Clocked out successfully';
  }

  Future<String> getAverageWorkDurationText() async {
    final history = await getHistory();

    final durations =
        history.map(_recordDuration).whereType<Duration>().toList();

    if (durations.isEmpty) return '--';

    final totalMinutes = durations.fold<int>(
      0,
      (sum, duration) => sum + duration.inMinutes,
    );

    final averageMinutes = totalMinutes ~/ durations.length;
    return formatDuration(Duration(minutes: averageMinutes));
  }

  String getRecordWorkDurationText(AttendanceRecord record) {
    final duration = _recordDuration(record);
    if (duration == null) return '--';
    return formatDuration(duration);
  }
}
