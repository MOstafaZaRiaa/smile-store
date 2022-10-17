import 'package:ecommerce_app/core/view_model/cart_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ecommerce_app/helper/enum.dart';
import 'package:ecommerce_app/view/control_view.dart';

import '../../model/order_model.dart';
import '../database/cart_database_helper.dart';
import '../services/firestore_user_orders.dart';
import 'control_view_model.dart';

class CheckOutViewModel extends GetxController {
  int _index = 0;

  int get index => _index;

  Pages _pages = Pages.DeliveryTime;

  Pages get pages => _pages;

  var dbHelper = CartDatabaseHelper.db;

   late String street1,street2,city,state,country;


  GlobalKey<FormState> formState = GlobalKey();
  ControlViewModel controlViewModel = ControlViewModel();

  changeIndex(int i,) {
    if(i==0||i<0){
      _pages = Pages.DeliveryTime;
      _index=i;
    }
    if (i == 1) {
      _index = i;
      _pages = Pages.AddAddress;
    } else if (i == 2) {

      if(street1.isEmpty){
        formState.currentState!.save();
        if(formState.currentState!.validate()||street1.length>2){
          _index = i;
          _pages = Pages.Summary;
        }
      }


      if(street1.isNotEmpty){
        _index = i;
        _pages = Pages.Summary;
      }
    } else if (i == 3) {
      _pages = Pages.DeliveryTime;
      Get.offAll(() => const ControlView());
    }
    update();
  }


  Future placeOrder()async{
    final address = Address(
      street1: street1,
      street2: street2,
      state: state,
      city: city,
      country: country,
    );
    Get.lazyPut(()=>CartViewModel());
    final cartViewModel = Get.find<CartViewModel>();
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final timeNow = DateTime.now().toIso8601String().toString();
    final allCartProducts =cartViewModel.allCartProducts;
    final totalPrice = cartViewModel.totalPrice;

    final newOrder = OrderModel(
      userId: userId,
      timeDate: timeNow,
      address: address,
        products : allCartProducts,
      totalPrice: totalPrice,
    );
    await FirestoreUserOrders().placeNewOrder(newOrder, userId);
    update();
  }

  clearCart()async{
    await dbHelper.clearCart();
    Get.delete<ControlViewModel>();
    Get.delete<CartViewModel>();
    update();
  }
}
