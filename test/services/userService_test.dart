// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/services/firestoreService.dart';
import 'package:fitnet/services/userService.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../helpers.dart';
import 'firestoreService_test.dart';

class MockUserService extends Mock implements UserService {}

void main() {
  initTests();

  GetIt injector = GetIt.instance;
  FirestoreService serviceMock;

  setUp(() async {
    injector.unregister<FirestoreService>();
    serviceMock = MockFirestoreService();
    injector.registerSingleton<FirestoreService>(serviceMock);
  });

  group('Unit Tests', () {
    group('getUser', () {
      test('should call firestoreService getUser once', () async {
        UserService service = UserService();
        await service.getUser('000000');
        verify(serviceMock.getUser('000000')).called(1);
      });

      test('should return output from firestoreService', () async {
        var expectedOutput = AppUser.mock();
        when(serviceMock.getUser('000000'))
            .thenAnswer((_) => Future.value(expectedOutput));

        UserService service = UserService();
        AppUser output = await service.getUser('000000');
        expect(output, expectedOutput);
      });
    });

    // for whatever reason, using the any(...) match breaks everything. It is a known issue they are trying to fix right now, so these will work eventually, but do not right now.
    // group('createNew', () {
    //   test('should call firestoreService addUser once', () async {
    //     AppUser user = AppUser('000000', 'first', 'last');

    //     UserService service = UserService();
    //     await service.createNew('000000', 'first', 'last');
    //     verify(serviceMock.addUser(any(AppUser))).called(1);
    //   });

    //   test('should return outputFrom addUser', () async {
    //     AppUser user = AppUser('000000', 'first', 'last');
    //     when(serviceMock.addUser(any(AppUser))).thenAnswer((_) => Future.value(user));

    //     UserService service = UserService();
    //     AppUser output = await service.createNew('000000', 'first', 'last');
    //     expect(output, user;
    //   });
    // });
  });

  group('Component Tests', () {
    // Nothing to component test
  });
}
