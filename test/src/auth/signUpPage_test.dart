// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:fitnet/services/authService.dart';
import 'package:fitnet/src/auth/signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../../helpers.dart';
import '../../services/authService_test.dart';

void main() {
  initTests();
  GetIt injector = GetIt.instance;

  setUp(() {
    injector.unregister<AuthService>();
    injector.registerSingleton<AuthService>(MockAuthService());
  });

  group('Unit Tests', () {
    // Nothing to unit test
  });

  group('Component Tests', () {
    testWidgets('should have Email TextField', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(SignUpPage()));

      expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
    });

    testWidgets('should have Password TextField', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(SignUpPage()));

      expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
    });

    testWidgets('should have FirstName TextField', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(SignUpPage()));

      expect(find.widgetWithText(TextField, 'First Name'), findsOneWidget);
    });

    testWidgets('should have LastName TextField', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(SignUpPage()));

      expect(find.widgetWithText(TextField, 'Last Name'), findsOneWidget);
    });

    testWidgets('should have Sign Up Button', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(SignUpPage()));

      expect(find.widgetWithText(ElevatedButton, 'Sign up'), findsOneWidget);
    });

    testWidgets('should call authService sign up on button click',
        (WidgetTester tester) async {
      var numInvocations = 0;

      MockAuthService serviceMock = MockAuthService();
      when(serviceMock.signUp('test@test.com', '12345', 'First', 'Last'))
          .thenAnswer((_) {
        numInvocations++;
        return;
      });
      injector.unregister<AuthService>();
      injector.registerSingleton<AuthService>(serviceMock);

      await tester.pumpWidget(createWidgetForTesting(SignUpPage()));

      await tester.enterText(
          find.widgetWithText(TextField, 'Email'), 'test@test.com');
      await tester.enterText(
          find.widgetWithText(TextField, 'Password'), '12345');
      await tester.enterText(
          find.widgetWithText(TextField, 'First Name'), 'First');
      await tester.enterText(
          find.widgetWithText(TextField, 'Last Name'), 'Last');

      await tester.tap(find.byType(ElevatedButton));

      await tester.pump();

      expect(numInvocations, 1);
    });
  });
}
