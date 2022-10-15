
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/order_model.dart';

class FirestoreUserOrders {

  final CollectionReference _userOrders =
      FirebaseFirestore.instance.collection('orders');


  Future<DocumentSnapshot> getUserOrders (String uid)async{
    return _userOrders.doc(uid).get();
  }


  placeNewOrder(OrderModel orderModel,String userId)async{
    await _userOrders.doc(userId).update({
      'orders':FieldValue.arrayUnion([
        {
          'userId': userId,
          'orderNo': 'EC-${generateOrderNumber()}',
          'timeDate': orderModel.timeDate,
          'address': orderModel.address?.toJson(),
          'products': jsonEncode(orderModel.products),
          'totalPrice': orderModel.totalPrice,
        }
      ]),
    });
  }

  int generateOrderNumber(){
    return Random().nextInt(10000000);
  }

}