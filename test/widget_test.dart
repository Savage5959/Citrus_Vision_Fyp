import 'package:flutter_test/flutter_test.dart';
import 'package:untitled/app/app.dart';

void main() {
  testWidgets('App smoke test - verifies Get Started screen and navigation',
      (WidgetTester tester) async {
    await tester.pumpWidget(const OrangeDetectorApp());

    // Verify Get Started button is displayed on starting page
    expect(find.text('Get Started'), findsOneWidget);

    // Tap Get Started button and navigate to Home Screen
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Verify Home Screen is displayed
    expect(find.text('Hello Farmer! 👋'), findsOneWidget);
    expect(find.text('Upload Image'), findsOneWidget);
    expect(find.text('Open Camera'), findsOneWidget);
    expect(find.text('From Gallery'), findsOneWidget);
  });
}
