import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/serviceInjector.dart';
import 'package:fitnet/services/userService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'photoPickerModal.dart';

class ProfileImage extends StatelessWidget {
  final UserService userService = injector<UserService>();

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<AppUser>(context);
    return Column(children: [
      FutureProvider.value(
        initialData: null,
        value: user.profileImageVersion > 0
            ? userService.getImageDownloadUrl(user.uid)
            : Future.value(null),
        child: Consumer<String>(
          builder: (_, downloadUrl, __) => getProfileImageForUrl(downloadUrl),
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
    ]);
  }

  void showPhotoPickerModal(BuildContext context, AppUser user) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => PhotoPickerModal(user: user));
  }

  Widget getProfileImageForUrl(String downloadUrl) {
    ImageProvider image = downloadUrl != null
        ? NetworkImage(downloadUrl)
        : AssetImage('lib/assets/default-user.jpg');

    return Container(
      height: 190,
      width: 190,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(fit: BoxFit.fill, image: image),
      ),
    );
  }
}
