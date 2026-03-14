import 'package:flutter/material.dart';
import 'package:gad/core/router/app_router.dart';
import 'package:gad/core/services/auth_service.dart';
import 'package:gad/shared/widgets/app_card.dart';

class StaffDashboard extends StatelessWidget {
  const StaffDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.profile);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final auth = AuthService();
              await auth.logout();

              if (!context.mounted) return;

              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRouter.login,
                (route) => false,
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 12,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 220),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Attendance',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text('Clock in or out for today'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouter.attendance);
                  },
                  child: const Text('Open'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          AppCard(
            child: ListTile(
              leading: const Icon(Icons.assignment_turned_in),
              title: const Text('Performance Appraisal'),
              subtitle: const Text('Open appraisal cycles'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, AppRouter.assessments);
              },
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            child: ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Attendance History'),
              subtitle: const Text('View past attendance records'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, AppRouter.attendanceHistory);
              },
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            child: ListTile(
              leading: const Icon(Icons.event_note),
              title: const Text('Request Leave'),
              subtitle: const Text('Submit a leave request'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, AppRouter.leaveRequest);
              },
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            child: ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('My Leave Requests'),
              subtitle: const Text('View leave request history'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, AppRouter.leaveHistory);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Expanded(
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
