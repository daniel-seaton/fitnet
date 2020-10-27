import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:fitnet/services/firebaseStorageService.dart';

import '../helpers.dart';
import 'package:flutter_test/flutter_test.dart';

import '../testServiceInjector.dart';

void main() {
  initTests();

  MockFirebaseStorage mockStorage = injector<FirebaseStorage>();

  group('Unit Tests', () {
    group('getImageDownloadUrl', () {
      test('should return expected output', () async {
        mockStorage
            .ref()
            .child('filename')
            .putFile(File('lib/assets/default-user.jpg'));
        FirebaseStorageService service = FirebaseStorageService();
        var output = await service.getImageDownloadUrl('filename');
        expect(
            output, await mockStorage.ref().child('filename').getDownloadURL());
      });
    });

    group('uploadFile', () {
      test('should upload the file to storage', () async {
        FirebaseStorageService service = FirebaseStorageService();

        await service.uploadFile(
            'filename', File('lib/assets/default-user.jpg'));

        var path = mockStorage.ref().child('filename').path;
        expect(path, isNotNull);
      });
    });
  });

  group('Component Tests', () {
    // Nothing to component test
  });
}
