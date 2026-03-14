import 'package:shared_preferences/shared_preferences.dart';

class WeekendWorkService {
  static const String _storageKey = 'weekend_approved_staff_ids';

  bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  Future<bool> isStaffApproved(String staffId) async {
    final prefs = await SharedPreferences.getInstance();
    final approvedList = prefs.getStringList(_storageKey) ?? [];
    return approvedList.contains(staffId);
  }

  Future<void> toggleApproval(String staffId, bool shouldApprove) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> approvedList = prefs.getStringList(_storageKey) ?? [];

    if (shouldApprove) {
      if (!approvedList.contains(staffId)) {
        approvedList.add(staffId);
      }
    } else {
      approvedList.remove(staffId);
    }
    await prefs.setStringList(_storageKey, approvedList);
  }

  Future<List<String>> getApprovedStaffIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_storageKey) ?? [];
  }
}
