import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/routes/home/profile/infoScreenSelector/userInfo/profileImage/profileImage.dart';
import 'package:fitnet/services/userService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../../../../../../helpers.dart';
import '../../../../../../testServiceInjector.dart';

void main() {
  initTests();

  UserService serviceMock = injector<UserService>();

  group('Unit Tests', () {
    group('getProfileImageForUrl', () {
      test('should return network image if download url != null', () {
        ProfileImage image = ProfileImage();
        var output =
            image.getProfileImageForUrl('https://i.redd.it/w3kr4m2fi3111.png');
        expect(output.runtimeType,
            NetworkImage('https://i.redd.it/w3kr4m2fi3111.png').runtimeType);
      });

      test('should return asset image if download url == null', () {
        ProfileImage image = ProfileImage();
        var output = image.getProfileImageForUrl(null);
        expect(output.runtimeType, AssetImage);
      });
    });
  });

  group('Component Tests', () {
    testWidgets('should have upload button', (WidgetTester tester) async {
      var user = AppUser.mock();

      await tester.pumpWidget(createWidgetForTesting(
          Provider.value(value: user, child: ProfileImage())));

      expect(find.byType(RawMaterialButton), findsOneWidget);
    });
  });
}
