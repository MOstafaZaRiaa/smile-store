import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../constance.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/view/product_detail_screen.dart';
import 'package:ecommerce_app/view/widgets/custom_text.dart';

class BestSellingScreen extends StatelessWidget {
  final List<ProductModel> products;

  const BestSellingScreen({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined,color: Colors.black,),
            onPressed: () {
              Get.back();
            },
          ),
          title:const CustomText(
            text: "Best Selling",
            color: Colors.black,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,

        ),
        body: SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 0.9),
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(
                      () => ProductDetailScreen(
                        model: products[index],
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 220,
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              products[index].image!,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: products[index].name,
                          fontSize: 16.0,
                          // maxLine: 1,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        //description of product
                        CustomText(
                          text: products[index].description,
                          fontSize: 12.0,
                          maxLine: 1,
                          color: greyAccent,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomText(
                          text: '\$${products[index].price.toString()}',
                          fontSize: 16.0,
                          color: primaryColor,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    ));
  }
}
