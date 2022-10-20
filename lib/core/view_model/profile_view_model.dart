import '../database/cart_database_helper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../helper/local_storage_data.dart';
import '../../model/user_model.dart';
import '../../view/auth/login_screen.dart';
import '../services/firestore_user.dart';
import '../../constance.dart';

class ProfileViewModel extends GetxController {
  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  ValueNotifier _loading = ValueNotifier(false);

  ValueNotifier get loading => _loading;

  final LocalStorageData localStorageData = Get.find();
  FireStoreUser fireStoreUser = FireStoreUser();

  var dbHelper = CartDatabaseHelper.db;

  late String newPassword, newEmail = '', newUsername = '';

  final keyForm = GlobalKey<FormState>();

  final textController = TextEditingController();

  @override
  onInit() {
    getUserData();
    super.onInit();
  }

  getUserData() async {
    _loading.value = true;
    await localStorageData.getUser.then((value) => {
          _userModel = value,
        });
    _loading.value = false;
    update();
  }

  updateUserData(UserModel userModel, BuildContext context) async {
    keyForm.currentState!.save();
    // print(userModel.email);
    try {
      FocusScope.of(context).unfocus();
      final isValid = keyForm.currentState!.validate();
      if (isValid) {
        await fireStoreUser.updateUserInfo(
            userModel: userModel, newEmail: userModel.email!);
        await localStorageData.setUser(userModel);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Your information updated'),
            backgroundColor: primaryColor,
          ),
        );
      }
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.message.toString(),
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
    await getUserData();
    update();
  }

  sendPasswordResetEmail()async{
    String? email  = FirebaseAuth.instance.currentUser!.email!;
    print('email : $email');
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
     const SnackBar(
      content: Text('Reset link sent to your email.'),
      backgroundColor: primaryColor,
    );
  }
  // Future<void> updatePassword(BuildContext context, newPassword) async {
  //   FocusScope.of(context).unfocus();
  //   final isValid = keyForm.currentState!.validate();
  //   keyForm.currentState!.save();
  //   if (isValid && (newPassword == textController.text)) {
  //     try {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Waiting.....'),
  //           backgroundColor: Theme.of(context).colorScheme.secondary,
  //         ),
  //       );
  //       await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Password updated'),
  //           backgroundColor: primaryColor,
  //         ),
  //       );
  //     } on FirebaseException catch (error) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(error.message!),
  //           backgroundColor: Theme.of(context).errorColor,
  //         ),
  //       );
  //     }
  //   }
  //   update();
  // }
  clearCartFromProducts(){
    dbHelper.clearCart();
  }

  signOutOffAll() {
    FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
    localStorageData.deleteUser();
    clearCartFromProducts();
    Get.offAll(
      () => LoginScreen(),
    );
  }
}
