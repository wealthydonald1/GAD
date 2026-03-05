import 'package:flutter/material.dart';
import 'package:gad/core/theme/app_theme.dart';
import 'package:gad/core/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GAD - Work Management',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.system,
      initialRoute: '/',  // Start at root, which maps to staff dashboard
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}