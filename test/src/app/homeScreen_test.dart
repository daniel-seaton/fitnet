import 'package:fitnet/src/app/create/createPage.dart';
import 'package:fitnet/src/app/homeScreen.dart';
import 'package:fitnet/src/app/profile/profilePage.dart';
import 'package:fitnet/src/app/workout/workoutPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers.dart';

void main() {
  initTests();

  group('Unit Tests', () {
    // Nothing to unit test
  });

  group('Component Tests', () {
    testWidgets('should have Create tab', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(HomeScreen()));

      expect(find.widgetWithText(Tab, 'Create'), findsOneWidget);
    });

    testWidgets('should have Workout tab', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(HomeScreen()));

      expect(find.widgetWithText(Tab, 'Workout'), findsOneWidget);
    });

    testWidgets('should have Profile tab', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(HomeScreen()));

      expect(find.widgetWithText(Tab, 'Profile'), findsOneWidget);
    });

    testWidgets('should have CreatePage', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(HomeScreen()));

      expect(find.byType(CreatePage), findsOneWidget);
    });

    testWidgets('should have WorkoutPage', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(HomeScreen()));

      final TabController controller = DefaultTabController.of(
          tester.element(find.widgetWithText(Tab, 'Workout')));
      expect(controller, isNotNull);
      expect(controller.index, 0);

      await tester.tap(find.widgetWithText(Tab, 'Workout'));
      await tester.pump();
      expect(controller.indexIsChanging, true);

      await tester.pump(const Duration(seconds: 1)); // finish the animation
      expect(controller.index, 1);
      expect(controller.previousIndex, 0);
      expect(controller.indexIsChanging, false);

      expect(find.byType(WorkoutPage), findsOneWidget);
    });

    testWidgets('should have ProfilePage', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(HomeScreen()));

      final TabController controller = DefaultTabController.of(
          tester.element(find.widgetWithText(Tab, 'Profile')));
      expect(controller, isNotNull);
      expect(controller.index, 0);

      await tester.tap(find.widgetWithText(Tab, 'Profile'));
      await tester.pump();
      expect(controller.indexIsChanging, true);

      await tester.pump(const Duration(seconds: 1)); // finish the animation
      expect(controller.index, 2);
      expect(controller.previousIndex, 0);
      expect(controller.indexIsChanging, false);

      expect(find.byType(ProfilePage), findsOneWidget);
    });
  });
}
