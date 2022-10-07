import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constance.dart';
import 'package:ecommerce_app/model/user_model.dart';

class LocalStorageData extends GetxController {
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
    prefs.clear();
  }
}
