import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/routes/home/homeScreen.dart';
import 'package:fitnet/routes/home/profile/profilePage.dart';
import 'package:fitnet/routes/home/workout/workoutPage.dart';
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
      await tester.pumpWidget(
          createWidgetForTesting(HomeScreen(userId: AppUser.mock().uid)));

      expect(find.widgetWithText(Tab, 'Create'), findsOneWidget);
    });

    testWidgets('should have Workout tab', (WidgetTester tester) async {
      await tester.pumpWidget(
          createWidgetForTesting(HomeScreen(userId: AppUser.mock().uid)));

      expect(find.widgetWithText(Tab, 'Workout'), findsOneWidget);
    });

    testWidgets('should have Profile tab', (WidgetTester tester) async {
      await tester.pumpWidget(
          createWidgetForTesting(HomeScreen(userId: AppUser.mock().uid)));

      expect(find.widgetWithText(Tab, 'Profile'), findsOneWidget);
    });

    testWidgets('should have WorkoutPage', (WidgetTester tester) async {
      await tester.pumpWidget(
          createWidgetForTesting(HomeScreen(userId: AppUser.mock().uid)));

      expect(find.byType(WorkoutPage), findsOneWidget);
    });

    testWidgets('should have ProfilePage', (WidgetTester tester) async {
      await tester.pumpWidget(
          createWidgetForTesting(HomeScreen(userId: AppUser.mock().uid)));

      final TabController controller = DefaultTabController.of(
          tester.element(find.widgetWithText(Tab, 'Profile')));
      expect(controller, isNotNull);
      expect(controller.index, 0);

      await tester.tap(find.widgetWithText(Tab, 'Profile'));
      await tester.pump();
      expect(controller.indexIsChanging, true);

      await tester.pump(const Duration(seconds: 1)); // finish the animation
      expect(controller.index, 1);
      expect(controller.previousIndex, 0);
      expect(controller.indexIsChanging, false);

      expect(find.byType(ProfilePage), findsOneWidget);
    });
  });
}
