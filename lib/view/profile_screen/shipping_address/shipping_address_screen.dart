import 'package:ecommerce_app/model/order_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ecommerce_app/view/widgets/custom_text.dart';
import 'package:ecommerce_app/view/widgets/custom_button.dart';
import 'package:ecommerce_app/core/view_model/address_view_model.dart';
import 'package:ecommerce_app/view/profile_screen/shipping_address/add_new_address.dart';
import '../../../constance.dart';

class ShippingAddressScreen extends StatelessWidget {
  const ShippingAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: const CustomText(
          text: 'Shipping Address',
          color: Colors.black,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: GetBuilder<SavedAddressViewModel>(
          init: SavedAddressViewModel(),
          builder: (controller) => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.addressModel.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Image.asset(
                                'assets/location.gif',
                              ),
                            ),
                            ElevatedButton(
                              child: const Text('Add address'),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  primaryColor,
                                ),
                              ),
                              onPressed: () {
                                Get.to(() => AddNewAddress());
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        GetBuilder<SavedAddressViewModel>(
                          init: SavedAddressViewModel(),
                          builder: (controller) => Expanded(
                            child: ListView.separated(
                              itemCount: controller.addressModel.length,
                              separatorBuilder:
                                  (BuildContext context, int index) => Column(
                                children: const [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    RadioListTile<Address>(
                                      value: controller.addressModel[index],
                                      groupValue: controller.activeAddress,
                                      onChanged: (Address? value) {
                                        controller.setActiveAddress(value!);
                                      },
                                      title: CustomText(
                                        text: controller
                                            .addressModel[index].addressName,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      subtitle: CustomText(
                                        text:
                                            '${controller.addressModel[index].addressName}, ${controller.addressModel[index].street1}, ${controller.addressModel[index].street2}, ${controller.addressModel[index].city}, ${controller.addressModel[index].state}, ${controller.addressModel[index].country}',
                                        fontSize: 14.0,
                                      ),
                                      activeColor: primaryColor,
                                    ),
                                    TextButton(
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: primaryColor),
                                      ),
                                      onPressed: () {
                                        controller.deleteAddress(
                                            controller.addressModel[index],
                                            context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 180,
                              height: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: primaryColor)),
                              margin: const EdgeInsets.all(20),
                              child: CustomButton(
                                text: 'chose',
                                color: Colors.white,
                                textColor: primaryColor,
                                onPressed: () {},
                              ),
                            ),
                            Container(
                              width: 180,
                              height: 100,
                              margin: const EdgeInsets.only(
                                right: 20,
                                bottom: 10,
                              ),
                              child: CustomButton(
                                text: 'New',
                                color: primaryColor,
                                onPressed: () {
                                  Get.to(() => AddNewAddress());
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
