// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:fitnet/src/auth/authScreen.dart';
import 'package:fitnet/src/auth/loginPage.dart';
import 'package:fitnet/src/auth/signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers.dart';

void main() {
  initTests();

  group('Unit Tests', () {
    // nothing to unit test here
  });

  group('Component Tests', () {
    testWidgets('should have Log In tab', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(AuthScreen()));

      expect(find.widgetWithText(Tab, 'Log In'), findsOneWidget);
    });

    testWidgets('should have Sign Up tab', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(AuthScreen()));

      expect(find.widgetWithText(Tab, 'Sign Up'), findsOneWidget);
    });

    testWidgets('should have LoginPage', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(AuthScreen()));

      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('should have SignUpPage', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(AuthScreen()));

      final TabController controller = DefaultTabController.of(
          tester.element(find.widgetWithText(Tab, 'Log In')));
      expect(controller, isNotNull);
      expect(controller.index, 0);

      await tester.tap(find.widgetWithText(Tab, 'Sign Up'));
      await tester.pump();
      expect(controller.indexIsChanging, true);

      await tester.pump(const Duration(seconds: 1)); // finish the animation
      expect(controller.index, 1);
      expect(controller.previousIndex, 0);
      expect(controller.indexIsChanging, false);

      expect(find.byType(SignUpPage), findsOneWidget);
    });
  });
}
