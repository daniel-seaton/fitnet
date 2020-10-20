// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/services/firestoreService.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../helpers.dart';
import '../mocks.dart';

void main() {
  initTests();

  GetIt injector = GetIt.instance;
  MockFirestoreInstance2 firestoreMock;

  setUp(() async {
    injector.unregister<FirebaseFirestore>();
    firestoreMock = MockFirestoreInstance2();
    injector.registerSingleton<FirebaseFirestore>(firestoreMock);
  });

  group('Unit Tests', () {
    group('addUser', () {
      test('should call firestore collection once', () async {
        FirestoreService service = FirestoreService();
        await service.addUser(AppUser.mock());
        verify(firestoreMock.collection('appUsers')).called(1);
      });

      test('should call firestore collection add once', () async {
        MockCollectionReference collectionMock = MockCollectionReference();

        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => collectionMock);

        FirestoreService service = FirestoreService();
        await service.addUser(AppUser.mock());
        verify(collectionMock.add(AppUser.mock().toMap())).called(1);
      });

      test('should return appUser if add does not error', () async {
        MockCollectionReference collectionMock = MockCollectionReference();
        AppUser expectedOutput = AppUser.mock();
        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => collectionMock);

        when(collectionMock.add(expectedOutput.toMap()))
            .thenAnswer((_) => Future.value());

        FirestoreService service = FirestoreService();
        var output = await service.addUser(expectedOutput);
        expect(output, expectedOutput);
      });

      test('should return null if add throws an error error', () async {
        MockCollectionReference collectionMock = MockCollectionReference();
        AppUser user = AppUser.mock();
        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => collectionMock);

        when(collectionMock.add(user.toMap()))
            .thenAnswer((_) => Future.error(Error()));

        FirestoreService service = FirestoreService();
        var output = await service.addUser(user);
        expect(output, isNull);
      });
    });

    group('getUser', () {
      test('should call firestore collection once', () async {
        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => MockFirestoreInstance().collection('appUsers'));

        FirestoreService service = FirestoreService();
        await service.getUser(AppUser.mock().uid);
        verify(firestoreMock.collection('appUsers')).called(1);
      });

      test('should return AppUser if only one exists for uid', () async {
        MockFirestoreInstance instance = MockFirestoreInstance();
        AppUser expectedUser = AppUser.mock();
        await instance.collection('appUsers').add(expectedUser.toMap());

        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => instance.collection('appUsers'));

        FirestoreService service = FirestoreService();
        AppUser user = await service.getUser(expectedUser.uid);
        expect(user, isNotNull);
      });

      test('should return null if no user exists', () async {
        MockFirestoreInstance instance = MockFirestoreInstance();

        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => instance.collection('appUsers'));

        FirestoreService service = FirestoreService();
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

        FirestoreService service = FirestoreService();
        expect(service.getUser(expectedUser.uid), throwsException);
      });
    });

    group('getUserStream', () {
      test('should call firestore collection once', () {
        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => MockFirestoreInstance().collection('appUsers'));

        FirestoreService service = FirestoreService();
        service.getUserStream(AppUser.mock().uid);
        verify(firestoreMock.collection('appUsers')).called(1);
      });

      test('should return app user stream', () async {
        MockFirestoreInstance instance = MockFirestoreInstance();
        AppUser expectedUser = AppUser.mock();
        await instance.collection('appUsers').add(expectedUser.toMap());

        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => instance.collection('appUsers'));

        FirestoreService service = FirestoreService();
        Stream<AppUser> output = service.getUserStream(AppUser.mock().uid);
        var first = await output.first;
        expect(first.uid, expectedUser.uid);
      });
    });

    group('updateProfileImageVersion', () {
      test('should call firestore collection once', () async {
        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => MockFirestoreInstance().collection('appUsers'));

        FirestoreService service = FirestoreService();
        await service.updateProfileImageVersion(AppUser.mock());
        verify(firestoreMock.collection('appUsers')).called(1);
      });

      test('should throw error if multiple users exist', () async {
        MockFirestoreInstance instance = MockFirestoreInstance();
        AppUser expectedUser = AppUser.mock();
        await instance.collection('appUsers').add(expectedUser.toMap());
        await instance.collection('appUsers').add(expectedUser.toMap());

        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => instance.collection('appUsers'));

        FirestoreService service = FirestoreService();
        expect(
            service.updateProfileImageVersion(expectedUser), throwsException);
      });

      test('should update profileImageVersion if only one appUser exists',
          () async {
        MockFirestoreInstance instance = MockFirestoreInstance();
        AppUser expectedUser = AppUser.mock();
        await instance.collection('appUsers').add(expectedUser.toMap());

        when(firestoreMock.collection('appUsers'))
            .thenAnswer((_) => instance.collection('appUsers'));

        FirestoreService service = FirestoreService();
        await service.updateProfileImageVersion(expectedUser);

        AppUser updatedUser = await instance
            .collection('appUsers')
            .where('uid', isEqualTo: expectedUser.uid)
            .get()
            .then((query) => AppUser.fromMap(query.docs[0].data()));
        expect(updatedUser.profileImageVersion,
            expectedUser.profileImageVersion + 1);
      });
    });
  });

  group('Component Tests', () {
    // Nothing to component test
  });
}
