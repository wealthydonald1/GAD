import 'package:flutter/material.dart';
import 'package:gad/core/router/app_router.dart';
import 'package:gad/core/services/appraisal_service.dart';
import 'package:gad/features/assessments/domain/appraisal_cycle.dart';
import 'package:gad/shared/widgets/app_card.dart';

class CyclesListScreen extends StatelessWidget {
  const CyclesListScreen({super.key});

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

    return Scaffold(
      appBar: AppBar(title: const Text('Appraisal Cycles')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cycles.length,
        itemBuilder: (context, index) {
          final cycle = cycles[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppCard(
              onTap: () {
                if (cycle.isOpen) {
                  Navigator.pushNamed(
                    context,
                    AppRouter.appraisalForm,
                    arguments: {'cycleId': cycle.id},
                  );
                } else {
                  Navigator.pushNamed(
                    context,
                    AppRouter.results,
                    arguments: {'resultId': cycle.id},
                  );
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          cycle.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Chip(
                        label: Text(cycle.isOpen ? 'Open' : 'Closed'),
                        backgroundColor:
                            cycle.isOpen ? Colors.orange : Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start: ${_formatDate(cycle.startDate)}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'End: ${_formatDate(cycle.endDate)}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: cycle.isOpen ? 0.5 : 1.0,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    cycle.isOpen ? 'In progress' : 'Completed',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
