import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'widgets/custom_text.dart';
import '../constance.dart';
import '../core/view_model/cart_view_model.dart';
import '../model/cart_product_model.dart';
import '../model/product_model.dart';
import 'widgets/custom_button.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel? model;

  const ProductDetailScreen({
    super.key,
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    final deviceWidth = Get.width;
    final deviceHeight = Get.height;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: deviceHeight * 0.3,
                child: Image(
                  image: NetworkImage(model!.image!),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: deviceHeight * 0.12,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomText(
                      text: model!.name,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: deviceWidth * 0.4,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const CustomText(
                                text: 'Size',
                              ),
                              CustomText(
                                text: model!.size,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: deviceWidth * 0.4,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const CustomText(
                                text: 'Colour',
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: model!.color,
                                  border: Border.all(
                                    width: 0.5,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const CustomText(
                      text: 'Details',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomText(
                      text: model!.description,
                      height: 2.4,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: 'PRICE',
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                  CustomText(
                    text: '\$${model!.price}',
                    color: primaryColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
              GetBuilder<CartViewModel>(
                init: CartViewModel(),
                builder: (controller) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: deviceWidth * 0.35,
                  child: CustomButton(
                    text: 'ADD',
                    onPressed: () => controller.addProduct(
                      CartProductModel(
                        name: model!.name,
                        image: model!.image,
                        price: model!.price,
                        productId: model!.productId,
                        quantity: 1,
                      ),
                      context,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
