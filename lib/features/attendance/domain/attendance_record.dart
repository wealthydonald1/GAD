class AttendanceRecord {
  final String date;
  final String clockIn;
  final String clockOut;

  AttendanceRecord({
    required this.date,
    required this.clockIn,
    required this.clockOut,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'clockIn': clockIn,
      'clockOut': clockOut,
    };
  }

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      date: json['date'],
      clockIn: json['clockIn'],
      clockOut: json['clockOut'],
    );
  }
}
