import '../../constance.dart';
import '../../model/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../database/cart_database_helper.dart';
import '../../model/cart_product_model.dart';

import '../services/firestore_user_orders.dart';

class CartViewModel extends GetxController {
  CartViewModel._();
  static final CartViewModel cartViewModel = CartViewModel._();

  ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ValueNotifier<bool> get isLoading => _isLoading;

  List<CartProductModel> _allCartProducts = [];
  List<CartProductModel> get allCartProducts => _allCartProducts;

  double _totalPrice = 0.0;

  double get totalPrice => _totalPrice;

  var dbHelper = CartDatabaseHelper.db;

  CartViewModel() {
    getAllProduct();
  }

  getAllProduct() async {
    _isLoading.value = true;
    _allCartProducts = await dbHelper.getAllCartProducts();
    getTotalPrice();
    _isLoading.value = false;
    update();
  }

  addProduct(CartProductModel cartProductModel,BuildContext context) async {
    for (int i = 0; i < _allCartProducts.length; i++) {
      if (_allCartProducts[i].productId == cartProductModel.productId) {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Already in the cart.'),
            backgroundColor: primaryColor,
          ),
        );
      }
    }
    await dbHelper.insert(cartProductModel);
    _allCartProducts.add(cartProductModel);
    _totalPrice +=
        (double.parse(cartProductModel.price!) * cartProductModel.quantity!);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Added to cart.'),
        backgroundColor: primaryColor,
      ),
    );
    update();
  }

  deleteProduct(CartProductModel cartProductModel, BuildContext context) async {
    var dbHelper = CartDatabaseHelper.db;
    await dbHelper.deleteProduct(cartProductModel);
    _allCartProducts.remove(cartProductModel);
    _totalPrice -=
        (double.parse(cartProductModel.price!) * cartProductModel.quantity!);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Deleted.'),
        backgroundColor: primaryColor,
      ),
    );
    update();
  }

  getTotalPrice() {
    for (int i = 0; i < _allCartProducts.length; i++) {
      _totalPrice += (double.parse(allCartProducts[i].price!) *
          allCartProducts[i].quantity!);
    }
    update();
  }

  increaseQuantity(int index) async {
    allCartProducts[index].quantity = allCartProducts[index].quantity! + 1;
    _totalPrice += (double.parse(allCartProducts[index].price!));
    await dbHelper.updateProduct(allCartProducts[index]);
    update();
  }

  decreaseQuantity(int index) async {
    if (allCartProducts[index].quantity! > 1) {
      allCartProducts[index].quantity = allCartProducts[index].quantity! - 1;
      _totalPrice -= (double.parse(allCartProducts[index].price!));
      await dbHelper.updateProduct(allCartProducts[index]);
    }
    update();
  }

  clearCart()async{
    _allCartProducts=[];
    await dbHelper.clearCart();
    update();
  }


}
