import 'package:flutter/material.dart';
import 'package:gad/features/auth/presentation/login_screen.dart';
import 'package:gad/features/auth/presentation/forgot_password_screen.dart';
import 'package:gad/features/dashboard/presentation/staff_dashboard.dart';
import 'package:gad/features/dashboard/presentation/manager_dashboard.dart';
import 'package:gad/features/attendance/presentation/clock_in_out_screen.dart';
import 'package:gad/features/attendance/presentation/history_screen.dart';
import 'package:gad/features/assessments/presentation/cycles_list_screen.dart';
import 'package:gad/features/assessments/presentation/appraisal_form_screen.dart';
import 'package:gad/features/assessments/presentation/results_view_screen.dart';
import 'package:gad/features/directory/presentation/directory_list_screen.dart';
import 'package:gad/features/directory/presentation/profile_screen.dart';

class AppRouter {
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String staffDashboard = '/staff';
  static const String managerDashboard = '/manager';
  static const String attendance = '/attendance';
  static const String attendanceHistory = '/attendance/history';
  static const String assessments = '/assessments';
  static const String appraisalForm = '/assessments/form';
  static const String results = '/assessments/results';
  static const String directory = '/directory';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    debugPrint('Route: ${settings.name}, args: ${settings.arguments}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case staffDashboard:
        return MaterialPageRoute(builder: (_) => const StaffDashboard());
      case managerDashboard:
        return MaterialPageRoute(builder: (_) => const ManagerDashboard());
      case attendance:
        return MaterialPageRoute(builder: (_) => const ClockInOutScreen());
      case attendanceHistory:
        return MaterialPageRoute(builder: (_) => const HistoryScreen());
      case assessments:
        return MaterialPageRoute(builder: (_) => const CyclesListScreen());
      case appraisalForm:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => AppraisalFormScreen(cycleId: args?['cycleId']),
        );
      case results:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ResultsViewScreen(resultId: args?['resultId']),
        );
      case directory:
        return MaterialPageRoute(builder: (_) => const DirectoryListScreen());
      case profile:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(employeeId: args?['employeeId']),
        );
      default:
        // 404 page
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                'Page not found',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
    }
  }
}
