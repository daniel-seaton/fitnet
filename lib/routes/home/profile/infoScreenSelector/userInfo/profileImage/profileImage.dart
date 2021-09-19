import 'dart:typed_data';

import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/serviceInjector.dart';
import 'package:fitnet/services/userService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../utils/customColors.dart';
import 'photoPickerModal.dart';

class ProfileImage extends StatelessWidget {
  final UserService userService = injector<UserService>();

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<AppUser>(context);
    return Column(children: [
      FutureProvider.value(
        initialData: Uint8List.fromList([]),
        value: user.profileImageVersion != null && user.profileImageVersion > 0
            ? user.getProfileImage()
            : Future.value(Uint8List.fromList([])),
        child: Consumer<Uint8List>(
          builder: (_, imageBytes, __) => Container(
            height: 190,
            width: 190,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: getProfileImage(imageBytes),
              ),
            ),
          ),
        ),
      ),
      Transform.translate(
        offset: const Offset(50, -40),
        child: RawMaterialButton(
          shape: CircleBorder(),
          fillColor: CustomColors.blue,
          onPressed: () => showPhotoPickerModal(context, user),
          child: Icon(Icons.add_a_photo_outlined, color: CustomColors.white),
        ),
      ),
    ]);
  }

  void showPhotoPickerModal(BuildContext context, AppUser user) =>
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => PhotoPickerModal(user: user));

  ImageProvider getProfileImage(Uint8List bytes) => 
    bytes.length > 0
        ? MemoryImage(bytes)
        : AssetImage('assets/images/default-user.jpg');
}
