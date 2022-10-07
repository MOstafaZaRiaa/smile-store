import 'package:ecommerce_app/core/view_model/profile_image_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ecommerce_app/view/widgets/custom_text.dart';
import 'package:ecommerce_app/constance.dart';
import 'package:ecommerce_app/core/view_model/profile_view_model.dart';
import 'package:ecommerce_app/model/user_model.dart';
import 'change_password_screen.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModel>(
      init: ProfileViewModel(),
      builder: (controller) =>
          Scaffold(
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
              backgroundColor: Theme
                  .of(context)
                  .scaffoldBackgroundColor,
              elevation: 0,
              actions: [
                IconButton(
                    icon: const Icon(
                      Icons.check,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      controller.keyForm.currentState!.save();
                      controller.updateUserData(
                          UserModel(
                            name: controller.newUsername,
                            email: controller.newEmail,
                            userId: controller.userModel!.userId,
                            userPic: controller.userModel!.userPic,
                          ),
                          context);
                    })
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<ProfileImageViewModel>(
                    init: ProfileImageViewModel(),
                    builder: (imageController) =>
                        Stack(
                          children: [
                            controller.userModel!.userPic!.isEmpty
                                ? CircleAvatar(
                              radius: Get.width * .2,
                              backgroundImage:
                              AssetImage('assets/images/dummy_image.png'),
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
                                builder: (BuildContext context) =>
                                    IconButton(
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
                                            return Container(
                                              height:
                                              MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * .25,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ListTile(
                                                    leading: Icon(
                                                      Icons.camera_alt_outlined,
                                                      color: primaryColor,
                                                    ),
                                                    title: Text(
                                                        'Choose from camera'),
                                                    onTap: () {
                                                      imageController
                                                          .getCameraImage(
                                                          context,
                                                          controller.userModel!)
                                                          .then((value) =>
                                                          Navigator.pop(
                                                              context),);
                                                    },
                                                  ),
                                                  ListTile(
                                                    leading: Icon(
                                                      Icons.photo,
                                                      color: primaryColor,
                                                    ),
                                                    title: Text(
                                                        'Choose from gallery'),
                                                    onTap: () {
                                                      imageController
                                                          .getGalleryImage(
                                                          context,
                                                          controller.userModel!)
                                                          .then((value) =>
                                                          Navigator.pop(
                                                              context),);
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
                            decoration: InputDecoration(labelText: 'Username'),
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
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Email'),
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
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {
                               controller.sendPasswordResetEmail();
                                //Get.to(() => ChangePasswordScreen());
                              },
                              child: const Text(
                                'Change your password',
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
