import '../core/view_model/profile_image_view_model.dart';
import 'package:get/get.dart';

import '../core/view_model/auth_view_model.dart';
import '../core/view_model/cart_view_model.dart';
import '../core/view_model/control_view_model.dart';
import '../core/view_model/home_view_model.dart';
import '../core/view_model/profile_view_model.dart';
import 'local_storage_data.dart';
import '../core/view_model/checkout_view_model.dart';
import '../core/view_model/address_view_model.dart';

import '../core/view_model/orders_history_view_model.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AuthViewModel(),
    );
    Get.lazyPut(
      () => ControlViewModel(),
    );
    Get.lazyPut(
      () => HomeViewModel(),
    );
    Get.lazyPut(
      () => OrdersHistoryViewModel(),
    );
    Get.lazyPut(
      () => CartViewModel(),
    );
    Get.lazyPut(
      () => ProfileImageViewModel(),
    );
    Get.lazyPut(
      () => LocalStorageData(),
    );
    Get.lazyPut(
      () => ProfileViewModel(),
    );
    Get.lazyPut(
      () => CheckOutViewModel(),
    );
    Get.lazyPut(
      () => SavedAddressViewModel(),
    );
  }
}
