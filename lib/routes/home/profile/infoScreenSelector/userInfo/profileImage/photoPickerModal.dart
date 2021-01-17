import 'dart:io';

import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/serviceInjector.dart';
import 'package:fitnet/services/userService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPickerModal extends StatelessWidget {
  final UserService userService = injector<UserService>();
  final ImagePicker imagePicker = injector<ImagePicker>();
  final AppUser user;

  PhotoPickerModal({@required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Wrap(
          children: <Widget>[
            ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Photo Library'),
                onTap: () {
                  imageFromGallery(user);
                  Navigator.of(context).pop();
                }),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text('Camera'),
              onTap: () {
                imageFromCamera(user);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  imageFromGallery(AppUser user) async {
    PickedFile image = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);

    await userService.uploadImageForUser(user, File(image.path));

    imageCache.clear();
    imageCache.clearLiveImages();
  }

  imageFromCamera(AppUser user) async {
    PickedFile image = await imagePicker.getImage(
        source: ImageSource.camera, imageQuality: 50);

    await userService.uploadImageForUser(user, File(image.path));

    imageCache.clear();
    imageCache.clearLiveImages();
  }
}
