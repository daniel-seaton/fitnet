// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:fitnet/main.dart';

import 'helpers.dart';

void main() {
  initTests();
  Fitnet widget = Fitnet();

  group('Unit Tests', () {
    // No unit tests needed
  });

  group('Component Tests', () {
    testWidgets('title is Fitnet', (WidgetTester tester) async {
      await tester.pumpWidget(Fitnet());

      final titleFinder = find.text('Fitnet');
      expect(titleFinder, findsOneWidget);
    });
  });
}
