import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:untitled/app/app.dart';

void main() {
  testWidgets('App smoke test - verifies Get Started, Home, and Settings screens',
      (WidgetTester tester) async {
    await tester.pumpWidget(const OrangeDetectorApp());

    // 1. Verify Get Started screen
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.byType(Image), findsWidgets);

    // 2. Navigate to Home Screen
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Verify Home Screen content
    expect(find.text('Hello Farmer! 👋'), findsOneWidget);
    expect(find.text('Upload Image'), findsOneWidget);
    expect(find.text('Open Camera'), findsOneWidget);
    expect(find.text('From Gallery'), findsOneWidget);

    // 3. Navigate to Settings tab
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();

    // Verify Settings content
    expect(find.text('App Language'), findsOneWidget);
    expect(find.text('About App'), findsOneWidget);
    expect(find.text('Model Info'), findsOneWidget);
    expect(find.text('Orange Detector v1.0'), findsOneWidget);
  });
}
