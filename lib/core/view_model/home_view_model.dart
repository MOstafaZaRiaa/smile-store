import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import '../services/home_services.dart';
import '../../model/category_model.dart';
import '../../model/product_model.dart';

class HomeViewModel extends GetxController {
  ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ValueNotifier<bool> get isLoading => _isLoading;

  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  List _offers = [];
  List get offers => _offers;

  HomeViewModel() {
    getCategory();
    getProducts();
    getOffers();
    update();
  }

  onRefresh()async{
    _categories = [];
    _products = [];
    await getCategory();
    await getProducts();
    await getOffers();
    update();
  }

  getCategory() async {
    _isLoading.value = true;
    HomeServices().getCategories().then((categoriesDocs) {
      for (var document in categoriesDocs) {
        _categories.add(
          CategoryModel.fromJson(
            document.data() as Map<dynamic, dynamic>,
          ),
        );
      }
      update();
      _isLoading.value = false;
    });
  }
  getOffers() async {

    _isLoading.value = true;
    HomeServices().getOffers().then((docs) {
      _offers = docs['offers'];
      // print('getOffers : ${docs['offers']}');
      update();
      _isLoading.value = false;
    });
  }
  getProducts() async {
    _isLoading.value = true;
    HomeServices().getProducts().then((productsDocs) {
      for (var document in productsDocs) {
        _products.add(
          ProductModel.fromJson(
            document.data() as Map<dynamic, dynamic>,
          ),
        );
      }
      update();
      _isLoading.value = false;
    });
  }
}
