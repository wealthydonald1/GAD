import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock data
    final history = [
      {'date': '08 Jan 2019', 'in': '8:30 AM', 'out': '5:30 PM', 'hours': '8h'},
      {'date': '09 Jan 2019', 'in': '8:45 AM', 'out': '5:45 PM', 'hours': '8h'},
      {'date': '10 Jan 2019', 'in': '8:20 AM', 'out': '5:20 PM', 'hours': '8h'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Attendance History')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final item = history[index];
          return ListTile(
            title: Text(item['date']!),
            subtitle: Text('${item['in']} - ${item['out']}'),
            trailing: Text(item['hours']!),
          );
        },
      ),
    );
  }
}