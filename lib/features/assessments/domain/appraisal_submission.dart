class AppraisalSubmission {
  final String cycleId;
  final String staffId;
  final Map<String, int> selfScores;
  final String comment;
  final bool submitted;

  final Map<String, int> managerScores;
  final String managerComment;
  final bool reviewed;

  AppraisalSubmission({
    required this.cycleId,
    required this.staffId,
    required this.selfScores,
    required this.comment,
    required this.submitted,
    this.managerScores = const {},
    this.managerComment = '',
    this.reviewed = false,
  });

  AppraisalSubmission copyWith({
    String? cycleId,
    String? staffId,
    Map<String, int>? selfScores,
    String? comment,
    bool? submitted,
    Map<String, int>? managerScores,
    String? managerComment,
    bool? reviewed,
  }) {
    return AppraisalSubmission(
      cycleId: cycleId ?? this.cycleId,
      staffId: staffId ?? this.staffId,
      selfScores: selfScores ?? this.selfScores,
      comment: comment ?? this.comment,
      submitted: submitted ?? this.submitted,
      managerScores: managerScores ?? this.managerScores,
      managerComment: managerComment ?? this.managerComment,
      reviewed: reviewed ?? this.reviewed,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cycleId': cycleId,
      'staffId': staffId,
      'selfScores': selfScores,
      'comment': comment,
      'submitted': submitted,
      'managerScores': managerScores,
      'managerComment': managerComment,
      'reviewed': reviewed,
    };
  }

  factory AppraisalSubmission.fromJson(Map<String, dynamic> json) {
    return AppraisalSubmission(
      cycleId: json['cycleId'] ?? '',
      staffId: json['staffId'] ?? '',
      selfScores: Map<String, int>.from(json['selfScores'] ?? {}),
      comment: json['comment'] ?? '',
      submitted: json['submitted'] ?? false,
      managerScores: Map<String, int>.from(json['managerScores'] ?? {}),
      managerComment: json['managerComment'] ?? '',
      reviewed: json['reviewed'] ?? false,
    );
  }
}
