import 'package:ecommerce_app/core/services/home_services.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchScreenViewModel extends GetxController {

  List<ProductModel> _searchedProducts = [];

  List<ProductModel> get searchedProducts => _searchedProducts;

  List<ProductModel> _allProducts = [];
  final searchTextController = TextEditingController();

  SearchScreenViewModel() {

    getProducts();
    update();
  }

  getProducts() async {
    HomeServices().getProducts().then((productsDocs) {
      productsDocs.forEach((document) {
        _allProducts.add(
          ProductModel.fromJson(
            document.data() as Map<dynamic, dynamic>,
          ),
        );
      });
      update();
    });
  }

  void addSearchedFOrItemsToSearchedList(String searchedProduct) {
    _searchedProducts = _allProducts
        .where((character) =>
            character.name!.toLowerCase().startsWith(searchedProduct))
        .toList();
    update();
  }

}
