import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constance.dart';
import '../../core/view_model/profile_image_view_model.dart';
import '../../core/view_model/profile_view_model.dart';
import '../../model/user_model.dart';
import '../widgets/custom_text.dart';

class EditProfileScreen extends StatelessWidget {
  FocusNode myFocusNode = FocusNode();

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModel>(
      init: ProfileViewModel(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: const CustomText(
            text: 'Your profile',
            color: Colors.black,
            alignment: Alignment.center,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.check,
                  color: primaryColor,
                ),
                onPressed: () {
                  controller.keyForm.currentState!.save();
                  controller.updateUserData(UserModel(
                        name: controller.newUsername,
                        email: controller.newEmail,
                        userId: controller.userModel!.userId,
                        userPic: controller.userModel!.userPic,
                      ),context,);

                },),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<ProfileImageViewModel>(
                init: ProfileImageViewModel(),
                builder: (imageController) => Stack(
                  children: [
                    controller.userModel!.userPic!.isEmpty
                        ? CircleAvatar(
                            radius: Get.width * .2,
                            backgroundImage: const AssetImage(
                                'assets/images/dummy_image.png'),
                          )
                        : CircleAvatar(
                            radius: Get.width * .2,
                            backgroundImage:
                                NetworkImage(controller.userModel!.userPic!),
                          ),
                    Positioned(
                      right: -2,
                      bottom: 0,
                      child: Builder(
                        builder: (BuildContext context) => IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 30,
                            color: primaryColor,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isDismissible: true,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .25,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: const Icon(
                                          Icons.camera_alt_outlined,
                                          color: primaryColor,
                                        ),
                                        title: const Text('Choose from camera'),
                                        onTap: () {
                                          imageController
                                              .getCameraImage(context,
                                                  controller.userModel!)
                                              .then(
                                                (value) =>
                                                    Navigator.pop(context),
                                              );
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(
                                          Icons.photo,
                                          color: primaryColor,
                                        ),
                                        title:
                                            const Text('Choose from gallery'),
                                        onTap: () {
                                          imageController
                                              .getGalleryImage(context,
                                                  controller.userModel!)
                                              .then(
                                                (value) =>
                                                    Navigator.pop(context),
                                              );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: controller.keyForm,
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: primaryColor,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            color: primaryColor,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                        ),
                        initialValue: controller.userModel!.name,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onSaved: (String? value) {
                          controller.newUsername = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return 'Username can\'t be less 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        cursorColor: primaryColor,

                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: primaryColor,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                        ),
                        initialValue: controller.userModel!.email,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          controller.newEmail = value!.trim();
                        },
                        validator: (value) {
                          if (value!.isEmpty || !(value.contains('@'))) {
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () async {
                            await controller.sendPasswordResetEmail();
                          },
                          child: const Text(
                            'Send email reset password.',
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
