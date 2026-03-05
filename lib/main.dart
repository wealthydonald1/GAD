import 'package:flutter/material.dart';
import 'package:gad/core/theme/app_theme.dart';
import 'package:gad/core/router/app_router.dart';

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

      // ✅ LIGHT MODE ONLY for now
      theme: AppTheme.lightTheme(),
      themeMode: ThemeMode.light,

      // If you want routing enabled:
      initialRoute: '/',
      onGenerateRoute: AppRouter.generateRoute,

      // If you want to bypass routing temporarily, comment the two lines above
      // and use this:
      // home: const StaffDashboard(),
    );
  }
}