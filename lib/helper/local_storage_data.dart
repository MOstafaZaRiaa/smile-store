import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constance.dart';
import '../model/user_model.dart';

class LocalStorageData extends GetxController {
  ValueNotifier<bool> _isUseForApp = ValueNotifier(false);
  ValueNotifier<bool> get isUseForApp => _isUseForApp;

  LocalStorageData(){
    checkIfFirstAppUse();
  }

  Future<UserModel?> get getUser async {
    try {
      UserModel userModel = await getUserData();
      if (userModel == null) {
        return null;
      } else {
        return userModel;
      }
    } catch (error) {
      print(error.toString());
    }
  }

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(CACHED_USER_DATA)!;
    return UserModel.fromJson(jsonDecode(data));
  }

  setUser(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      CACHED_USER_DATA,
      json.encode(
        userModel.toJson(),
      ),
    );
  }

  deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(CACHED_USER_DATA);
  }

  // return value of first use of app
   checkIfFirstAppUse() async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     var isFirstUse = prefs.getBool(cachedFirstUse);
    try {
      if (isFirstUse == null) {
        _isUseForApp.value = true;
        update();
      } else {
        _isUseForApp.value =  false;
        update();
      }
    } catch (error) {
      print(error.toString());
    }
  }


  //to set the app used for more than one time
  setTheAppUsedManyTimes()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(cachedFirstUse,false);
  }
}
