// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:fitnet/services/authService.dart';
import 'package:fitnet/src/auth/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  initTests();

  group('Unit Tests', () {
    // Nothing to unit test
  });

  group('Component Tests', () {
    testWidgets('should have Email TextField', (WidgetTester tester) async {
      await tester.pumpWidget(
          createWidgetForTesting(LoginPage(authService: MockAuthService())));

      expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
    });

    testWidgets('should have Password TextField', (WidgetTester tester) async {
      await tester.pumpWidget(
          createWidgetForTesting(LoginPage(authService: MockAuthService())));

      expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
    });

    testWidgets('should have Log In Button', (WidgetTester tester) async {
      await tester.pumpWidget(
          createWidgetForTesting(LoginPage(authService: MockAuthService())));

      expect(find.widgetWithText(ElevatedButton, 'Log In'), findsOneWidget);
    });

    testWidgets('should call authService login on button click',
        (WidgetTester tester) async {
      final MockAuthService serviceMock = MockAuthService();

      await tester.pumpWidget(
          createWidgetForTesting(LoginPage(authService: serviceMock)));

      await tester.enterText(
          find.widgetWithText(TextField, 'Email'), 'test@test.com');
      await tester.enterText(
          find.widgetWithText(TextField, 'Password'), '12345');

      await tester.tap(find.byType(ElevatedButton));

      await tester.pump();

      verify(serviceMock.login('test@test.com', '12345')).called(1);
    });
  });
}
