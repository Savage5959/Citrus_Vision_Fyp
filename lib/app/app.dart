import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import '../screens/get_started/get_started_screen.dart';
import '../services/language_service.dart';

/// Root application widget configuring theme, language reactivity, and home screen.
class OrangeDetectorApp extends StatelessWidget {
  const OrangeDetectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LanguageService.instance,
      builder: (context, _) {
        final languageService = LanguageService.instance;
        return MaterialApp(
          title: languageService.tr('app_name'),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          locale: languageService.currentLocale,
          builder: (context, child) {
            return Directionality(
              textDirection: languageService.textDirection,
              child: child!,
            );
          },
          home: const GetStartedScreen(),
        );
      },
    );
  }
}
