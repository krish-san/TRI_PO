import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:criminal_form/accused_entry.dart';

void main() {
  testWidgets('Page 1 renders all fields and Next button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Page1()));

    expect(find.text('Name and Aliases'), findsOneWidget);
    expect(find.text("Father's/Husband's Name"), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Next'), findsOneWidget);
  });

  testWidgets('Page 2 shows modified hair, bald, appearance, walk, talk', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Page2()));

    expect(find.text('Hair Color'), findsOneWidget);
    expect(find.text('Bald?'), findsOneWidget);
    expect(find.text('Appearance (Upright/Slovenly)'), findsOneWidget);
    expect(find.text('Walk (Fast/Slow)'), findsOneWidget);
    expect(find.text('Talk (Fast/Slow, Loud/Harsh)'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Next'), findsOneWidget);
  });

  testWidgets('Page 3 shows facial features dropdowns and descriptions', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Page3()));

    expect(find.text('Beard - Color, Length, Style'), findsOneWidget);
    expect(find.text('Moustache - Color, Length'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Next'), findsOneWidget);
  });

  testWidgets('Page 4 includes marks and mannerism fields', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Page4()));

    expect(find.text('Marks on Hands'), findsOneWidget);
    expect(find.text('Habits'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Next'), findsOneWidget);
  });

  testWidgets('Page 5 photo upload boxes and submit button work', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Page5()));

    expect(find.text('Full Face Photo'), findsOneWidget);
    expect(find.text('Full Length Photo'), findsOneWidget);
    expect(find.text('Head and Shoulder Photo'), findsOneWidget);
    expect(find.text('Profile Left/Right Photo'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Submit'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Submit'));
    await tester.pump();
    expect(find.text('Form submitted successfully!'), findsOneWidget);
  });
}