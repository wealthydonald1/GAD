import 'package:flutter/material.dart';
import 'package:gad/shared/widgets/app_card.dart';
import 'package:gad/core/router/app_router.dart';

class CyclesListScreen extends StatelessWidget {
  const CyclesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock cycles
    final cycles = [
      {'name': 'Q1 2024 Review', 'due': 'Apr 15, 2024', 'progress': 0.6},
      {'name': 'Q2 2024 Review', 'due': 'Jul 15, 2024', 'progress': 0.2},
      {'name': 'Annual 2023', 'due': 'Completed', 'progress': 1.0},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Appraisal Cycles')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cycles.length,
        itemBuilder: (context, index) {
            final cycle = cycles[index];
            final name = cycle['name'] as String;
            final due = cycle['due'] as String;
            final progress = cycle['progress'] as double;
            return AppCard(
                onTap: () {
                if (progress == 1.0) {
                    Navigator.pushNamed(context, AppRouter.results, arguments: {'resultId': index});
                } else {
                    Navigator.pushNamed(context, AppRouter.appraisalForm, arguments: {'cycleId': index});
                }
                },
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Chip(
                        label: Text(due),
                        backgroundColor: progress == 1.0 ? Colors.green : Colors.orange,
                        ),
                    ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(value: progress),
                    const SizedBox(height: 4),
                    Text('${(progress * 100).toInt()}% completed'),
                ],
                ),
            );
            },
      ),
    );
  }
}