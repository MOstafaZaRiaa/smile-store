import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../services/firestore_user.dart';
import '../services/firestore_user_orders.dart';
import '../../model/cart_product_model.dart';
import '../../model/order_model.dart';
import 'package:get/get.dart';

class OrdersHistoryViewModel extends GetxController {
  final userID = FireStoreUser().auth!.uid;
  final firestoreUserOrders = FirestoreUserOrders();

  List<OrderModel> _allOrders = [];
  List<OrderModel> get allOrders => _allOrders;

  ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ValueNotifier<bool> get isLoading => _isLoading;

  OrdersHistoryViewModel(){
    getOrderData();
    update();
  }

  decodeTheDataOfProductOfTheOrder(String ordersData) {
    List<CartProductModel> productslist = [];
    final dataAfterDecode = jsonDecode(ordersData);
    // productslist = [];
    for (int i = 0; i < dataAfterDecode.length; i++) {
      productslist.add(CartProductModel.fromJson(dataAfterDecode[i]));
    }
    return productslist;
  }

  getOrderData() async {
    _allOrders = [];
    _isLoading.value = true;
    DocumentSnapshot ordersDocumentSnapshot =
        await firestoreUserOrders.getUserOrders(userID);
    Map<String, dynamic>? orderData =
        ordersDocumentSnapshot.data() as Map<String, dynamic>?;
    List<dynamic>? orders = orderData!['orders'];

    for (int i = 0; i < orders!.length; i++) {
      decodeTheDataOfProductOfTheOrder(orders[i]['products']);
      _allOrders.add(
        OrderModel(
          orderNo: orders[i]['orderNo'],
          timeDate: orders[i]['timeDate'],
          totalPrice: orders[i]['totalPrice'],
          products: decodeTheDataOfProductOfTheOrder(orders[i]['products']),
          address: Address.fromJson(orders[i]['address']),
        ),
      );
    }
    update();
    _isLoading.value = false;
  }
}
