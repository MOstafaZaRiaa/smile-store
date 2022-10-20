import '../../../core/view_model/address_view_model.dart';
import '../../widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_form_field.dart';

import '../../../constance.dart';

class AddNewAddress extends StatelessWidget {
  const AddNewAddress({super.key});

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
          text: 'New Shipping Address',
          color: Colors.black,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<SavedAddressViewModel>(
          init: SavedAddressViewModel(),
          builder: (controller) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Form(
                  key: controller.formState,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        text: 'Address name',
                        hintText: 'Home Address',
                        onSave: (value) {
                          controller.addressName = value;
                        },
                        onValidate: (value) {
                          if (value.isEmpty) {
                            return 'This field can\'t be empty.';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomTextFormField(
                        text: 'Street 1',
                        hintText: '21, Alex Davidson Avenue',
                        onSave: (value) {
                          controller.street1 = value;
                        },
                        onValidate: (value) {
                          if (value.isEmpty) {
                            return 'This field can\'t be empty.';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomTextFormField(
                        text: 'Street 2',
                        hintText: 'Opposite Omegatron, Vicent Quarters',
                        onSave: (value) {
                          controller.street2 = value;
                        },
                        onValidate: (value) {
                          if (value.isEmpty) {
                            return 'This field can\'t be empty.';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomTextFormField(
                        text: 'City',
                        hintText: 'Victoria Island',
                        onSave: (value) {
                          controller.city = value;
                        },
                        onValidate: (value) {
                          if (value.isEmpty) {
                            return 'This field can\'t be empty.';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: CustomTextFormField(
                                text: 'State',
                                hintText: 'Lagos State',
                                onSave: (value) {
                                  controller.state = value;
                                },
                                onValidate: (value) {
                                  if (value.isEmpty) {
                                    return 'This field can\'t be empty.';
                                  }
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: CustomTextFormField(
                              text: 'Country',
                              hintText: 'Nigeria',
                              onSave: (value) {
                                controller.country = value;
                              },
                              onValidate: (value) {
                                if (value.isEmpty) {
                                  return 'This field can\'t be empty.';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: 20,
                    bottom: 10,
                    top: 40,
                    left: MediaQuery.of(context).size.width * .6,
                  ),
                  child: CustomButton(
                    text: 'ADD',
                    color: primaryColor,
                    onPressed: () {
                      controller.saveNewAddress(context);
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
