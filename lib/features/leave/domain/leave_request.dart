class LeaveRequest {
  final String id;
  final String staffId;
  final String leaveType;
  final String startDate;
  final String endDate;
  final String reason;
  final String status; // Pending, Approved, Rejected
  final String submittedAt;

  LeaveRequest({
    required this.id,
    required this.staffId,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
    required this.submittedAt,
  });

  LeaveRequest copyWith({
    String? id,
    String? staffId,
    String? leaveType,
    String? startDate,
    String? endDate,
    String? reason,
    String? status,
    String? submittedAt,
  }) {
    return LeaveRequest(
      id: id ?? this.id,
      staffId: staffId ?? this.staffId,
      leaveType: leaveType ?? this.leaveType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      submittedAt: submittedAt ?? this.submittedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'staffId': staffId,
      'leaveType': leaveType,
      'startDate': startDate,
      'endDate': endDate,
      'reason': reason,
      'status': status,
      'submittedAt': submittedAt,
    };
  }

  factory LeaveRequest.fromJson(Map<String, dynamic> json) {
    return LeaveRequest(
      id: json['id'] ?? '',
      staffId: json['staffId'] ?? '',
      leaveType: json['leaveType'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      reason: json['reason'] ?? '',
      status: json['status'] ?? 'Pending',
      submittedAt: json['submittedAt'] ?? '',
    );
  }
}
