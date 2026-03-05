import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResultsViewScreen extends StatelessWidget {
  final dynamic resultId;
  const ResultsViewScreen({Key? key, this.resultId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appraisal Results')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: CircularPercentIndicator(
                radius: 80,
                lineWidth: 10,
                percent: 0.85,
                center: const Text('4.2/5', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                progressColor: Colors.green,
                backgroundColor: Colors.grey[300]!,
              ),
            ),
            const SizedBox(height: 24),
            const Text('Category Breakdown', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            ListTile(
              title: const Text('Teamwork'),
              trailing: const Text('4/5'),
              subtitle: LinearProgressIndicator(value: 0.8),
            ),
            ListTile(
              title: const Text('Communication'),
              trailing: const Text('5/5'),
              subtitle: LinearProgressIndicator(value: 1.0),
            ),
            ListTile(
              title: const Text('Goal Achievement'),
              trailing: const Text('3/5'),
              subtitle: LinearProgressIndicator(value: 0.6),
            ),
            const Divider(),
            const Text('Manager Comments:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Devika has shown great improvement in teamwork. Continue to focus on goal setting.'),
          ],
        ),
      ),
    );
  }
}