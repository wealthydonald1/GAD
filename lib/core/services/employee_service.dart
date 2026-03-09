import 'package:gad/features/directory/domain/employee.dart';

class EmployeeService {
  final List<Employee> _employees = [
    Employee(
      id: 'staff001',
      name: 'John Doe',
      role: 'staff',
      department: 'Media',
      position: 'Content Officer',
    ),
    Employee(
      id: 'staff002',
      name: 'Mary James',
      role: 'staff',
      department: 'Protocol',
      position: 'Coordinator',
    ),
    Employee(
      id: 'mgr001',
      name: 'Pastor Daniel',
      role: 'manager',
      department: 'Operations',
      position: 'Team Manager',
    ),
  ];

  List<Employee> getEmployees() => _employees;

  Employee? getEmployeeById(String id) {
    try {
      return _employees.firstWhere(
        (employee) => employee.id.toLowerCase() == id.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }
}
