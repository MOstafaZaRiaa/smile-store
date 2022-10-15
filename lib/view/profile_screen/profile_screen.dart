import 'package:ecommerce_app/view/profile_screen/edit_profile_screen.dart';
import 'package:ecommerce_app/view/profile_screen/shipping_address/shipping_address_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ecommerce_app/core/view_model/profile_view_model.dart';
import 'package:ecommerce_app/view/widgets/custom_text.dart';

import '../../core/view_model/orders_history_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModel>(
      init: ProfileViewModel(),
      builder: (controller) => Scaffold(
        body: controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                body: Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    right: 20,
                    left: 20,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        UserInfo(
                          controller: controller,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        MenuListTile(
                          iconPath: 'assets/menu_icons/Icon_Edit-Profile.png',
                          tileText: 'Edit Profile',
                          onPressed: () {
                            Get.to(() => EditProfileScreen());
                          },
                        ),
                        MenuListTile(
                          iconPath: 'assets/menu_icons/Icon_Location.png',
                          tileText: 'Shipping Address',
                          onPressed: () {
                            Get.to(ShippingAddressScreen());
                          },
                        ),
                        MenuListTile(
                          iconPath: 'assets/menu_icons/Icon_History.png',
                          tileText: 'Order History',
                          onPressed: () {
                            Get.lazyPut(() => OrdersHistoryViewModel());
                            final cartViewModel =
                                Get.find<OrdersHistoryViewModel>();
                            cartViewModel.getOrderData();
                          },
                        ),
                        MenuListTile(
                          iconPath: 'assets/menu_icons/Icon_Payment.png',
                          tileText: 'Cards',
                          onPressed: () {},
                        ),
                        MenuListTile(
                          iconPath: 'assets/menu_icons/Icon_Alert.png',
                          tileText: 'Notifications',
                          onPressed: () {},
                        ),
                        MenuListTile(
                          iconPath: 'assets/menu_icons/Icon_Exit.png',
                          tileText: 'Log Out',
                          onPressed: () {
                            controller.signOutOffAll();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  final ProfileViewModel controller;
  const UserInfo({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 50.0,
          backgroundImage: controller.userModel!.userPic!.isEmpty
              ? const NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/e-commerce-59a62.appspot.com/o/dummy_image.png?alt=media&token=c21b4644-8e5b-4215-8aa6-f1980ab64773')
              : NetworkImage('${controller.userModel?.userPic}'),
        ),
        const SizedBox(
          width: 50,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(
              text: controller.userModel?.name,
              fontSize: 20.0,
            ),
            CustomText(
              text: controller.userModel?.email,
            ),
          ],
        ),
      ],
    );
  }
}

class MenuListTile extends StatelessWidget {
  final String? iconPath;
  final String? tileText;
  final Function? onPressed;

  const MenuListTile({this.iconPath, this.tileText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: onPressed as void Function()?,
        leading: Image.asset(iconPath!),
        title: CustomText(
          text: tileText,
        ),
        trailing: Icon(Icons.navigate_next_rounded),
      ),
    );
  }
}
