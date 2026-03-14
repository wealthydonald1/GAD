import 'package:flutter/material.dart';
import 'package:gad/features/assessments/domain/appraisal_submission.dart';
import 'package:gad/features/assessments/presentation/appraisal_form_screen.dart';
import 'package:gad/features/assessments/presentation/cycles_list_screen.dart';
import 'package:gad/features/assessments/presentation/manager_review_screen.dart';
import 'package:gad/features/assessments/presentation/results_view_screen.dart';
import 'package:gad/features/attendance/presentation/clock_in_out_screen.dart';
import 'package:gad/features/attendance/presentation/history_screen.dart';
import 'package:gad/features/auth/presentation/forgot_password_screen.dart';
import 'package:gad/features/auth/presentation/login_screen.dart';
import 'package:gad/features/dashboard/presentation/manager_dashboard.dart';
import 'package:gad/features/dashboard/presentation/staff_dashboard.dart';
import 'package:gad/features/directory/presentation/directory_list_screen.dart';
import 'package:gad/features/directory/presentation/profile_screen.dart';
import 'package:gad/features/leave/presentation/leave_history_screen.dart';
import 'package:gad/features/leave/presentation/leave_request_screen.dart';
import 'package:gad/features/leave/presentation/manager_leave_requests_screen.dart';

class AppRouter {
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';

  static const String staffDashboard = '/staff-dashboard';
  static const String managerDashboard = '/manager-dashboard';

  static const String attendance = '/attendance';
  static const String attendanceHistory = '/attendance/history';

  static const String assessments = '/assessments';
  static const String appraisalForm = '/assessments/form';
  static const String managerReview = '/assessments/manager-review';
  static const String resultsView = '/assessments/results';

  static const String directory = '/directory';
  static const String profile = '/profile';

  static const String leaveRequest = '/leave/request';
  static const String leaveHistory = '/leave/history';
  static const String managerLeaveRequests = '/leave/manager';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
        return MaterialPageRoute(builder: (_) => const AppraisalFormScreen());

      case managerReview:
        final submission = settings.arguments as AppraisalSubmission;
        return MaterialPageRoute(
          builder: (_) => ManagerReviewScreen(submission: submission),
        );

      case resultsView:
        return MaterialPageRoute(builder: (_) => const ResultsViewScreen());

      case directory:
        return MaterialPageRoute(builder: (_) => const DirectoryListScreen());

      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case leaveRequest:
        return MaterialPageRoute(builder: (_) => const LeaveRequestScreen());

      case leaveHistory:
        return MaterialPageRoute(builder: (_) => const LeaveHistoryScreen());

      case managerLeaveRequests:
        return MaterialPageRoute(
          builder: (_) => const ManagerLeaveRequestsScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Page not found')),
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
