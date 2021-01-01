import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:fitnet/services/authService.dart';
import 'package:fitnet/services/userService.dart';
import 'package:fitnet/services/workoutInstanceService.dart';
import 'package:fitnet/services/workoutService.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import 'mocks.dart';

GetIt injector = GetIt.instance;

setupTestServiceInjector() {
  injector.registerSingleton<FirebaseFirestore>(MockFirestoreInstance2());
  injector.registerSingleton<FirebaseAuth>(MockFirebaseAuth2());
  injector.registerSingleton<FirebaseStorage>(MockFirebaseStorage());
  injector.registerSingleton<UserService>(MockUserService());
  injector.registerSingleton<AuthService>(MockAuthService());
  injector.registerSingleton<WorkoutService>(MockWorkoutService());
  injector
      .registerSingleton<WorkoutInstanceService>(MockWorkoutInstanceService());
  injector.registerSingleton<ImagePicker>(MockImagePicker());
}
