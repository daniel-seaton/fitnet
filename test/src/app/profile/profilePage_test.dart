import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/services/userService.dart';
import 'package:fitnet/src/app/profile/infoScreenSelector/infoScreenSelector.dart';
import 'package:fitnet/src/app/profile/infoScreenSelector/userInfo/userInfo.dart';
import 'package:fitnet/src/app/profile/infoScreenSelector/userStats/userStats.dart';
import 'package:fitnet/src/app/profile/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers.dart';
import '../../../services/userService_test.dart';

void main() {
  initTests();

  GetIt injector = GetIt.instance;
  UserService serviceMock;

  setUp(() {
    injector.unregister<UserService>();
    serviceMock = MockUserService();
    injector.registerSingleton<UserService>(serviceMock);
  });
  group('Unit Tests', () {
    // Nothing to unit test
  });

  group('Component Tests', () {
    testWidgets(
        'should display loading if userService.getUserStream returns null',
        (WidgetTester tester) async {
      var userId = '000000';
      when(serviceMock.getUserStream(userId))
          .thenAnswer((_) => Stream.value(null));

      await tester
          .pumpWidget(createWidgetForTesting(ProfilePage(userId: userId)));

      expect(find.text('Loading...'), findsOneWidget);
    });

    testWidgets(
        'should display InfoScreenSelector if userService.getUserStream returns user',
        (WidgetTester tester) async {
      var userId = '000000';
      when(serviceMock.getUserStream(userId))
          .thenAnswer((_) => Stream.value(AppUser.mock()));

      await tester
          .pumpWidget(createWidgetForTesting(ProfilePage(userId: userId)));

      await tester.pump();

      expect(find.byType(InfoScreenSelector), findsOneWidget);
    });

    testWidgets(
        'should display user info if provider selected widget is user info',
        (WidgetTester tester) async {
      var userId = '000000';
      when(serviceMock.getUserStream(userId))
          .thenAnswer((_) => Stream.value(AppUser.mock()));

      await tester
          .pumpWidget(createWidgetForTesting(ProfilePage(userId: userId)));

      await tester.pump();

      expect(find.byType(UserInfo), findsOneWidget);
    });

    testWidgets(
        'should display user stats if provider selected widget is user stats',
        (WidgetTester tester) async {
      var userId = '000000';
      when(serviceMock.getUserStream(userId))
          .thenAnswer((_) => Stream.value(AppUser.mock()));

      await tester
          .pumpWidget(createWidgetForTesting(ProfilePage(userId: userId)));

      await tester.pump();

      await tester.tap(find.widgetWithText(FlatButton, 'My Stats'));
      await tester.pump();

      expect(find.byType(UserStats), findsOneWidget);
    });
  });
}
