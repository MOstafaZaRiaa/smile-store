import 'package:ecommerce_app/view/profile_screen/profile_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import 'package:ecommerce_app/view/cart_screen.dart';
import 'package:ecommerce_app/view/home_page.dart';

class ControlViewModel extends GetxController {
  ControlViewModel(){
    currentScreen = HomePage();
  }
  ControlViewModel.onStart(){
    currentScreen = HomePage();
  }
  ControlViewModel._();
  static final ControlViewModel controlViewModel = ControlViewModel._();

  int _navigatorValue = 0;
  Widget currentScreen = HomePage();

  get navigatorValue => _navigatorValue;

  List<Widget> screens = [
    HomePage(),
    CartScreen(),
    ProfileScreen(),
  ];

  void changeSelectedValue(int selectedValue) {
    currentScreen = screens[selectedValue];
    update();
  }
}
