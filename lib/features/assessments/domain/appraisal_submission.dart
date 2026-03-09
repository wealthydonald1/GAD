class AppraisalSubmission {
  final String cycleId;
  final String staffId;
  final Map<String, int> selfScores;
  final Map<String, int>? managerScores;
  final String? managerComment;
  final bool submitted;

  AppraisalSubmission({
    required this.cycleId,
    required this.staffId,
    required this.selfScores,
    this.managerScores,
    this.managerComment,
    required this.submitted,
  });
}
