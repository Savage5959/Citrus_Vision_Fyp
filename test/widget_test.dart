import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:untitled/app/app.dart';
import 'package:untitled/services/language_service.dart';

void main() {
  testWidgets('App smoke test - verifies Get Started, Home, Settings, and Multilingual switching',
      (WidgetTester tester) async {
    // Reset language to English before test
    LanguageService.instance.setLanguage(AppLanguages.english);

    await tester.pumpWidget(const OrangeDetectorApp());

    // 1. Verify Get Started screen
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.byType(Image), findsWidgets);

    // 2. Navigate to Home Screen
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Verify Home Screen content in English
    expect(find.text('Hello Farmer! 👋'), findsOneWidget);
    expect(find.text('Upload Image'), findsOneWidget);
    expect(find.text('Open Camera'), findsOneWidget);
    expect(find.text('From Gallery'), findsOneWidget);

    // 3. Navigate to Settings tab
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();

    // Verify Settings content in English
    expect(find.text('App Language'), findsOneWidget);
    expect(find.text('About App'), findsOneWidget);
    expect(find.text('Model Info'), findsOneWidget);
    expect(find.text('Orange Detector v1.0'), findsOneWidget);

    // 4. Test Language Change to Spanish
    await tester.tap(find.text('App Language'));
    await tester.pumpAndSettle();
    expect(find.text('Spanish'), findsOneWidget);
    await tester.tap(find.text('Spanish'));
    await tester.pumpAndSettle();

    // Verify UI updated to Spanish
    expect(find.text('Idioma de la App'), findsOneWidget);
    expect(find.text('Acerca de la App'), findsOneWidget);
    expect(find.text('Info del Modelo'), findsOneWidget);
    expect(find.text('Inicio'), findsOneWidget);

    // 5. Test Language Change to Urdu
    await tester.tap(find.text('Idioma de la App'));
    await tester.pumpAndSettle();
    expect(find.text('Urdu'), findsOneWidget);
    await tester.tap(find.text('Urdu'));
    await tester.pumpAndSettle();

    // Verify UI updated to Urdu
    expect(find.text('ایپ کی زبان'), findsOneWidget);
    expect(find.text('ایپ کے بارے میں'), findsOneWidget);
    expect(find.text('ماڈل کی معلومات'), findsOneWidget);
    expect(find.text('ہوم'), findsOneWidget);

    // 6. Test Language Change to Arabic
    await tester.tap(find.text('ایپ کی زبان'));
    await tester.pumpAndSettle();
    expect(find.text('Arabic'), findsOneWidget);
    await tester.tap(find.text('Arabic'));
    await tester.pumpAndSettle();

    // Verify UI updated to Arabic
    expect(find.text('لغة التطبيق'), findsOneWidget);
    expect(find.text('حول التطبيق'), findsOneWidget);
    expect(find.text('الرئيسية'), findsOneWidget);

    // 7. Switch back to English
    await tester.tap(find.text('لغة التطبيق'));
    await tester.pumpAndSettle();
    expect(find.text('English'), findsOneWidget);
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    expect(find.text('App Language'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
  });
}
