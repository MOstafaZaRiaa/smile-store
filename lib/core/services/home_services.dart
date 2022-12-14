import 'package:cloud_firestore/cloud_firestore.dart';

class HomeServices {
  final CollectionReference _categoryCollectionReference =
  FirebaseFirestore.instance.collection('Categories');
  final CollectionReference _productsCollectionReference =
  FirebaseFirestore.instance.collection('Products');
  final CollectionReference _offersCollectionReference =
  FirebaseFirestore.instance.collection('offers');

  Future<List<QueryDocumentSnapshot>> getCategories() async {
    var value = await _categoryCollectionReference.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getProducts() async {
    var value = await _productsCollectionReference.get();
    return value.docs;
  }
  Future<List<QueryDocumentSnapshot>> getProductsByCategory(String category) async {
    var value = await _productsCollectionReference.where('category', isEqualTo: category).get();
    return value.docs;
  }
  Future<DocumentSnapshot> getOffers() async {
    var value = await _offersCollectionReference.doc('offers').get();
    return value;
  }

}
