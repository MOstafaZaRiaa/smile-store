import 'package:ecommerce_app/model/cart_product_model.dart';
import 'package:flutter/material.dart';
class OrderModel {

  String? userId, timeDate;
  Address? address;
  var totalPrice;
  List<CartProductModel>? products;

  OrderModel({
    this.userId,
    this.timeDate,
    this.address,
    this.products,
    this.totalPrice,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      userId: map['userId'],
      timeDate: map['timeDate'],
      address: map['address'],
      products: map['products'],
      totalPrice: map['totalPrice'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
      'timeDate': this.timeDate,
      'address': this.address,
      'products': this.products,
      'totalPrice': this.products,
    };
  }
}

class Address {
  String? addressId,addressName,street1, street2, city, state, country;

  Address({
    this.addressId,
    this.addressName,
    this.street1,
    this.street2,
    this.city,
    this.state,
    this.country,
  });

  Address.fromJson(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return;
    }
    addressId = map['addressId'];
    addressName = map['addressName'];
    street1 = map['street1'];
    street2 = map['street2'];
    city = map['city'];
    state = map['state'];
    country = map['country'];
  }

  toJson() {
    return {
      'addressId': this.addressId,
      'addressName': this.addressName,
      'street1': this.street1,
      'street2': this.street2,
      'city': this.city,
      'state': this.state,
      'country': this.country,
    };
  }
}
