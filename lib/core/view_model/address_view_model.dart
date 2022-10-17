import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ecommerce_app/constance.dart';
import 'package:ecommerce_app/core/database/address_database_helper.dart';
import 'package:ecommerce_app/model/order_model.dart';

import 'cart_view_model.dart';
import 'checkout_view_model.dart';

class SavedAddressViewModel extends GetxController {
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  ValueNotifier<bool> get isLoading => _isLoading;

  List<Address> _addressModel = [];

  List<Address> get addressModel => _addressModel;

  final bool _isFromCheckOutScreen = false;
  bool get isFromCheckOutScreen => _isFromCheckOutScreen;

  Address? _activeAddress;
  Address? get activeAddress => _activeAddress;

  var dbHelper = AddressDatabaseHelper.db;
  GlobalKey<FormState> formState = GlobalKey();
  late String addressId, addressName, street1, street2, city, state, country;

  SavedAddressViewModel() {
    getAllAddress();
  }

  getAllAddress() async {
    _isLoading.value = true;
    _addressModel = await dbHelper.getAllAddress();
    if (_addressModel.isNotEmpty) {
      _activeAddress = _addressModel[0];
    }
    _isLoading.value = false;
    update();
  }

  generateRandomId() {
    var random = Random.secure();
    var values = List<int>.generate(5, (i) => random.nextInt(255));
    addressId = base64UrlEncode(values);
  }

  setActiveAddress(Address address) {
    _activeAddress = address;
    update();
  }

  saveNewAddress(BuildContext context) {
    formState.currentState!.save();
    generateRandomId();
    FocusScope.of(context).unfocus();
    try {
      if (formState.currentState!.validate()) {
        addAddress(
            Address(
              addressId: addressId,
              addressName: addressName,
              street1: street1,
              street2: street2,
              state: state,
              city: city,
              country: country,
            ),
            context);
      }
      formState.currentState!.reset();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
          backgroundColor: primaryColor,
        ),
      );
    }
  }

  addAddress(Address address, BuildContext context) async {
    var dbHelper = AddressDatabaseHelper.db;
    await dbHelper.insert(address);
    _addressModel.add(address);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Added a new address.'),
        backgroundColor: primaryColor,
      ),
    );
    update();
  }

  deleteAddress(Address address, BuildContext context) async {
    var dbHelper = AddressDatabaseHelper.db;
    await dbHelper.deleteAddress(address);
    _addressModel.remove(address);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Deleted.'),
        backgroundColor: primaryColor,
      ),
    );
    update();
  }
}
