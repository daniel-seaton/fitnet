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

class MockFirestoreService extends Mock implements FirestoreService {}

class MockFirestoreInstance2 extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock implements CollectionReference {}

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
        AppUser expectedUser = AppUser.mock();

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
  });

  group('Component Tests', () {
    // Nothing to component test
  });
}
