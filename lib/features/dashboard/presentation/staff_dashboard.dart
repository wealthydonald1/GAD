import 'package:flutter/material.dart';
import 'package:gad/core/router/app_router.dart';
import 'package:gad/core/services/auth_service.dart';
import 'package:gad/core/services/attendance_service.dart';
import 'package:gad/shared/widgets/app_card.dart';

class StaffDashboard extends StatefulWidget {
  const StaffDashboard({super.key});

  @override
  State<StaffDashboard> createState() => _StaffDashboardState();
}

class _StaffDashboardState extends State<StaffDashboard> {
  String _staffId = '';
  bool _isClockedIn = false;
  String? _inTime;
  String? _outTime;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final auth = AuthService();
    final attendance = AttendanceService();

    final staffId = await auth.getCurrentUser();
    final state = await attendance.getClockState();

    if (!mounted) return;

    setState(() {
      _staffId = staffId ?? '';
      _isClockedIn = state['isClockedIn'] as bool? ?? false;
      _inTime = state['inTime'] as String?;
      _outTime = state['outTime'] as String?;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
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
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome back',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _staffId.isEmpty
                        ? 'Staff ID not available'
                        : 'Staff ID: $_staffId',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AppCard(
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 12,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 220),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isClockedIn
                              ? 'You are clocked in'
                              : 'You are not clocked in',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'In: ${_inTime ?? '--:--'} · Out: ${_outTime ?? '--:--'}',
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await Navigator.pushNamed(context, AppRouter.attendance);
                      await _loadData();
                    },
                    child: Text(_isClockedIn ? 'Clock Out' : 'Clock In'),
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            AppCard(
              child: ListTile(
                leading: const Icon(Icons.assignment_turned_in),
                title: const Text('Q2 Appraisal'),
                subtitle: const Text('Due in 5 days'),
                trailing: const Chip(
                  label: Text('Pending'),
                  backgroundColor: Colors.orange,
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.assessments);
                },
              ),
            ),
          ],
        ),
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
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(label, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
