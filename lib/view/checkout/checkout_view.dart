import 'package:ecommerce_app/view/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../constance.dart';
import '../control_view.dart';
import '../widgets/custom_stepper.dart';
import 'add_address_widget.dart';
import 'delevery_time_widget.dart';
import 'summary_widget.dart';
import 'package:ecommerce_app/core/view_model/checkout_view_model.dart';
import 'package:ecommerce_app/helper/enum.dart';

class CheckoutView extends StatefulWidget {
  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckOutViewModel>(
      init: Get.put(CheckOutViewModel()),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: const Text(
            "CheckOut",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            CustomStepper(
              numberOfActiveStep: controller.index,
            ),
            controller.pages == Pages.DeliveryTime
                ? DeliveryTime()
                : controller.pages == Pages.AddAddress
                    ? AddAddress()
                    : Summary(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                controller.index == 0
                    ? Container()
                    : Container(
                        width: 150,
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: primaryColor)),
                        margin: const EdgeInsets.all(20),
                        child: CustomButton(
                          text: 'Back',
                          color: Colors.white,
                          textColor: primaryColor,
                          onPressed: () {
                            controller.changeIndex(controller.index - 1);
                          },
                        ),
                      ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 180,
                    height: 100,
                    padding: const EdgeInsets.all(20),
                    child: CustomButton(
                      text: controller.index == 2 ? "Finish" : 'Next',
                      onPressed: () {
                        if (controller.index < 2) {
                          controller.changeIndex(controller.index + 1);
                        } else {
                          controller.clearCart();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ControlView()));
                         //Get.offAll(ControlView());
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final _processes = [
  'Delivery',
  'Address',
  'Summer',
];
