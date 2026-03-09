import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:gad/core/services/appraisal_service.dart';
import 'package:gad/features/assessments/domain/appraisal_cycle.dart';
import 'package:gad/features/assessments/domain/kpi_question.dart';

class ResultsViewScreen extends StatelessWidget {
  final dynamic resultId;

  const ResultsViewScreen({super.key, this.resultId});

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final service = AppraisalService();
    final List<AppraisalCycle> cycles = service.getCycles();
    final List<KpiQuestion> questions = service.getQuestions();

    AppraisalCycle? cycle;
    for (final c in cycles) {
      if (c.id == resultId) {
        cycle = c;
        break;
      }
    }

    // Mock result scores for now, aligned with the KPI structure
    final Map<String, int> scores = {
      'quality': 4,
      'communication': 5,
      'teamwork': 4,
      'initiative': 3,
      'leadership': 5,
    };

    final totalScore = scores.values.fold<int>(0, (sum, item) => sum + item);
    final maxScore = questions.fold<int>(0, (sum, q) => sum + q.maxScore);
    final average = totalScore / questions.length;
    final percent = totalScore / maxScore;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appraisal Results'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (cycle != null) ...[
              Text(
                cycle.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                'Period: ${_formatDate(cycle.startDate)} - ${_formatDate(cycle.endDate)}',
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
            ],
            Center(
              child: CircularPercentIndicator(
                radius: 80,
                lineWidth: 10,
                percent: percent.clamp(0.0, 1.0),
                center: Text(
                  '${average.toStringAsFixed(1)}/5',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                progressColor: Colors.green,
                backgroundColor: Colors.grey[300]!,
              ),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Category Breakdown',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            ...questions.map((question) {
              final score = scores[question.id] ?? 0;
              final progress = score / question.maxScore;

              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(question.question),
                trailing: Text('$score/${question.maxScore}'),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: LinearProgressIndicator(value: progress),
                ),
              );
            }),
            const Divider(),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Manager Comments:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Strong overall performance. Continue improving initiative and maintain excellent communication and leadership standards.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
