import 'dart:io';

import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/serviceInjector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';


class PhotoPickerModal extends StatelessWidget {
  final ImagePicker picker = injector<ImagePicker>();
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
    XFile image = await picker.pickImage(
      source: ImageSource.gallery, 
      maxWidth: 190,
      maxHeight: 190,
    );

    File croppedImage = await cropImage(image.path);

    await user.setProfileImage(croppedImage);

    imageCache.clear();
    imageCache.clearLiveImages();
  }

  imageFromCamera(AppUser user) async {
    XFile image = await picker.pickImage(
      source: ImageSource.camera, 
      maxWidth: 190,
      maxHeight: 190,
      preferredCameraDevice: CameraDevice.front
    );
    if (image == null) return;
    
    File croppedImage = await cropImage(image.path);
    if(croppedImage == null) return;

    await user.setProfileImage(croppedImage);

    imageCache.clear();
    imageCache.clearLiveImages();
  }

  Future<File> cropImage(String path) async => ImageCropper.cropImage(
      sourcePath: path,
      maxWidth: 190,
      maxHeight: 190,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      cropStyle: CropStyle.circle
    );
}
