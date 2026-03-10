class TodayAttendanceState {
  final String dateKey;
  final String? clockInIso;
  final String? clockOutIso;

  const TodayAttendanceState({
    required this.dateKey,
    this.clockInIso,
    this.clockOutIso,
  });

  TodayAttendanceState copyWith({
    String? dateKey,
    String? clockInIso,
    String? clockOutIso,
    bool clearClockIn = false,
    bool clearClockOut = false,
  }) {
    return TodayAttendanceState(
      dateKey: dateKey ?? this.dateKey,
      clockInIso: clearClockIn ? null : (clockInIso ?? this.clockInIso),
      clockOutIso: clearClockOut ? null : (clockOutIso ?? this.clockOutIso),
    );
  }

  Map<String, dynamic> toJson() => {
        'dateKey': dateKey,
        'clockInIso': clockInIso,
        'clockOutIso': clockOutIso,
      };

  factory TodayAttendanceState.fromJson(Map<String, dynamic> json) {
    return TodayAttendanceState(
      dateKey: json['dateKey'] as String,
      clockInIso: json['clockInIso'] as String?,
      clockOutIso: json['clockOutIso'] as String?,
    );
  }
}
