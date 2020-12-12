// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/services/userService.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers.dart';
import '../mocks.dart';
import '../testServiceInjector.dart';

void main() {
  initTests();

  MockFirebaseStorage storageMock;
  MockFirestoreInstance2 firestoreMock;

  setUp(() {
    injector.unregister<FirebaseStorage>();
    injector.unregister<FirebaseFirestore>();

    storageMock = new MockFirebaseStorage();
    firestoreMock = new MockFirestoreInstance2();

    injector.registerSingleton<FirebaseStorage>(storageMock);
    injector.registerSingleton<FirebaseFirestore>(firestoreMock);
  });

  group('Unit Tests', () {
    group('getUser', () {
      test('should call firestore collection once', () async {
        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => MockFirestoreInstance().collection('appUsers'));

        UserService service = UserService();
        await service.getUser(AppUser.mock().uid);
        verify(firestoreMock.collection('appUsers')).called(1);
      });

      test('should return AppUser if only one exists for uid', () async {
        MockFirestoreInstance instance = MockFirestoreInstance();
        AppUser expectedUser = AppUser.mock();
        await instance.collection('appUsers').add(expectedUser.toMap());

        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => instance.collection('appUsers'));

        UserService service = UserService();
        AppUser user = await service.getUser(expectedUser.uid);
        expect(user, isNotNull);
      });

      test('should return null if no user exists', () async {
        MockFirestoreInstance instance = MockFirestoreInstance();

        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => instance.collection('appUsers'));

        UserService service = UserService();
        AppUser user = await service.getUser('000000');
        expect(user, isNull);
      });

      test('should throw error if more than one user exists', () async {
        MockFirestoreInstance instance = MockFirestoreInstance();
        AppUser expectedUser = AppUser.mock();
        await instance.collection('appUsers').add(expectedUser.toMap());
        await instance.collection('appUsers').add(expectedUser.toMap());

        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => instance.collection('appUsers'));

        UserService service = UserService();
        expect(service.getUser(expectedUser.uid), throwsException);
      });
    });

    group('createNew', () {
      test('should call firestore collection once', () async {
        UserService service = UserService();
        await service.createNew('00000', 'firstName', 'lastName');
        verify(firestoreMock.collection('appUsers')).called(1);
      });

      test('should call firestore collection add once', () async {
        MockCollectionReference collectionMock = MockCollectionReference();

        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => collectionMock);

        UserService service = UserService();
        await service.createNew('00000', 'firstName', 'lastName');
        verify(collectionMock
                .add(AppUser('00000', 'firstName', 'lastName').toMap()))
            .called(1);
      });

      test('should return appUser if add does not error', () async {
        MockCollectionReference collectionMock = MockCollectionReference();
        AppUser expectedOutput = AppUser.mock();
        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => collectionMock);

        when(collectionMock.add(expectedOutput.toMap()))
            .thenAnswer((_) => Future.value());

        UserService service = UserService();
        var output = await service.createNew(expectedOutput.uid,
            expectedOutput.firstName, expectedOutput.lastName);
        expect(output.uid, expectedOutput.uid);
        expect(output.firstName, expectedOutput.firstName);
        expect(output.lastName, expectedOutput.lastName);
      });

      test('should return null if add throws an error error', () async {
        MockCollectionReference collectionMock = MockCollectionReference();
        AppUser user = AppUser('00000', 'firstName', 'lastName');
        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => collectionMock);

        when(collectionMock.add(user.toMap()))
            .thenAnswer((_) => Future.error(Error()));

        UserService service = UserService();
        var output = await service.createNew('00000', 'firstName', 'lastName');
        expect(output, isNull);
      });
    });

    group('getUserStream', () {
      test('should call firestore collection once', () {
        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => MockFirestoreInstance().collection('appUsers'));

        UserService service = UserService();
        service.getUserStream(AppUser.mock().uid);
        verify(firestoreMock.collection('appUsers')).called(1);
      });

      test('should return app user stream', () async {
        MockFirestoreInstance instance = MockFirestoreInstance();
        AppUser expectedUser = AppUser.mock();
        await instance.collection('appUsers').add(expectedUser.toMap());

        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => instance.collection('appUsers'));

        UserService service = UserService();
        Stream<AppUser> output = service.getUserStream(AppUser.mock().uid);
        var first = await output.first;
        expect(first.uid, expectedUser.uid);
      });
    });

    group('uploadImageForUser', () {
      test('should upload the image file to storage', () async {
        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => MockFirestoreInstance().collection('appUsers'));

        AppUser user = AppUser.mock();
        UserService service = UserService();

        await service.uploadImageForUser(
            user, File('assets/images/default-user.jpg'));

        var path = storageMock.ref().child(user.uid).path;
        expect(path, isNotNull);
      });

      test('should call firestore collection once', () async {
        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => MockFirestoreInstance().collection('appUsers'));

        AppUser user = AppUser.mock();
        UserService service = UserService();
        await service.uploadImageForUser(
            user, File('assets/images/default-user.jpg'));
        verify(firestoreMock.collection('appUsers')).called(1);
      });

      test('should throw error if multiple users exist', () async {
        MockFirestoreInstance instance = MockFirestoreInstance();
        AppUser expectedUser = AppUser.mock();
        await instance.collection('appUsers').add(expectedUser.toMap());
        await instance.collection('appUsers').add(expectedUser.toMap());

        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => instance.collection('appUsers'));

        AppUser user = AppUser.mock();
        UserService service = UserService();
        expect(
            service.uploadImageForUser(
                user, File('assets/images/default-user.jpg')),
            throwsException);
      });

      test('should update profileImageVersion if only one appUser exists',
          () async {
        MockFirestoreInstance instance = MockFirestoreInstance();
        AppUser expectedUser = AppUser.mock();
        await instance.collection('appUsers').add(expectedUser.toMap());

        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => instance.collection('appUsers'));

        AppUser user = AppUser.mock();
        UserService service = UserService();
        await service.uploadImageForUser(
            user, File('assets/images/default-user.jpg'));

        AppUser updatedUser = await instance
            .collection('appUsers')
            .where('uid', isEqualTo: expectedUser.uid)
            .get()
            .then((query) => AppUser.fromMap(query.docs[0].data()));
        expect(updatedUser.profileImageVersion,
            expectedUser.profileImageVersion + 1);
      });
    });

    group('getImageDownloadUrl', () {
      test('should return expected output', () async {
        storageMock
            .ref()
            .child('filename')
            .putFile(File('assets/images/default-user.jpg'));
        UserService service = UserService();
        var output = await service.getImageDownloadUrl('filename');
        expect(
            output, await storageMock.ref().child('filename').getDownloadURL());
      });
    });

    group('Component Tests', () {
      // Nothing to component test
    });
  });
}
