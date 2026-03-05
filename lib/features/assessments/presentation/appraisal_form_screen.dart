import 'package:flutter/material.dart';
import 'package:gad/shared/widgets/custom_button.dart';
import 'package:gad/shared/widgets/app_card.dart';
import 'package:gad/shared/widgets/app_chip.dart';

class AppraisalFormScreen extends StatefulWidget {
  final dynamic cycleId;
  const AppraisalFormScreen({Key? key, this.cycleId}) : super(key: key);

  @override
  State<AppraisalFormScreen> createState() => _AppraisalFormScreenState();
}

class _AppraisalFormScreenState extends State<AppraisalFormScreen> {
  int? selectedRating;
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appraisal Form')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Q1 2024 Review', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('Devika Mehta - Sr. Customer Manager'),
            const Divider(height: 32),
            const Text('Core Values', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Teamwork'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: List.generate(5, (index) {
                      return AppChip(
                        label: '${index + 1}',
                        selected: selectedRating == index + 1,
                        onSelected: () {
                          setState(() => selectedRating = index + 1);
                        },
                        type: ChipType.choice,
                      );
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Comments'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: commentController,
                    maxLines: 3,
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
                    onPressed: () {},
                    isOutlined: true,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    text: 'Submit',
                    onPressed: () {
                      // TODO: Submit
                      Navigator.pop(context);
                    },
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