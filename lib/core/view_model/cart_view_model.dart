import 'package:ecommerce_app/constance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ecommerce_app/core/database/cart_database_helper.dart';
import 'package:ecommerce_app/model/cart_product_model.dart';

class CartViewModel extends GetxController {
  CartViewModel._();
  static final CartViewModel cartViewModel = CartViewModel._();

  ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ValueNotifier<bool> get isLoading => _isLoading;

  List<CartProductModel> _cartProductModel = [];
  List<CartProductModel> get cartProductModel => _cartProductModel;

  double _totalPrice = 0.0;

  double get totalPrice => _totalPrice;

  var dbHelper = CartDatabaseHelper.db;

  CartViewModel() {
    getAllProduct();
  }

  getAllProduct() async {
    _isLoading.value = true;
    _cartProductModel = await dbHelper.getAllProduct();
    getTotalPrice();
    _isLoading.value = false;
    update();
  }

  addProduct(CartProductModel cartProductModel,BuildContext context) async {
    for (int i = 0; i < _cartProductModel.length; i++) {
      if (_cartProductModel[i].productId == cartProductModel.productId) {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Already in the cart.'),
            backgroundColor: primaryColor,
          ),
        );
      }
    }
    await dbHelper.insert(cartProductModel);
    _cartProductModel.add(cartProductModel);
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
    _cartProductModel.remove(cartProductModel);
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
    for (int i = 0; i < _cartProductModel.length; i++) {
      _totalPrice += (double.parse(cartProductModel[i].price!) *
          cartProductModel[i].quantity!);
    }
    update();
  }

  increaseQuantity(int index) async {
    cartProductModel[index].quantity = cartProductModel[index].quantity! + 1;
    _totalPrice += (double.parse(cartProductModel[index].price!));
    await dbHelper.updateProduct(cartProductModel[index]);
    update();
  }

  decreaseQuantity(int index) async {
    if (cartProductModel[index].quantity! > 1) {
      cartProductModel[index].quantity = cartProductModel[index].quantity! - 1;
      _totalPrice -= (double.parse(cartProductModel[index].price!));
      await dbHelper.updateProduct(cartProductModel[index]);
    }
    update();
  }

  clearCart()async{
    _cartProductModel=[];
    await dbHelper.clearCart();
    update();
  }
}
