import '../../features/assessments/domain/appraisal_cycle.dart';
import '../../features/assessments/domain/kpi_question.dart';

class AppraisalService {
  List<AppraisalCycle> getCycles() {
    return [
      AppraisalCycle(
        id: 'q1_2026',
        title: 'Q1 2026 Performance Review',
        startDate: DateTime(2026, 1, 1),
        endDate: DateTime(2026, 3, 31),
        isOpen: true,
      ),
      AppraisalCycle(
        id: 'q2_2026',
        title: 'Q2 2026 Performance Review',
        startDate: DateTime(2026, 4, 1),
        endDate: DateTime(2026, 6, 30),
        isOpen: false,
      ),
    ];
  }

  List<KpiQuestion> getQuestions() {
    return [
      KpiQuestion(
        id: 'quality',
        question: 'Quality of Work',
        maxScore: 5,
      ),
      KpiQuestion(
        id: 'communication',
        question: 'Communication',
        maxScore: 5,
      ),
      KpiQuestion(
        id: 'teamwork',
        question: 'Team Collaboration',
        maxScore: 5,
      ),
      KpiQuestion(
        id: 'initiative',
        question: 'Initiative',
        maxScore: 5,
      ),
      KpiQuestion(
        id: 'leadership',
        question: 'Leadership',
        maxScore: 5,
      ),
    ];
  }
}
