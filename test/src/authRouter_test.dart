import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/services/authService.dart';
import 'package:fitnet/src/app/homeScreen.dart';
import 'package:fitnet/src/auth/authScreen.dart';
import 'package:fitnet/src/authRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../helpers.dart';
import '../mocks.dart';
import '../testServiceInjector.dart';

void main() async {
  initTests();

  MockAuthService serviceMock = injector<AuthService>();

  group('Unit Tests', () {
    group('getScreenForAuthStatus', () {
      test('should return HomeScreen if uid is not null', () {
        when(serviceMock.getLoggedInUser())
            .thenAnswer((_) => Stream.value(AppUser.mock()));

        Widget output = AuthRouter().getScreenForAuthStatus('123456');

        expect(output.runtimeType, HomeScreen);
      });

      test('should return AuthScreen if uid is null', () {
        when(serviceMock.getLoggedInUser())
            .thenAnswer((_) => Stream.value(null));

        Widget output = AuthRouter().getScreenForAuthStatus(null);
        expect(output.runtimeType, AuthScreen);
      });
    });
  });

  group('Component Tests', () {
    // nothing to component test here
  });
}
