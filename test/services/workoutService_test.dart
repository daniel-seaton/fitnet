import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnet/models/AppUser.dart';
import 'package:fitnet/models/workout.dart';
import 'package:fitnet/services/workoutService.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../helpers.dart';
import '../mocks.dart';

void main() {
  initTests();

  GetIt injector = GetIt.instance;
  MockFirestoreInstance2 firestoreMock;

  setUp(() {
    injector.unregister<FirebaseFirestore>();

    firestoreMock = MockFirestoreInstance2();
    injector.registerSingleton<FirebaseFirestore>(firestoreMock);
  });

  group('Unit Tests', () {
    group('getWorkoutStreamForUser', () {
      test('should call firestore collection once', () {
        when(firestoreMock.collection('workouts'))
            .thenAnswer((_) => MockFirestoreInstance().collection('appUsers'));

        WorkoutService service = WorkoutService();
        service.getWorkoutStreamForUser(AppUser.mock().uid);
        verify(firestoreMock.collection('workouts')).called(1);
      });

      test('should return workout stream', () async {
        MockFirestoreInstance instance = MockFirestoreInstance();
        Workout expectedWorkout = Workout.mock();
        await instance.collection('workouts').add(expectedWorkout.toMap());

        when(firestoreMock.collection('workouts'))
            .thenAnswer((_) => instance.collection('workouts'));

        WorkoutService service = WorkoutService();
        Stream<List<Workout>> output =
            service.getWorkoutStreamForUser(AppUser.mock().uid);
        var first = await output.first;
        expect(first[0].name, expectedWorkout.name);
      });
    });

    group('addOrUpdateWorkout', () {
      test('should call firestore collection once', () {
        when(firestoreMock.collection('workouts'))
            .thenAnswer((_) => MockFirestoreInstance().collection('workouts'));

        WorkoutService service = WorkoutService();
        service.addOrUpdateWorkout(Workout.mock());
        verify(firestoreMock.collection('workouts')).called(1);
      });

      test('should call collection add if workout does not have a wid',
          () async {
        MockCollectionReference collectionMock = MockCollectionReference();
        Workout mockWorkout = Workout(name: 'fake', uid: '1234567');
        when(firestoreMock.collection('workouts'))
            .thenAnswer((_) => collectionMock);

        when(collectionMock.add(mockWorkout.toMap()))
            .thenAnswer((_) => Future.value());

        WorkoutService service = WorkoutService();
        await service.addOrUpdateWorkout(mockWorkout);
        verify(collectionMock.add(mockWorkout.toMap())).called(1);
      });
    });
  });

  group('Component Tests', () {
    // Nothing to component test
  });
}
