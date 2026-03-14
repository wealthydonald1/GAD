import 'package:flutter/material.dart';
import '../../../core/services/weekend_work_service.dart';

class ManagerWeekendApprovalScreen extends StatefulWidget {
  const ManagerWeekendApprovalScreen({super.key});

  @override
  State<ManagerWeekendApprovalScreen> createState() =>
      _ManagerWeekendApprovalScreenState();
}

class _ManagerWeekendApprovalScreenState
    extends State<ManagerWeekendApprovalScreen> {
  final WeekendWorkService _service = WeekendWorkService();
  List<String> _approvedIds = [];

  // This will eventually be replaced by a call to your DirectoryService
  final List<Map<String, String>> _mockStaff = [
    {'id': '101', 'name': 'Staff User 1'},
    {'id': '102', 'name': 'Staff User 2'},
    {'id': '103', 'name': 'Staff User 3'},
  ];

  @override
  void initState() {
    super.initState();
    _loadPermissions();
  }

  Future<void> _loadPermissions() async {
    final ids = await _service.getApprovedStaffIds();
    setState(() => _approvedIds = ids);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekend Work Control'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue.withOpacity(0.1),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Grant permission to staff who need to clock in during the weekend.',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _mockStaff.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final staff = _mockStaff[index];
                final staffId = staff['id']!;
                final isApproved = _approvedIds.contains(staffId);

                return ListTile(
                  title: Text(staff['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Employee ID: $staffId'),
                  trailing: Switch.adaptive(
                    value: isApproved,
                    activeColor: Colors.green,
                    onChanged: (bool value) async {
                      await _service.toggleApproval(staffId, value);
                      _loadPermissions();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
