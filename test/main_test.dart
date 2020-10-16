// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:fitnet/src/authRouter.dart';
import 'package:fitnet/src/loadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fitnet/main.dart';

import 'helpers.dart';

void main() {
  initTests();
  Fitnet widget = Fitnet();

  group('Unit Tests', () {
    group('getPageForConnectionState', () {
      test('should return AuthRouter if connectionState is Done', () {
        Widget output = widget.getPageForConnectionState(ConnectionState.done);
        expect(output.runtimeType, AuthRouter);
      });
      test('should return LoadingScreen if connectionState is NOT Done', () {
        Widget output =
            widget.getPageForConnectionState(ConnectionState.waiting);
        expect(output.runtimeType, LoadingScreen);
      });
    });
  });

  group('Component Tests', () {
    testWidgets('title is Fitnet', (WidgetTester tester) async {
      await tester.pumpWidget(Fitnet());

      final titleFinder = find.text('Fitnet');
      expect(titleFinder, findsOneWidget);
    });
  });
}
