
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/order_model.dart';

class FirestoreUserOrders {

  final CollectionReference _userOrders =
      FirebaseFirestore.instance.collection('orders');


  Future<DocumentSnapshot> getUserOrders (String uid)async{
    return _userOrders.doc(uid).get();
  }
  placeNewOrder(OrderModel orderModel,String userId)async{
    final productsNameAndPrice =  storeOrderNameAndPriceOnly(orderModel);
    await _userOrders.doc(userId).update({
      'orders':FieldValue.arrayUnion([
        {
          'userId': userId,
          'timeDate': orderModel.timeDate,
          'address': orderModel.address?.toJson(),
           'products': productsNameAndPrice,
          'totalPrice': orderModel.totalPrice,
        }
      ]),
    });
  }
  List<Map<String,String>> storeOrderNameAndPriceOnly(orderModel){
    List<Map<String,String>> productsNameAndPrice = [];
    for(int i=0 ; i<orderModel.products!.length;i++){
      productsNameAndPrice.add({
        'productName': '${orderModel.products![i].name}',
        'productPrice': '${orderModel.products![i].price}',
      });
    }
    return productsNameAndPrice;
  }
}