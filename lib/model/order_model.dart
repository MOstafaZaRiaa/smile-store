import 'cart_product_model.dart';
import 'package:flutter/material.dart';
class OrderModel {

  String? userId, timeDate,orderNo;
  Address? address;
  var totalPrice;
  List<CartProductModel>? products;

  OrderModel({
    this.userId,
    this.orderNo,
    this.timeDate,
    this.address,
    this.products,
    this.totalPrice,
  });

  OrderModel.fromJson(Map<dynamic,dynamic>?map){
    if(map == null){
      return;
    }
    timeDate=map['timeDate'];
    orderNo=map['orderNo'];
    address=map['address'];
    userId=map['userId'];
    totalPrice=map['totalPrice'];
    products=map['products'];
  }



  Map<String, dynamic> toJson() {
    return {
      'userId': this.userId,
      'orderNo': this.orderNo,
      'timeDate': this.timeDate,
      'address': this.address,
      'products': this.products,
      'totalPrice': this.totalPrice,
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
