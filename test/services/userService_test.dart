// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/services/firebaseStorageService.dart';
import 'package:fitnet/services/firestoreService.dart';
import 'package:fitnet/services/userService.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers.dart';
import '../testServiceInjector.dart';

class MockUserService extends Mock implements UserService {}

void main() {
  initTests();

  FirestoreService serviceMock = injector<FirestoreService>();
  FirebaseStorageService storageMock = injector<FirebaseStorageService>();

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

    group('createNew', () {
      test('should call firestoreService addUser once', () async {
        AppUser user = AppUser('000000', 'first', 'last');

        UserService service = UserService();
        await service.createNew('000000', 'first', 'last');
        verify(serviceMock.addUser(argThat(isA<AppUser>()))).called(1);
      });

      test('should return outputFrom addUser', () async {
        AppUser user = AppUser('000000', 'first', 'last');
        when(serviceMock.addUser(argThat(isA<AppUser>())))
            .thenAnswer((_) => Future.value(user));

        UserService service = UserService();
        AppUser output = await service.createNew('000000', 'first', 'last');
        expect(output, user);
      });
    });

    group('getUserStream', () {
      test('should call firestoreService.getUserStream once', () {
        AppUser user = AppUser.mock();
        UserService service = UserService();
        service.getUserStream(user.uid);
        verify(serviceMock.getUserStream(user.uid)).called(1);
      });

      test('should return output from firestoreService.getUserStream', () {
        AppUser user = AppUser.mock();
        Stream<AppUser> expectedOutput = Stream.value(user);
        when(serviceMock.getUserStream(user.uid))
            .thenAnswer((_) => expectedOutput);
        UserService service = UserService();
        var output = service.getUserStream(user.uid);
        expect(output, expectedOutput);
      });
    });

    group('getImageDownloadUrl', () {
      test('should call storageService.getImageDownloadUrl once', () async {
        AppUser user = AppUser.mock();
        UserService service = UserService();
        await service.getImageDownloadUrl(user.uid);
        verify(storageMock.getImageDownloadUrl(user.uid)).called(1);
      });

      test('should return output from storageService.getImageDownloadUrl',
          () async {
        AppUser user = AppUser.mock();

        when(storageMock.getImageDownloadUrl(user.uid))
            .thenAnswer((_) => Future.value('pornhub.com'));

        UserService service = UserService();
        var output = await service.getImageDownloadUrl(user.uid);
        expect(output, 'pornhub.com');
      });
    });

    group('uploadImageForUser', () {
      test('should call storageService.uploadFile once', () async {
        AppUser user = AppUser.mock();
        File file = File('lib/assets/defalt-user.jpg');

        when(storageMock.uploadFile(user.uid, file)).thenAnswer(
            (_) => Future.value(MockFirebaseStorage().ref().putFile(file)));

        UserService service = UserService();
        await service.uploadImageForUser(user, file);

        verify(storageMock.uploadFile(user.uid, file)).called(1);
      });

      test('should call firestoreService updateProfileImageVersion', () async {
        AppUser user = AppUser.mock();
        File file = File('lib/assets/defalt-user.jpg');

        when(storageMock.uploadFile(user.uid, file)).thenAnswer(
            (_) => Future.value(MockFirebaseStorage().ref().putFile(file)));

        UserService service = UserService();
        await service.uploadImageForUser(user, file);
        verify(serviceMock.updateProfileImageVersion(user));
      });
    });
  });

  group('Component Tests', () {
    // Nothing to component test
  });
}
