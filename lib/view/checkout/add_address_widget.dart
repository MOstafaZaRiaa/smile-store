import '../../constance.dart';
import '../../model/order_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../core/view_model/checkout_view_model.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_form_field.dart';

import '../profile_screen/shipping_address/shipping_address_screen.dart';

class AddAddress extends StatelessWidget {
  const AddAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<CheckOutViewModel>(
        init: Get.find(),
        builder: (controller) => Form(
          key: controller.formState,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const CustomText(
                    text: 'Billing address is the same as delivery address',
                    fontSize: 14.0,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: ()async{
                        Address result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ShippingAddressScreen(isChoosingAddress: true,)),
                        );
                        print('Address : ${result.toJson()}');
                        controller.street1 = result.street1!;
                        controller.street2 = result.street2!;
                        controller.country = result.country!;
                        controller.city = result.city!;
                        controller.state = result.state!;
                        print('controller.street1 : ${controller.street1}');
                      },
                      child: const Text(
                        'Chose saved address.',
                        style: TextStyle(
                          color: primaryColor,
                        ),
                      )),
                  const SizedBox(
                    height: 20,
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
          ),
        ),
      ),
    );
  }
}
