import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import '../screens/get_started/get_started_screen.dart';

/// Root application widget configuring theme and home screen.
class OrangeDetectorApp extends StatelessWidget {
  const OrangeDetectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orange Detector',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const GetStartedScreen(),
    );
  }
}

