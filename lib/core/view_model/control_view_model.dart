import 'package:ecommerce_app/view/profile_screen/profile_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import 'package:ecommerce_app/view/cart_screen.dart';
import 'package:ecommerce_app/view/home_page.dart';

class ControlViewModel extends GetxController {

  ControlViewModel._();
  ControlViewModel(){

  }
  static final ControlViewModel cartViewModel = ControlViewModel._();
  @override
  void onInit() {
    _navigatorValue = 0;
    super.onInit();
  }
  @override
  void dispose() {
    _navigatorValue = 0;
    super.dispose();
  }

  int _navigatorValue = 0;
  Widget currentScreen = HomePage();

  get navigatorValue => _navigatorValue;

  List<Widget> screens = [
    HomePage(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete => super.onDelete;

  void changeSelectedValue(int selectedValue) {
    currentScreen = screens[selectedValue];
    update();
  }
}
