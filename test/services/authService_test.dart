// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/services/authService.dart';
import 'package:fitnet/services/userService.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../helpers.dart';
import 'userService_test.dart';

class MockAuthService extends Mock implements AuthService {}

class MockFirebaseAuth2 extends Mock implements FirebaseAuth {}

void main() {
  initTests();

  GetIt injector = GetIt.instance;
  MockFirebaseAuth2 authMock;
  MockUserService serviceMock;

  setUp(() {
    injector.unregister<FirebaseAuth>();
    injector.unregister<UserService>();

    authMock = MockFirebaseAuth2();
    serviceMock = MockUserService();
    injector.registerSingleton<FirebaseAuth>(authMock);
    injector.registerSingleton<UserService>(serviceMock);
  });

  group('Unit Tests', () {
    group('login', () {
      test('should call signInWithEmailAndPassword once', () async {
        AuthService service = AuthService();
        await service.login('email', 'password');
        verify(authMock.signInWithEmailAndPassword(
                email: 'email', password: 'password'))
            .called(1);
      });

      test('should call userService.getUser once', () async {
        var expectedCredentials = await MockFirebaseAuth()
            .signInWithEmailAndPassword(email: 'email', password: 'password');

        when(authMock.signInWithEmailAndPassword(
                email: 'email', password: 'password'))
            .thenAnswer((_) => Future.value(expectedCredentials));

        AuthService service = AuthService();
        await service.login('email', 'password');
        verify(serviceMock.getUser(expectedCredentials.user.uid)).called(1);
      });

      test('should return output from getUser', () async {
        var expectedCredentials = await MockFirebaseAuth()
            .signInWithEmailAndPassword(email: 'email', password: 'password');
        var expectedOutput = AppUser.mock();

        when(authMock.signInWithEmailAndPassword(
                email: 'email', password: 'password'))
            .thenAnswer((_) => Future.value(expectedCredentials));

        when(serviceMock.getUser(expectedCredentials.user.uid)).thenAnswer((_) {
          return Future.value(expectedOutput);
        });

        AuthService service = AuthService();
        AppUser output = await service.login('email', 'password');
        expect(output, expectedOutput);
      });

      test('should return null if error is thrown by auth', () async {
        when(authMock.signInWithEmailAndPassword(
                email: 'email', password: 'password'))
            .thenAnswer((_) => Future.error(new Error()));

        AuthService service = AuthService();
        AppUser output = await service.login('email', 'password');
        expect(output, isNull);
      });

      test('should return null if error is thrown by userService', () async {
        var expectedCredentials = await MockFirebaseAuth()
            .signInWithEmailAndPassword(email: 'email', password: 'password');

        when(authMock.signInWithEmailAndPassword(
                email: 'email', password: 'password'))
            .thenAnswer((_) => Future.value(expectedCredentials));

        when(serviceMock.getUser(expectedCredentials.user.uid))
            .thenAnswer((_) => Future.error(new Error()));

        AuthService service = AuthService();
        AppUser output = await service.login('email', 'password');
        expect(output, isNull);
      });
    });

    group('signUp', () {
      test('should call createUserWithEmailAndPassword once', () async {
        AuthService service = AuthService();
        await service.signUp('email', 'password', 'firstName', 'lastName');
        verify(authMock.createUserWithEmailAndPassword(
                email: 'email', password: 'password'))
            .called(1);
      });

      test('should call userService.createNew once', () async {
        var expectedCredentials = await MockFirebaseAuth()
            .signInWithEmailAndPassword(email: 'email', password: 'password');

        when(authMock.createUserWithEmailAndPassword(
                email: 'email', password: 'password'))
            .thenAnswer((_) => Future.value(expectedCredentials));

        AuthService service = AuthService();
        await service.signUp('email', 'password', 'firstName', 'lastName');
        verify(serviceMock.createNew(
                expectedCredentials.user.uid, 'firstName', 'lastName'))
            .called(1);
      });

      test('should return output from getUser', () async {
        var expectedCredentials = await MockFirebaseAuth()
            .signInWithEmailAndPassword(email: 'email', password: 'password');
        var expectedOutput = AppUser.mock();

        when(authMock.createUserWithEmailAndPassword(
                email: 'email', password: 'password'))
            .thenAnswer((_) => Future.value(expectedCredentials));

        when(serviceMock.createNew(
                expectedCredentials.user.uid, 'firstName', 'lastName'))
            .thenAnswer((_) {
          return Future.value(expectedOutput);
        });

        AuthService service = AuthService();
        var output =
            await service.signUp('email', 'password', 'firstName', 'lastName');

        expect(output, expectedOutput);
      });

      test('should return null if error is thrown by auth', () async {
        when(authMock.createUserWithEmailAndPassword(
                email: 'email', password: 'password'))
            .thenAnswer((_) => Future.error(new Error()));

        AuthService service = AuthService();
        var output =
            await service.signUp('email', 'password', 'firstName', 'lastName');
        expect(output, isNull);
      });

      test('should return null if error is thrown by userService', () async {
        var expectedCredentials = await MockFirebaseAuth()
            .signInWithEmailAndPassword(email: 'email', password: 'password');

        when(authMock.createUserWithEmailAndPassword(
                email: 'email', password: 'password'))
            .thenAnswer((_) => Future.value(expectedCredentials));

        when(serviceMock.createNew(
                expectedCredentials.user.uid, 'firstName', 'lastName'))
            .thenAnswer((_) => Future.error(new Error()));

        AuthService service = AuthService();
        var output =
            await service.signUp('email', 'password', 'firstName', 'lastName');
        expect(output, isNull);
      });
    });

    group('signOut', () {
      test('should call firebaseAuth signOut once', () async {
        AuthService service = AuthService();
        await service.signOut();

        verify(authMock.signOut()).called(1);
      });
    });

    group('getLoggedInUser', () {
      test('should call firebaseAuth authStateChanges once', () {
        when(authMock.authStateChanges()).thenAnswer((_) => Stream.empty());
        AuthService service = AuthService();
        service.getLoggedInUser();

        verify(authMock.authStateChanges()).called(1);
      });

      test('should call userService getUser if user is not null', () async {
        var expectedUser = (await MockFirebaseAuth().signInWithEmailAndPassword(
                email: 'email', password: 'password'))
            .user;
        when(authMock.authStateChanges())
            .thenAnswer((_) => Stream.value(expectedUser));

        AuthService service = AuthService();
        service.getLoggedInUser().listen((AppUser user) {
          verify(serviceMock.getUser(expectedUser.uid)).called(1);
        });
      });
      test('should not userService getUser if user is null', () async {
        when(authMock.authStateChanges()).thenAnswer((_) => Stream.value(null));

        AuthService service = AuthService();
        service.getLoggedInUser().listen((AppUser user) {
          verifyNever(serviceMock.getUser('1234567'));
        });
      });

      test('should return null if user is null', () async {
        when(authMock.authStateChanges()).thenAnswer((_) => Stream.value(null));
        when(serviceMock.getUser('1234567'))
            .thenAnswer((_) => Future.value(AppUser.mock()));

        AuthService service = AuthService();
        service.getLoggedInUser().listen((AppUser user) {
          expect(user, isNull);
        });
      });

      test('should return app user if user is not null', () async {
        var expectedUser = (await MockFirebaseAuth().signInWithEmailAndPassword(
                email: 'email', password: 'password'))
            .user;
        var expectedOuput = AppUser.mock();
        when(authMock.authStateChanges())
            .thenAnswer((_) => Stream.value(expectedUser));
        when(serviceMock.getUser(expectedUser.uid))
            .thenAnswer((_) => Future.value(expectedOuput));

        AuthService service = AuthService();
        service.getLoggedInUser().listen((AppUser user) {
          expect(user, expectedOuput);
        });
      });
    });

    group('Component Tests', () {
      // Nothing to component test
    });
  });
}
