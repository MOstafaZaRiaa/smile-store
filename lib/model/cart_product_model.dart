class CartProductModel {
  String? name, price, image, productId;
  int? quantity;

  CartProductModel({
    this.name,
    this.price,
    this.quantity,
    this.productId,
    this.image,
  });
  CartProductModel.fromJson(Map<dynamic, dynamic> map) {
    if (map.isEmpty) {
      return;
    }
    name = map['name'];
    price = map['price'];
    image = map['image'];
    quantity = map['quantity'];
    productId = map['productId'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'image': image,
      'productId': productId,
      'quantity': quantity,
    };
  }
}
