import 'package:flutter/material.dart';
import '../../../core/services/attendance_service.dart';
import '../domain/attendance_record.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final AttendanceService _service = AttendanceService();
  List<AttendanceRecord> _history = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final data = await _service.getHistory();
    setState(() {
      _history = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance History')),
      body: _history.isEmpty
          ? const Center(child: Text('No attendance records yet'))
          : ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final record = _history[index];

                return ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: Text(record.date),
                  subtitle: Text(
                    'In: ${record.clockIn}  |  Out: ${record.clockOut}',
                  ),
                );
              },
            ),
    );
  }
}
