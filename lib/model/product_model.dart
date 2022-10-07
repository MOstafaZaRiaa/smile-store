import 'dart:ui';

import 'package:ecommerce_app/helper/color_extension.dart';

class ProductModel {
  String? name, price, size, description,productId,category, image;
  Color? color;

  ProductModel({
    this.name,
    this.price,
    this.size,
    this.description,
    this.image,
    this.color,
    this.category,
    this.productId,
  });
  ProductModel.fromJson(Map<dynamic,dynamic>?map){
    if(map == null){
      return;
    }
    name=map['name'];
    price=map['price'];
    size=map['size'];
    description=map['description'];
    image=map['image'];
    category=map['category'];
    productId=map['productId'];
    color=HexColor.fromHex(map['color']);
  }
  toJson(){
   return{
     'name':name,
     'price':price,
     'size':size,
     'description':description,
     'color':color,
     'image':image,
     'category':category,
     'productId':productId,
   };
  }
}
