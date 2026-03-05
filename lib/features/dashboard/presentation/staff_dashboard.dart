import 'package:flutter/material.dart';
import 'package:gad/core/router/app_router.dart';
import 'package:gad/shared/widgets/app_card.dart';

class StaffDashboard extends StatelessWidget {
  const StaffDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: const [
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text('DM'),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Quick status card
          AppCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'You are clocked in',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text('In: 8:30 AM · Out: --:--'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouter.attendance);
                  },
                  child: const Text('Clock Out'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Stats cards
          Row(
            children: [
              _statCard(context, 'Days Present', '18', Icons.calendar_today),
              const SizedBox(width: 12),
              _statCard(context, 'Pending Reviews', '2', Icons.assignment),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Upcoming',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          AppCard(
            child: ListTile(
              leading: const Icon(Icons.assignment_turned_in),
              title: const Text('Q2 Appraisal'),
              subtitle: const Text('Due in 5 days'),
              trailing: Chip(
                label: const Text('Pending'),
                backgroundColor: Colors.orange[100],
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRouter.assessments);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(BuildContext context, String label, String value, IconData icon) {
    return Expanded(
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}