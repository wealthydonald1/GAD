import 'package:flutter/material.dart';
import 'package:gad/core/services/attendance_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _attendance = AttendanceService();
  bool _loading = true;
  List<AttendanceEntry> _history = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final list = await _attendance.loadHistory();
    if (!mounted) return;
    setState(() {
      _history = list;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance History')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : (_history.isEmpty
              ? const Center(child: Text('No history yet'))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _history.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final item = _history[index];
                    return ListTile(
                      title: Text(item.date),
                      subtitle: Text('${item.inTime} - ${item.outTime}'),
                    );
                  },
                )),
    );
  }
}