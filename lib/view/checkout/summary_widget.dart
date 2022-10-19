import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../constance.dart';
import '../../core/view_model/cart_view_model.dart';
import '../widgets/custom_text.dart';
import '../../core/view_model/checkout_view_model.dart';

class Summary extends StatelessWidget {
  const Summary({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            GetBuilder<CartViewModel>(
              builder: (controller) => SizedBox(
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 150,
                                width: MediaQuery.of(context).size.width * .4,
                                child: Image(
                                  image: NetworkImage(
                                    controller.allCartProducts[index].image!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                text: controller.allCartProducts[index].name,
                                fontSize: 16.0,
                                // maxLine: 1,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CustomText(
                                text:
                                    '\$${controller.allCartProducts[index].price.toString()}',
                                fontSize: 16.0,
                                color: primaryColor,
                              ),
                            ],
                          ),
                      separatorBuilder: (context, index) {
                        return  const SizedBox(
                          width: 15,
                        );
                      },
                      itemCount: controller.allCartProducts.length),
                ),
              ),
            ),
            const Divider(),
            GetBuilder<CheckOutViewModel>(
              builder: (controller) => Padding(
                padding: const EdgeInsets.all(
                  10,
                ),
                child: Column(
                  children: [
                    const CustomText(
                      text: 'Shipping Address',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: controller.street1! +
                          ',' +
                          controller.street2! +
                          ',' +
                          controller.city! +
                          ',' +
                          controller.state! +
                          ',' +
                          controller.country!,
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
