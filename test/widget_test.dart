import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crime_management_system/accused_entry.dart';

void main() {
  testWidgets('Step 0: Personal Details form renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CriminalFormPage()));

    expect(find.text('Name and Aliases'), findsOneWidget);
    expect(find.text("Father's/Husband's Name"), findsOneWidget);
  });

  testWidgets('Step 1: Physical Description fields render correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CriminalFormPage()));

    // Move to Step 1
    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();

    expect(find.text('Hair Color'), findsOneWidget);
    expect(find.text('Bald?'), findsOneWidget);
    expect(find.text('Appearance (Upright/Slovenly)'), findsOneWidget);
    expect(find.text('Walk (Fast/Slow)'), findsOneWidget);
    expect(find.text('Talk (Fast/Slow, Loud/Harsh)'), findsOneWidget);
  });

  testWidgets('Step 2: Facial Features and dropdowns render correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CriminalFormPage()));

    // Move to Step 2
    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();

    expect(find.text('Beard - Color, Length, Style'), findsOneWidget);
    expect(find.text('Moustache - Color, Length'), findsOneWidget);
  });

  testWidgets('Step 3: Marks and Mannerisms fields render correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CriminalFormPage()));

    // Move to Step 3
    for (int i = 0; i < 3; i++) {
      await tester.tap(find.text('NEXT'));
      await tester.pumpAndSettle();
    }

    expect(find.text('Marks on Hands'), findsOneWidget);
    expect(find.text('Habits'), findsOneWidget);
  });

  testWidgets('Step 4: Photo upload fields and Submit button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CriminalFormPage()));

    // Move to Step 4 (Final Step)
    for (int i = 0; i < 4; i++) {
      await tester.tap(find.text('NEXT'));
      await tester.pumpAndSettle();
    }

    expect(find.text('Full Face Photo'), findsOneWidget);
    expect(find.text('Full Length Photo'), findsOneWidget);
    expect(find.text('Head and Shoulder Photo'), findsOneWidget);
    expect(find.text('Profile Left'), findsOneWidget);
    expect(find.text('Right Photo'), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);

    // Submit the form
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    expect(find.text('Form submitted successfully!'), findsOneWidget);
  });
}
