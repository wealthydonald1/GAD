import 'package:flutter/material.dart';
import 'package:gad/shared/widgets/custom_button.dart';
import 'package:gad/shared/widgets/app_card.dart';

class ClockInOutScreen extends StatefulWidget {
  const ClockInOutScreen({Key? key}) : super(key: key);

  @override
  State<ClockInOutScreen> createState() => _ClockInOutScreenState();
}

class _ClockInOutScreenState extends State<ClockInOutScreen> {
  bool isClockedIn = false;
  String? inTime;
  String? outTime;
  String breakTime = '1 hr';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Current time
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Text(
                      'Current Time',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      TimeOfDay.now().format(context),
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Status card
            AppCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isClockedIn ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          isClockedIn ? 'Clocked In' : 'Not Clocked In',
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _infoColumn('In Time', inTime ?? '--:--'),
                      _infoColumn('Out Time', outTime ?? '--:--'),
                      _infoColumn('Break', breakTime),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Action button
            CustomButton(
              text: isClockedIn ? 'Clock Out' : 'Clock In',
              onPressed: () {
                // TODO: Add biometric verification
                setState(() {
                  isClockedIn = !isClockedIn;
                  final now = TimeOfDay.now().format(context);
                  if (isClockedIn) {
                    inTime = now;
                  } else {
                    outTime = now;
                  }
                });
              },
              icon: Icons.fingerprint,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/attendance/history');
              },
              child: const Text('View History'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoColumn(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}