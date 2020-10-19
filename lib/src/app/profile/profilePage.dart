import 'dart:async';
import 'dart:io';

import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/services/authService.dart';
import 'package:fitnet/services/userService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../serviceInjector.dart';

class ProfilePage extends StatelessWidget {
  final AuthService authService = injector<AuthService>();
  final UserService userService = injector<UserService>();
  final String userId;

  ProfilePage({@required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: userService.getUserStream(userId),
      child: Consumer<AppUser>(
        builder: (_, user, __) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${user.firstName} ${user.lastName}',
              style: TextStyle(fontSize: 24),
            ),
            user.profileImageVersion > 0
                ? FutureProvider.value(
                    value: userService.getImageDownloadUrl(user.uid),
                    child: Consumer<String>(
                      builder: (_, downloadUrl, __) => Container(
                          height: 190,
                          width: 190,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(downloadUrl)))),
                    ),
                  )
                : Container(
                    height: 190,
                    width: 190,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('lib/assets/default-user.jpg'),
                      ),
                    ),
                  ),
            Transform.translate(
              offset: const Offset(50, -40),
              child: RawMaterialButton(
                shape: CircleBorder(),
                fillColor: Colors.blue,
                onPressed: () => showPhotoPickerModal(context, user),
                child: Icon(Icons.add_a_photo_outlined, color: Colors.white),
              ),
            ),
            Text(userHeightAndWeight(user)),
            ElevatedButton(
              onPressed: () => authService.signOut(),
              child: Text('Log Out'),
            )
          ],
        ),
      ),
    );
  }

  String userHeightAndWeight(AppUser user) {
    String ft = '?';
    String inches = '?';
    String weight = '???';
    if (user.height != null) {
      ft = '${(user.height ~/ 12).toString()}';
      inches = '${(user.height % 12).toString()}';
    }

    if (user.weightLogs.length > 0) {
      weight = '${user.weightLogs[0].weight.toString()}';
    }

    return 'Height: $ft\'$inches" Weight: ${weight}lbs';
  }

  void showPhotoPickerModal(context, AppUser user) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
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
        });
  }

  imageFromGallery(AppUser user) async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    await userService.uploadImageForUser(user, File(image.path));

    imageCache.clear();
    imageCache.clearLiveImages();
  }

  imageFromCamera(AppUser user) async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);

    await userService.uploadImageForUser(user, File(image.path));

    imageCache.clear();
    imageCache.clearLiveImages();
  }
}
