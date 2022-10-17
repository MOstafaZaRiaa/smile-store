import 'package:ecommerce_app/core/view_model/home_view_model.dart';
import 'package:ecommerce_app/view/category_screen.dart';
import 'package:ecommerce_app/view/product_detail_screen.dart';
import 'package:ecommerce_app/view/search_screen.dart';
import 'package:ecommerce_app/view/widgets/custom_text.dart';
import 'package:ecommerce_app/view/widgets/no_internet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';

import '../constance.dart';
import 'best_selling_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      autoRemove: false,
      init: HomeViewModel(),
      builder: (controller) => RefreshIndicator(
        onRefresh: ()async{
          await controller.onRefresh();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'E-commerce',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(() => const SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search_rounded,
                    color: Colors.black,
                  ))
            ],
          ),

          body: OfflineBuilder(
            connectivityBuilder: (
                BuildContext context,
                ConnectivityResult connectivity,
                Widget child,
                ) {
              final bool connected = connectivity != ConnectivityResult.none;

              if (connected) {
                return controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 30.0,
                            left: 10,
                            right: 10,
                          ),
                          child: Column(
                            children: [
                              // _searchTextFormField(),
                              const CustomText(
                                text: 'Categories',
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              _categoriesListView(),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                    text: 'Best Selling',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      //TODO:see all button
                                      Get.to(() => BestSellingScreen(
                                            products: controller.products,
                                          ));
                                    },
                                    child: const CustomText(
                                      text: 'See all',
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              _productsListView(),
                            ],
                          ),
                        ),
                      );
              } else {
                return buildNoInternetWidget(context);
              }
            },
            child: const CircularProgressIndicator(),
          ),










          // body: controller.isLoading.value
          //     ? const Center(
          //         child: CircularProgressIndicator(
          //           color: primaryColor,
          //         ),
          //       )
          //     : SingleChildScrollView(
          //         child: Padding(
          //           padding: const EdgeInsets.only(
          //             top: 30.0,
          //             left: 10,
          //             right: 10,
          //           ),
          //           child: Column(
          //             children: [
          //               // _searchTextFormField(),
          //               const CustomText(
          //                 text: 'Categories',
          //                 color: Colors.black,
          //                 fontSize: 18.0,
          //               ),
          //               const SizedBox(
          //                 height: 30,
          //               ),
          //               _categoriesListView(),
          //               const SizedBox(
          //                 height: 30,
          //               ),
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   const CustomText(
          //                     text: 'Best Selling',
          //                     fontSize: 18.0,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                   InkWell(
          //                     onTap: () {
          //                       //TODO:see all button
          //                       Get.to(() => BestSellingScreen(
          //                             products: controller.products,
          //                           ));
          //                     },
          //                     child: const CustomText(
          //                       text: 'See all',
          //                       fontSize: 16.0,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               const SizedBox(
          //                 height: 30,
          //               ),
          //               _productsListView(),
          //             ],
          //           ),
          //         ),
          //       ),
        ),
      ),
    );
  }

  Widget _categoriesListView() {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => SizedBox(
        height: 100,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            width: 18,
          ),
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => CategoryScreen(
                          title: controller.categories[index].name,
                        ));
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width / 6.3,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: NetworkImage(
                          controller.categories[index].image!,
                        ),
                      ),
                    ),
                  ),
                ),
                CustomText(
                  text: controller.categories[index].name,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _productsListView() {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => SizedBox(
        height: 350,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.products.length,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            width: 15,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(
                  () => ProductDetailScreen(
                    model: controller.products[index],
                  ),
                );
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 220,
                      width: MediaQuery.of(context).size.width * .4,
                      child: Image(
                        image: NetworkImage(
                          controller.products[index].image!,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: controller.products[index].name,
                      fontSize: 16.0,
                      // maxLine: 1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    //description of product
                    CustomText(
                      text: controller.products[index].description,
                      fontSize: 12.0,
                      maxLine: 1,
                      color: greyAccent,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      text: '\$${controller.products[index].price.toString()}',
                      fontSize: 12.0,
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
