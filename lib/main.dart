import 'package:flutter/material.dart';
import 'package:gad/core/router/app_router.dart';
import 'package:gad/core/services/auth_service.dart';
import 'package:gad/core/services/biometric_service.dart';
import 'package:gad/core/theme/app_theme.dart';
import 'package:gad/features/auth/presentation/login_screen.dart';
import 'package:gad/features/dashboard/presentation/staff_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GAD - Work Management',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      onGenerateRoute: AppRouter.generateRoute,
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final AuthService _authService = AuthService();
  final BiometricService _biometricService = BiometricService();

  bool _loading = true;
  Widget _screen = const Scaffold(
    body: Center(child: CircularProgressIndicator()),
  );

  @override
  void initState() {
    super.initState();
    _decideStartScreen();
  }

  Future<void> _decideStartScreen() async {
    final loggedIn = await _authService.isLoggedIn();

    if (!loggedIn) {
      if (!mounted) return;
      setState(() {
        _screen = const LoginScreen();
        _loading = false;
      });
      return;
    }

    final biometricEnabled = await _authService.isBiometricEnabled();

    if (!biometricEnabled) {
      if (!mounted) return;
      setState(() {
        _screen = const StaffDashboard();
        _loading = false;
      });
      return;
    }

    final canCheck = await _biometricService.canCheck();

    if (!canCheck) {
      if (!mounted) return;
      setState(() {
        _screen = const StaffDashboard();
        _loading = false;
      });
      return;
    }

    final ok = await _biometricService.authenticate(
      reason: 'Authenticate to continue to your dashboard',
    );

    if (!mounted) return;

    setState(() {
      _screen = ok ? const StaffDashboard() : const LoginScreen();
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return _screen;
    return _screen;
  }
}
