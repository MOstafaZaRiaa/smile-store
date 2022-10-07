
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:ecommerce_app/model/user_model.dart';

class FireStoreUser {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('users');

  final auth = FirebaseAuth.instance.currentUser;

  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<void> addUserToFireStore(UserModel userModel) async {
    return await _userCollectionRef.doc(userModel.userId).set(
          userModel.toJson(),
        );
  }

  Future<DocumentSnapshot> getCurrentUser(String uid)async{
    return _userCollectionRef.doc(uid).get();
  }

  Future<void> updateUserInfo({required UserModel userModel, required String newEmail})async {
    await auth!.updateEmail(newEmail);
    await _userCollectionRef.doc(userModel.userId).update(userModel.toJson());
  }

  Future<String> uploadImageToFirestore(String uid ,File imageFile)async{

    final firestorePath = firebaseStorage.ref()
        .child('user_image')
        .child(uid + '.jpg');
    await firestorePath.putFile(imageFile);
    final userImageLink = await firestorePath.getDownloadURL();
    await _userCollectionRef.doc(uid).update({
      'userPic':userImageLink,
    });
    //get the link of uploaded image

    return userImageLink;
  }
}
