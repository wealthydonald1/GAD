import 'package:flutter/material.dart';
import 'package:gad/core/services/appraisal_service.dart';
import 'package:gad/features/assessments/domain/appraisal_cycle.dart';
import 'package:gad/features/assessments/domain/kpi_question.dart';
import 'package:gad/shared/widgets/app_card.dart';
import 'package:gad/shared/widgets/app_chip.dart';
import 'package:gad/shared/widgets/custom_button.dart';

class AppraisalFormScreen extends StatefulWidget {
  final dynamic cycleId;

  const AppraisalFormScreen({super.key, this.cycleId});

  @override
  State<AppraisalFormScreen> createState() => _AppraisalFormScreenState();
}

class _AppraisalFormScreenState extends State<AppraisalFormScreen> {
  final AppraisalService _service = AppraisalService();
  final TextEditingController _commentController = TextEditingController();

  late List<KpiQuestion> _questions;
  AppraisalCycle? _cycle;

  final Map<String, int> _ratings = {};

  @override
  void initState() {
    super.initState();
    _questions = _service.getQuestions();

    final cycles = _service.getCycles();
    for (final cycle in cycles) {
      if (cycle.id == widget.cycleId) {
        _cycle = cycle;
        break;
      }
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

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

  void _saveDraft() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Draft saved')),
    );
  }

  void _submit() {
    final unanswered =
        _questions.where((q) => !_ratings.containsKey(q.id)).toList();

    if (unanswered.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please rate all questions before submitting')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Appraisal submitted')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final cycleTitle = _cycle?.title ?? 'Appraisal Review';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appraisal Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cycleTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _cycle == null
                  ? 'Cycle not found'
                  : 'Period: ${_formatDate(_cycle!.startDate)} - ${_formatDate(_cycle!.endDate)}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'Self Assessment',
              style: TextStyle(fontSize: 16),
            ),
            const Divider(height: 32),
            ..._questions.map((question) {
              final selectedRating = _ratings[question.id];

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.question,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Rate from 1 to ${question.maxScore}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: List.generate(question.maxScore, (index) {
                          final value = index + 1;

                          return AppChip(
                            label: '$value',
                            selected: selectedRating == value,
                            onSelected: () {
                              setState(() {
                                _ratings[question.id] = value;
                              });
                            },
                            type: ChipType.choice,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              );
            }),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Comments',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _commentController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Add your comments here...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Save Draft',
                    onPressed: _saveDraft,
                    isOutlined: true,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    text: 'Submit',
                    onPressed: _submit,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
