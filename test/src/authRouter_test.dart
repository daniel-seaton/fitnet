import 'package:firebase_core/firebase_core.dart';
import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/services/authService.dart';
import 'package:fitnet/src/app/tempScreen.dart';
import 'package:fitnet/src/auth/authScreen.dart';
import 'package:fitnet/src/authRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers.dart';

class MockAuthService extends Mock implements AuthService {}

void main() async {
  initTests();
  group('Unit Tests', () {
    group('getScreenForAuthStatus', () {
      test('should return TempScreen if logged in is true', () {
        final serviceMock = MockAuthService();

        when(serviceMock.getLoggedInUser())
            .thenAnswer((_) => Stream.value(AppUser.mock()));

        Widget output =
            AuthRouter(authService: serviceMock).getScreenForAuthStatus(true);

        expect(output.runtimeType, TempScreen);
      });

      test('should return AuthScreen if logged in is false', () {
        final serviceMock = MockAuthService();

        when(serviceMock.getLoggedInUser())
            .thenAnswer((_) => Stream.value(null));

        Widget output =
            AuthRouter(authService: serviceMock).getScreenForAuthStatus(false);
        expect(output.runtimeType, AuthScreen);
      });
    });
  });

  group('Component Tests', () {
    // nothing to component test here
  });
}
