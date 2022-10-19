import 'dart:io';

import '../services/firestore_user.dart';
import '../../helper/local_storage_data.dart';
import '../../model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../../constance.dart';

class ProfileImageViewModel extends GetxController {
  FireStoreUser fireStoreUser = FireStoreUser();
  LocalStorageData localStorageData = LocalStorageData();
  late File _image;
  final picker = ImagePicker();


  Future getCameraImage(BuildContext context,UserModel userModel) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      var imageLink = await fireStoreUser.uploadImageToFirestore(userModel.userId!, _image);
      localStorageData.setUser(UserModel(
        name: userModel.name,
        email: userModel.email,
        userId: userModel.userId,
        userPic: imageLink,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No image selected.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
    update();
    Navigator.pop(context);
  }

  Future getGalleryImage(BuildContext context, UserModel userModel) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      var imageLink = await fireStoreUser.uploadImageToFirestore(userModel.userId!, _image);
      localStorageData.setUser(UserModel(
        name: userModel.name,
        email: userModel.email,
        userId: userModel.userId,
        userPic: imageLink,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No image selected.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
    updateUserImage(context);
    update();
    Navigator.pop(context);
  }

  updateUserImage(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Your image updated'),
        backgroundColor: primaryColor,
      ),
    );
    update();
  }
}
