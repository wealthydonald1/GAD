import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final dynamic employeeId;
  const ProfileScreen({Key? key, this.employeeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock data based on ID
    final name = employeeId == 0 ? 'Devika Mehta' : 'Lewis Clark';
    final role = employeeId == 0 ? 'Sr. Customer Manager' : 'Software Engineer';

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(name),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Profile'),
              Tab(text: 'Attendance'),
              Tab(text: 'Appraisals'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Profile Tab
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
                  const SizedBox(height: 16),
                  Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(role),
                  const Divider(height: 32),
                  ListTile(title: const Text('Employee Code'), trailing: Text('NAF2456')),
                  ListTile(title: const Text('Email'), trailing: Text('devika@example.com')),
                  ListTile(title: const Text('Reporting Manager'), trailing: Text('Mr. Mohit Rana')),
                ],
              ),
            ),
            // Attendance Tab
            const Center(child: Text('Attendance history will appear here')),
            // Appraisals Tab
            const Center(child: Text('Past appraisals will appear here')),
          ],
        ),
      ),
    );
  }
}