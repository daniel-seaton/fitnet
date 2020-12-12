import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnet/services/authService.dart';
import 'package:fitnet/services/userService.dart';
import 'package:fitnet/services/workoutService.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';

class MockAuthService extends Mock implements AuthService {}

class MockWorkoutService extends Mock implements WorkoutService {}

class MockFirebaseAuth2 extends Mock implements FirebaseAuth {}

class MockFirestoreInstance2 extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock implements CollectionReference {}

class MockUserService extends Mock implements UserService {}

class MockImagePicker extends Mock implements ImagePicker {}
