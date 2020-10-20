import 'dart:io';

import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/services/userService.dart';
import 'package:fitnet/src/app/profile/infoScreenSelector/userInfo/profileImage/photoPickerModal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';

import '../../../../../../helpers.dart';
import '../../../../../../testServiceInjector.dart';

void main() {
  initTests();

  UserService serviceMock = injector<UserService>();
  ImagePicker pickerMock = injector<ImagePicker>();

  group('Unit Tests', () {
    // Nothing can be unit tested
    group('imageFromGallery', () {
      test('should call photoPicker getImage', () async {
        var user = AppUser.mock();

        when(pickerMock.getImage(source: ImageSource.gallery, imageQuality: 50))
            .thenAnswer(
                (_) => Future.value(PickedFile('lib/assets/default-user.jpg')));

        PhotoPickerModal modal = PhotoPickerModal(user: user);
        await modal.imageFromGallery(user);

        verify(pickerMock.getImage(
                source: ImageSource.gallery, imageQuality: 50))
            .called(1);
      });

      test('should call userService uploadImageForUser', () async {
        var user = AppUser.mock();
        var pickedFile = PickedFile('lib/assets/default-user.jpg');

        when(pickerMock.getImage(source: ImageSource.gallery, imageQuality: 50))
            .thenAnswer((_) => Future.value(pickedFile));

        when(serviceMock.uploadImageForUser(user, argThat(isA<File>())))
            .thenAnswer((_) {
          return Future.value(null);
        });

        PhotoPickerModal modal = PhotoPickerModal(user: user);
        await modal.imageFromGallery(user);

        verify(serviceMock.uploadImageForUser(user, argThat(isA<File>())))
            .called(1);
      });
    });

    group('imageFromCamera', () {
      test('should call photoPicker getImage', () async {
        var user = AppUser.mock();

        when(pickerMock.getImage(source: ImageSource.camera, imageQuality: 50))
            .thenAnswer(
                (_) => Future.value(PickedFile('lib/assets/default-user.jpg')));

        PhotoPickerModal modal = PhotoPickerModal(user: user);
        await modal.imageFromCamera(user);

        verify(pickerMock.getImage(
                source: ImageSource.camera, imageQuality: 50))
            .called(1);
      });

      test('should call userService uploadImageForUser', () async {
        var user = AppUser.mock();
        var pickedFile = PickedFile('lib/assets/default-user.jpg');

        when(pickerMock.getImage(source: ImageSource.camera, imageQuality: 50))
            .thenAnswer((_) => Future.value(pickedFile));

        when(serviceMock.uploadImageForUser(user, argThat(isA<File>())))
            .thenAnswer((_) {
          return Future.value(null);
        });

        PhotoPickerModal modal = PhotoPickerModal(user: user);
        await modal.imageFromCamera(user);

        verify(serviceMock.uploadImageForUser(user, argThat(isA<File>())))
            .called(1);
      });
    });
  });

  group('Component Tests', () {
    testWidgets('should have Photo Library option',
        (WidgetTester tester) async {
      await tester.pumpWidget(
          createWidgetForTesting(PhotoPickerModal(user: AppUser.mock())));

      expect(find.widgetWithText(ListTile, 'Photo Library'), findsOneWidget);
    });

    testWidgets('should have Camera option', (WidgetTester tester) async {
      await tester.pumpWidget(
          createWidgetForTesting(PhotoPickerModal(user: AppUser.mock())));

      expect(find.widgetWithText(ListTile, 'Camera'), findsOneWidget);
    });
  });
}
