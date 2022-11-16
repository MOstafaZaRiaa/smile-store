import 'dart:async';

import '../../constance.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../services/firestore_user.dart';
import '../../helper/local_storage_data.dart';
import '../../model/user_model.dart';

import '../../view/control_view.dart';

class AuthViewModel extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FacebookAuth _facebookLogin = FacebookAuth.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? email, password, name;

  LocalStorageData localStorageData = Get.find();

  // Rx<User> _user = Rx<User>();
  // String get user=>_user.value?.email;
  @override
  void onInit() {
    // _user.bindStream(_auth.userChanges());
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void googleSignInMethod(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logging now....'),
        backgroundColor: primaryColor,
      ),
    );
    GoogleSignInAccount googleUser = (await _googleSignIn.signIn())!;
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    await _auth.signInWithCredential(authCredential).then(
      (userCredential) async {
        saveUser(userCredential);
        Get.offAll(ControlView());
        update();
      },
    );
    update();
  }

  void facebookSignInMethod(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logging now....'),
        backgroundColor: primaryColor,
      ),
    );
    final result = await _facebookLogin.login();
    final OAuthCredential facebookCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);
    if (result.status == LoginStatus.success) {
      await _auth
          .signInWithCredential(facebookCredential)
          .then((userCredential) async {
        await saveUser(userCredential);
      });
      Get.offAll(() => ControlView());
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          result.status.toString(),
        ),
        backgroundColor: Colors.red,
      ),
    );
    update();
  }

  void signInWithEmailAndPassword(BuildContext context) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logging now....'),
          backgroundColor: primaryColor,
        ),
      );
      await _auth
          .signInWithEmailAndPassword(
              email: email!.trim(), password: password!.trim())
          .then((value) async {
        await FireStoreUser()
            .getCurrentUser(_auth.currentUser!.uid)
            .then((value) {
          Object? data = value.data();
          setUser(
            UserModel.fromJson(
              data as Map<dynamic, dynamic>,
            ),
          );
        });
      });
      Get.offAll(
        () => ControlView(),
      );
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
    update();
  }

  void createUserWithEmailAndPassword(BuildContext context) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signing Up now....'),
          backgroundColor: primaryColor,
        ),
      );
      await _auth
          .createUserWithEmailAndPassword(
        email: email!.trim(),
        password: password!.trim(),
      )
          .then((userCredential) async {
        UserModel userData = UserModel(
          userId: userCredential.user!.uid,
          name: name ?? userCredential.user!.displayName,
          email: userCredential.user!.email,
          userPic: '',
        );
        await FireStoreUser().addUserToFireStore(
          userData,
        );
        setUser(userData);
        saveUser(userCredential);
      });
      Get.offAll(
        () => ControlView(),
      );
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
    update();
  }

  Future<void> saveUser(UserCredential userCredential) async {
    UserModel userModel = UserModel(
      userId: userCredential.user!.uid,
      name: name ?? userCredential.user!.displayName,
      email: userCredential.user!.email,
      userPic: '',
    );
    await FireStoreUser()
        .addUserToFireStore(
          userModel,
        )
        .then(
          (value) => {
            setUser(userModel),
          },
        );
    await FireStoreUser().initializeUserCart(userModel);
    update();
  }

  setUser(UserModel userModel) async {
    await localStorageData.setUser(userModel);
    update();
  }
}
