import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/routes/home/profile/infoScreenSelector/userInfo/profileImage/profileImage.dart';
import 'package:fitnet/routes/home/profile/infoScreenSelector/userInfo/userInfo.dart';
import 'package:fitnet/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers.dart';
import '../../../../../mocks.dart';
import '../../../../../testServiceInjector.dart';

void main() {
  initTests();
  MockAuthService serviceMock = injector<AuthService>();

  group('Unit Tests', () {
    group('userHeightAndWeight', () {
      test('should return expected string if height and weight are null', () {
        var expectedString = 'Height: ?\'?" Weight: ???lbs';
        UserInfo info = UserInfo();
        var output = info.userHeightAndWeight(AppUser.mock());
        expect(output, expectedString);
      });

      test('should return expected string if height and weight are not', () {
        var expectedString = 'Height: 6\'2" Weight: 160lbs';
        UserInfo info = UserInfo();
        var output = info.userHeightAndWeight(AppUser.fromMap({
          'firstName': 'test',
          'lastName': 'test',
          'uid': '1234567',
          'height': 74,
          'weightLogs': [
            {'weight': 160, 'dateLogged': Timestamp.now()}
          ]
        }));
        expect(output, expectedString);
      });
    });
  });

  group('Component Tests', () {
    testWidgets('should display user first and last name',
        (WidgetTester tester) async {
      AppUser user = AppUser.mock();
      await tester.pumpWidget(createWidgetForTesting(
          Provider<AppUser>.value(value: user, child: UserInfo())));

      expect(find.text('${user.firstName} ${user.lastName}'), findsOneWidget);
    });

    testWidgets('should display log out button', (WidgetTester tester) async {
      AppUser user = AppUser.mock();
      await tester.pumpWidget(createWidgetForTesting(
          Provider<AppUser>.value(value: user, child: UserInfo())));

      expect(find.widgetWithText(ElevatedButton, 'Log Out'), findsOneWidget);
    });

    testWidgets('should display profileImage widget',
        (WidgetTester tester) async {
      AppUser user = AppUser.mock();
      await tester.pumpWidget(createWidgetForTesting(
          Provider<AppUser>.value(value: user, child: UserInfo())));

      expect(find.byType(ProfileImage), findsOneWidget);
    });

    testWidgets(
        'should call userService.signOut when log out button is clicked',
        (WidgetTester tester) async {
      AppUser user = AppUser.mock();
      await tester.pumpWidget(createWidgetForTesting(
          Provider<AppUser>.value(value: user, child: UserInfo())));

      await tester.tap(find.widgetWithText(ElevatedButton, 'Log Out'));
      await tester.pump();

      verify(serviceMock.signOut()).called(1);
    });
  });
}
