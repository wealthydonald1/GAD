import 'package:flutter/material.dart';
import 'package:gad/core/router/app_router.dart';
import 'package:gad/core/services/appraisal_service.dart';
import 'package:gad/shared/widgets/app_card.dart';

class ManagerDashboard extends StatelessWidget {
  const ManagerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final appraisalService = AppraisalService();
    final cycles = appraisalService.getCycles();
    final openCycles = cycles.where((c) => c.isOpen).length;
    final closedCycles = cycles.where((c) => !c.isOpen).length;

    // Mock manager-side staff data for now
    final staff = [
      {'name': 'Devika Mehta', 'attendance': 'Present', 'review': 'Pending'},
      {'name': 'Lewis Clark', 'attendance': 'On Leave', 'review': 'Pending'},
      {'name': 'Sara Bellum', 'attendance': 'Present', 'review': 'Completed'},
      {'name': 'Daniel Obi', 'attendance': 'Late', 'review': 'Pending'},
    ];

    final totalEmployees = staff.length;
    final presentCount =
        staff.where((e) => e['attendance'] == 'Present').length;
    final pendingReviews = staff.where((e) => e['review'] == 'Pending').length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manager Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.assignment),
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.assessments);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _analyticsCard(
                context,
                label: 'Total Employees',
                value: '$totalEmployees',
                subtitle: 'Team members',
              ),
              _analyticsCard(
                context,
                label: 'Present Today',
                value: '$presentCount',
                subtitle: 'Attendance snapshot',
              ),
              _analyticsCard(
                context,
                label: 'Pending Reviews',
                value: '$pendingReviews',
                subtitle: 'Need action',
              ),
              _analyticsCard(
                context,
                label: 'Open Cycles',
                value: '$openCycles',
                subtitle: '$closedCycles closed',
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Manager Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          AppCard(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.assignment_turned_in),
                  title: const Text('Review Appraisals'),
                  subtitle: const Text('Open pending employee reviews'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.assessments);
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.people),
                  title: const Text('Staff Directory'),
                  subtitle: const Text('View employee details'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.directory);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Staff Overview',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  _buildTableHeader(),
                  const Divider(),
                  ...staff.map((member) {
                    return _buildTableRow(
                      context,
                      member['name']!,
                      member['attendance']!,
                      member['review']!,
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _analyticsCard(
    BuildContext context, {
    required String label,
    required String value,
    required String subtitle,
  }) {
    final width = (MediaQuery.of(context).size.width - 56) / 2;

    return SizedBox(
      width: width,
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return const Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            'Employee',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Attendance',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Review',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildTableRow(
    BuildContext context,
    String name,
    String attendance,
    String review,
  ) {
    Color attendanceColor;
    switch (attendance) {
      case 'Present':
        attendanceColor = Colors.green;
        break;
      case 'Late':
        attendanceColor = Colors.orange;
        break;
      case 'On Leave':
        attendanceColor = Colors.blueGrey;
        break;
      default:
        attendanceColor = Colors.grey;
    }

    Color reviewColor = review == 'Completed' ? Colors.green : Colors.orange;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(name)),
          Expanded(
            flex: 2,
            child: Chip(
              label: Text(attendance),
              backgroundColor: attendanceColor.withOpacity(0.15),
            ),
          ),
          Expanded(
            flex: 2,
            child: Chip(
              label: Text(review),
              backgroundColor: reviewColor.withOpacity(0.15),
            ),
          ),
        ],
      ),
    );
  }
}
