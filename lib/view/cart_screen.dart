import 'package:ecommerce_app/view/checkout/checkout_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/state_manager.dart';

import '../constance.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text.dart';
import 'package:ecommerce_app/core/view_model/cart_view_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
      init: CartViewModel(),
      builder: (controller) => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : controller.allCartProducts.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.4,
                      width: MediaQuery.of(context).size.width*0.4,
                      child: SvgPicture.asset(
                        'assets/images/empty_cart.svg',
                      ),
                    ),
                  ),
                )
              : Scaffold(
                  body: Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 15,
                          ),
                          child: ListView.separated(
                            itemCount: controller.allCartProducts.length,
                            separatorBuilder:
                                (BuildContext context, int index) => const SizedBox(
                              height: 15,
                            ),
                            itemBuilder: (BuildContext context, int index) =>
                                Dismissible(
                              direction: DismissDirection.endToStart,
                              key: Key(
                                controller.allCartProducts[index].productId!,
                              ),
                              onDismissed: (dismissDirection) {
                                controller.deleteProduct(
                                    controller.allCartProducts[index],
                                    context);
                              },
                              background: Container(
                                color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.delete_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                                alignment: Alignment.centerRight,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            controller
                                                .allCartProducts[index].image!,
                                          ),
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: controller
                                              .allCartProducts[index].name,
                                          fontSize: 16.0,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomText(
                                          text:
                                              '\$${controller.allCartProducts[index].price.toString()}',
                                          fontSize: 16.0,
                                          color: primaryColor,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                child: Container(
                                                  child: Icon(Icons.add),
                                                ),
                                                onTap: () {
                                                  controller
                                                      .increaseQuantity(index);
                                                },
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              CustomText(
                                                text: controller
                                                    .allCartProducts[index]
                                                    .quantity
                                                    .toString(),
                                                alignment: Alignment.center,
                                                fontSize: 16.0,
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              InkWell(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 15.0),
                                                  child: Icon(
                                                      Icons.minimize_rounded),
                                                ),
                                                onTap: () {
                                                  controller
                                                      .decreaseQuantity(index);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
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
                                text: 'CHECKOUT',
                                fontSize: 12.0,
                                color: Colors.grey,
                              ),
                              CustomText(
                                text: '\$${controller.totalPrice}',
                                color: primaryColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              )
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: CustomButton(
                              text: 'ADD',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckoutView(),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }
}
