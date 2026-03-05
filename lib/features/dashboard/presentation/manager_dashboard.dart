import 'package:flutter/material.dart';
import 'package:gad/shared/widgets/app_card.dart';

class ManagerDashboard extends StatelessWidget {
  const ManagerDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manager Dashboard'),
        actions: [
          IconButton(icon: const Icon(Icons.date_range), onPressed: () {}),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Analytics cards
          const Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _AnalyticsCard(label: 'Total Employees', value: '124', change: '+2'),
              _AnalyticsCard(label: 'On Leave', value: '3', change: '-1'),
              _AnalyticsCard(label: 'Pending Reviews', value: '12', change: '+5'),
              _AnalyticsCard(label: 'Avg Score', value: '4.2', change: '+0.3'),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Staff Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          // Simple table
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  _buildTableHeader(),
                  const Divider(),
                  _buildTableRow('Devika Mehta', 'Present', 'Review'),
                  _buildTableRow('Lewis Clark', 'Leave', 'Review'),
                  _buildTableRow('Sara Bellum', 'Present', 'Review'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return const Row(
      children: [
        Expanded(child: Text('Employee', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text('Action', style: TextStyle(fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget _buildTableRow(String name, String status, String action) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(name)),
          Expanded(
            child: Chip(
              label: Text(status),
              backgroundColor: status == 'Present' ? Colors.green[100] : Colors.orange[100],
            ),
          ),
          Expanded(child: TextButton(onPressed: () {}, child: Text(action))),
        ],
      ),
    );
  }
}

class _AnalyticsCard extends StatelessWidget {
  final String label, value, change;
  const _AnalyticsCard({required this.label, required this.value, required this.change});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 48) / 2, // 2 per row with spacing
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(change, style: TextStyle(color: change.startsWith('+') ? Colors.green : Colors.red)),
          ],
        ),
      ),
    );
  }
}